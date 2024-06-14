import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_small_outline_button.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';

class ChangeDataScreen extends StatefulWidget {
  const ChangeDataScreen({super.key, required this.args});

  final ChangeDataParams args;

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreenState();
}

class _ChangeDataScreenState extends State<ChangeDataScreen> {
  final TextEditingController _ccCtrl = TextEditingController();
  final TextEditingController _valCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showOTP = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _ccCtrl.dispose();
    _valCtrl.dispose();
    _otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangeEmailLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          showOTP = true;
          _stopLoading();
        }
        if (state is ChangePhoneNumberLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          showOTP = true;
          _stopLoading();
        }
        if (state is VerifyChangeLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          // showOTP = false;
          // AiloitteNavigation.intent(context, AppRoutes.homeRoute);
          Navigator.of(context).pop();
        } else if (state is VerifyChangeErrorState) {
          widget.showErrorToast(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: widget.args.isEmail
                ? component
                    .text(context.stringForKey(StringKeys.changeEmailAddress))
                : component
                    .text(context.stringForKey(StringKeys.changeMobileNumber)),
            centerTitle: true,
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: showOTP
                ? CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.args.isEmail) {
                          context.read<ProfileCubit>().verifyChangeEmail(
                              otp: int.tryParse(_otpCtrl.text)!);
                        } else {
                          context.read<ProfileCubit>().verifyChangePhoneNumber(
                              otp: int.tryParse(_otpCtrl.text)!);
                        }
                      }
                    },
                  )
                : CustomSmallOutlineButton(
                    text: 'Send OTP',
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.args.isEmail) {
                          context
                              .read<ProfileCubit>()
                              .changeEmail(newEmail: _valCtrl.text);
                        } else {
                          context.read<ProfileCubit>().changePhoneNumber(
                              cc: _ccCtrl.text,
                              phoneNumber: int.tryParse(_valCtrl.text)!);
                        }
                        _startLoading();
                      }
                    },
                  ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (widget.args.isEmail)
                    TextFormFieldWidget(
                      title: 'Enter new email address',
                      fillColor: AppColors.white,
                      filled: true,
                      borderRadius: 90,
                      horizontalContentPadding: 34,
                      verticalContentPadding: 22,
                      controller: _valCtrl,
                      style: theme.publicSansFonts.regularStyle(
                        fontSize: 16,
                      ),
                      validator: (value) => value.isEmpty
                          ? 'Please Enter Email'
                          : !value.isValidEmail
                              ? 'Please Enter Valid Email'
                              : null,
                    )
                  else
                    TextFormWithCountryCode(
                      title: "Enter new mobile number",
                      fillColor: AppColors.white,
                      filled: true,
                      countryCode: _ccCtrl,
                      controller: _valCtrl,
                      verticalContentPadding: 23,
                      borderRadius: 90,
                      textStyle:
                          theme.publicSansFonts.regularStyle(fontSize: 16),
                    ),
                  component.spacer(
                    height: 12,
                  ),
                  if (showOTP)
                    TextFormFieldWidget(
                      title: "Enter OTP Sent to  ${_valCtrl.text}",
                      fillColor: AppColors.white,
                      borderRadius: 90,
                      horizontalContentPadding: 34,
                      verticalContentPadding: 22,
                      textInputType: TextInputType.number,
                      filled: true,
                      controller: _otpCtrl,
                      autoFocus: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (value) {
                        if (value.length != 4) {
                          return 'OTP must be exactly 4 digits';
                        }
                        return null;
                      },
                      style: theme.publicSansFonts.regularStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }
}

class ChangeDataParams {
  ChangeDataParams(this.isEmail);

  final bool isEmail;
}
