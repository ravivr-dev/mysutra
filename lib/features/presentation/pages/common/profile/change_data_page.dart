import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_otp_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_usecase.dart';
import 'package:my_sutra/features/presentation/pages/common/profile/cubit/profile_cubit.dart';

class ChangeDataPage extends StatefulWidget {
  const ChangeDataPage({super.key, required this.data});

  final UpdateProfileParams data;

  @override
  State<ChangeDataPage> createState() => _ChangeDataPageState();
}

class _ChangeDataPageState extends State<ChangeDataPage> {
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _valCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();
  bool showOtpField = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit cubit = context.read<ProfileCubit>();
        return Scaffold(
          backgroundColor: AppColors.greyF3,
          appBar: CustomAppBar(
            isTransparentAppbar: true,
            title: widget.data.isEmail
                ? 'Change email address'
                : 'Change mobile number',
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: CustomButton(
              text: showOtpField ? "Confirm" : "Send OTP",
              onPressed: () {
                if(showOtpField) {
                  if(widget.data.isEmail) {
                    cubit.changePhoneOtp(ChangeOtpParams(otp: int.tryParse(_otpCtrl.text)!));
                  } else {
                    cubit.changeEmailOtp(ChangeOtpParams(otp: int.tryParse(_otpCtrl.text)!));
                  }
                } else {
                  if(widget.data.isEmail) {
                    cubit.changeEmail(ChangeEmailParams(email: _valCtrl.text));
                  } else {
                    cubit.changePhone(ChangePhoneParams(countryCode: _countryCtrl.text, phoneNumber: int.tryParse(_valCtrl.text)!));
                  }
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.data.isEmail)
                  TextFormWithCountryCode(
                    title: "Enter new mobile number",
                    countryCode: _countryCtrl,
                    controller: _valCtrl,
                  )
                else
                  TextFormFieldWidget(
                    title: "Enter new email address",
                    controller: _valCtrl,
                  ),
                const SizedBox(height: 12),
                if (showOtpField)
                  TextFormFieldWidget(
                    title: "Enter OTP Sent to  ${_valCtrl.text}",
                    controller: _otpCtrl,
                  ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ChangeDataLoaded) {
          showOtpField = true;
        }
      },
    );
  }
}

class UpdateProfileParams {
  UpdateProfileParams(this.isEmail);

  final bool isEmail;
}
