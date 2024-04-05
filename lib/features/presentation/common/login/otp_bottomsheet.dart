import 'dart:async';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class OtpBottomsheet extends StatefulWidget {

  const OtpBottomsheet({super.key});

  @override
  State<OtpBottomsheet> createState() => _OtpBottomsheetState();
}

class _OtpBottomsheetState extends State<OtpBottomsheet> {
  final ValueNotifier<int> _timeCounter = ValueNotifier<int>(60);
  String? otp;
  final int timerInitVal = 60;

  @override
  void initState() {
    resendOtpTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timeCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state is OtpError) {
                widget.showErrorToast(context: context, message: state.error);
              } else if (state is OtpSuccess) {
                widget.showSuccessToast(
                    context: context, message: state.message);
                AiloitteNavigation.intentWithClearAllRoutes(
                    context, AppRoutes.homeRoute);
              } else if (state is ResendOtpSuccess) {
                widget.showSuccessToast(
                    context: context, message: state.message);
                _timeCounter.value = timerInitVal;
                resendOtpTimer();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Enter OTP',
                    style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      'Please enter the OTP received on your\nregistered mobile number',
                      textAlign: TextAlign.center,
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.grey92)),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: OTPTextField(
                      length: 6,
                      onChanged: (value) {
                        otp = value;
                      },
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.center,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle:
                          OtpFieldStyle(backgroundColor: AppColors.greyF3),
                      outlineBorderRadius: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ValueListenableBuilder(
                    valueListenable: _timeCounter,
                    builder: (BuildContext context, int value, Widget? child) {
                      return Column(
                        children: [
                          Text(
                            '00:${value.toString().padLeft(2, "0")}',
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              if (_timeCounter.value <= 0) {
                                _timeCounter.value = timerInitVal;
                                resendOtpTimer();
                                // context.read<OtpCubit>().resendOtp(
                                //       LoginParams(
                                //         countryCode: widget.data.countryCode,
                                //         phoneNumber: widget.data.phoneNumber,
                                //       ),
                                //     );
                              }
                            },
                            child: Text(
                              "Send me a new code",
                              style: theme.publicSansFonts.regularStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontColor: (_timeCounter.value <= 0)
                                      ? AppColors.primaryColor
                                      : Colors.grey.shade500),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: SafeArea(
                      child: CustomButton(
                        isLoading: state is OtpLoading,
                        text: context.stringForKey(StringKeys.verify),
                        onPressed: () {
                          if (otp != null && otp!.length == 6) {
                            // context.read<OtpCubit>().verifyOtp(
                            //       LoginParams(
                            //           countryCode: widget.data.countryCode,
                            //           phoneNumber: widget.data.phoneNumber,
                            //           otp: otp),
                            //     );
                           AiloitteNavigation.intentWithClearAllRoutes(context, AppRoutes.selectAccountRoute);
                          } else {
                            widget.showErrorToast(
                                context: context,
                                message: "Pelase enter a valid OTP");
                          }
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          Positioned(
            right: 20,
            top: 20,
            child: IconButton(
              color: Colors.amber,
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.black21,
              ),
            ),
          )
        ],
      ),
    );
  }

  resendOtpTimer() {
    Duration oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (time) {
      _timeCounter.value--;
      if (_timeCounter.value <= 0) {
        time.cancel();
      }
    });
  }
}
