import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_payout_contact.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/bank_account_cubit.dart';

class AddUpiIdScreen extends StatefulWidget {
  final bool showBasicDetails;
  const AddUpiIdScreen({super.key, required this.showBasicDetails});

  @override
  State<AddUpiIdScreen> createState() => _AddUpiIdScreenState();
}

class _AddUpiIdScreenState extends State<AddUpiIdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _upiCtrl = TextEditingController();

  String? validateUPI(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter UPI ID';
    }
    String pattern = r'^[\w.\-]{2,256}@[a-zA-Z]{2,64}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter valid UPI ID';
    }
    return null;
  }


  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    // Regular expression to validate name (only alphabets and spaces, min 2 characters)
    String pattern = r'^[a-zA-Z\s]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid name (only alphabets and spaces)';
    }
    return null;
  }

  @override
  void dispose() {
    _countryCode.dispose();
    _mobCtrl.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _upiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: component.text(context.stringForKey(StringKeys.addUpiId)),
      ),
      body: BlocConsumer<BankAccountCubit, BankAccountState>(
        listener: (_, state) {
          if (state is BankAccountContactAdd) {
            _.read<BankAccountCubit>().addUpi(_upiCtrl.text);
          } else if (state is BankAccountUpiAdd) {
            widget.showSuccessToast(
                context: context, message: 'UPI Id Added Successfully');
            AiloitteNavigation.back(context);
          } else if (state is BankAccountError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (_, state) {
          BankAccountCubit cubit = _.read<BankAccountCubit>();
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  if (widget.showBasicDetails) ...[
                    _title('Basic details'),
                    TextFormFieldWidget(
                      title: 'Full name',
                      controller: _nameCtrl,
                      validator: validateName,
                    ),
                    const SizedBox(height: 5),
                    TextFormWithCountryCode(
                      title: context.stringForKey(StringKeys.mobileNumber),
                      countryCode: _countryCode,
                      controller: _mobCtrl,
                      fillColor: AppColors.greyD9,
                    ),
                    const SizedBox(height: 5),
                    TextFormFieldWidget(
                      title: "Email",
                      validator: (value) => value.isEmpty
                          ? 'Please Enter Email'
                          : !value.isValidEmail
                              ? 'Please Enter Valid Email'
                              : null,
                      hintText: 'Enter Email Address',
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                      controller: _emailCtrl,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(height: 20),
                  ],
                  _title('UPI Details'),
                  TextFormFieldWidget(
                    title: 'Add your UPI Handle',
                    controller: _upiCtrl,
                    validator: validateUPI,
                  ),
                  const Spacer(),
                  CustomButton(
                    isLoading: state is BankAccountButtonLoader,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (state is BankAccountContactAdd) {
                        } else if (widget.showBasicDetails) {
                          cubit.addContact(CreatePayoutContactParams(
                              name: _nameCtrl.text,
                              email: _emailCtrl.text,
                              contact: int.parse(
                                  "${_countryCode.text}${_mobCtrl.text}")));
                        } else {
                          cubit.addUpi(_upiCtrl.text);
                        }
                      }
                    },
                    text: 'Add UPI ID',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _title(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.publicSansFonts
              .regularStyle(fontSize: 16, fontColor: AppColors.color0xFF1E293B),
        ),
        const Divider(color: AppColors.color0xFFDDDDDD),
        const SizedBox(height: 5)
      ],
    );
  }
}
