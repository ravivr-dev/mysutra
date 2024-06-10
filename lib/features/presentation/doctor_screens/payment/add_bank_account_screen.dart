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
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_fund_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/create_payout_contact.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/bank_account_cubit.dart';

class AddBankAccountScreen extends StatefulWidget {
  final bool showBasicDetails;
  const AddBankAccountScreen({super.key, required this.showBasicDetails});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ifscCtrl = TextEditingController();
  final TextEditingController _accountCtrl = TextEditingController();
  final TextEditingController _confirmAccountCtrl = TextEditingController();

  String? _validateIFSC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter IFSC code';
    }
    final regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid IFSC code';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: component.text(context.stringForKey(StringKeys.addBankAccount)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: BlocConsumer<BankAccountCubit, BankAccountState>(
            listener: (_, state) {
              if (state is BankAccountContactAdd) {
                _.read<BankAccountCubit>().createAccount(
                    CreateFundAccountParams(
                        name: _nameCtrl.text,
                        ifsc: _ifscCtrl.text,
                        accountNumber: _accountCtrl.text));
              } else if (state is BankAccountBankAdd) {
                widget.showSuccessToast(
                    context: context, message: 'Account Added Successfully');
                Navigator.pop(context);
              } else if (state is BankAccountError) {
                widget.showErrorToast(context: context, message: state.error);
              }
            },
            builder: (_, state) {
              BankAccountCubit cubit = _.read<BankAccountCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  _title('Account information'),
                  if (!widget.showBasicDetails) ...[
                    TextFormFieldWidget(
                      title: 'Account Name',
                      controller: _nameCtrl,
                      validator: validateName,
                    ),
                    const SizedBox(height: 5),
                  ],
                  TextFormFieldWidget(
                    title: 'IFSC Code',
                    controller: _ifscCtrl,
                    validator: _validateIFSC,
                  ),
                  const SizedBox(height: 5),
                  TextFormFieldWidget(
                    title: 'Account number',
                    controller: _accountCtrl,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a bank account number';
                      } else if (value.length < 8 || value.length > 20) {
                        return 'Bank account number must be between 8 and 20 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormFieldWidget(
                    title: 'Confirm Account number',
                    textInputType: TextInputType.number,
                    controller: _confirmAccountCtrl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please confirm your account number';
                      }
                      if (value != _accountCtrl.text) {
                        return 'Account numbers do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
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
                          cubit.createAccount(CreateFundAccountParams(
                              name: _nameCtrl.text,
                              ifsc: _ifscCtrl.text,
                              accountNumber: _accountCtrl.text));
                        }
                      }
                    },
                    text: 'Add Bank Account',
                  )
                ],
              );
            },
          ),
        ),
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
