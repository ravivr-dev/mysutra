import 'dart:async';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/common_widgets/custom_otp_field.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
// import 'package:my_sutra/features/presentation/common/home/home_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/bottom_sheets/verification_pending_bottom_sheet.dart';
import '../../../../injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';

class OtpBottomsheet extends StatefulWidget {
  final LoginParams? loginData;
  final RegistrationParams? regData;

  const OtpBottomsheet({
    super.key,
    this.loginData,
    this.regData,
  });

  @override
  State<OtpBottomsheet> createState() => _OtpBottomsheetState();
}

class _OtpBottomsheetState extends State<OtpBottomsheet> {
  final ValueNotifier<int> _timeCounter = ValueNotifier<int>(60);
  final int timerInitVal = 60;
  late Timer _resendOtpTimer;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    resendOtpTimer();
    super.initState();
  }

  @override
  void dispose() {
    _resendOtpTimer.cancel();
    _timeCounter.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
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
                    context: context, message: state.data.message ?? "");

                if (state.data.totalUserAccounts == 1 ||
                    widget.regData != null) {
                  if ((state.data.data?.isVerified ?? true) ||
                      state.data.data!.role != UserRole.doctor.name) {
                    AiloitteNavigation.intentWithClearAllRoutes(
                        context, AppRoutes.homeRoute);
                  } else {
                    AiloitteNavigation.back(context);
                    context.showBottomSheet(
                      BlocProvider(
                        create: (_) => sl<HomeCubit>(),
                        child: const VerificationPendingBottomSheet(),
                      ),
                    );
                  }
                } else {
                  AiloitteNavigation.intentWithClearAllRoutes(
                      context, AppRoutes.selectAccountRoute);
                }
              } else if (state is ResendLoginOtpSuccess) {
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
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: component.text(
                      'Please enter the OTP received on your registered mobile number',
                      textAlign: TextAlign.center,
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.grey92),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomOtpField(otpController: _otpController),
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
                                if (widget.loginData != null) {
                                  context
                                      .read<OtpCubit>()
                                      .resendLoginOtp(widget.loginData!);
                                } else if (widget.regData != null) {
                                  context
                                      .read<OtpCubit>()
                                      .resendRegOtp(widget.regData!);
                                }
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
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 31),
                    child: SafeArea(
                      child: CustomButton(
                        isLoading: state is OtpLoading,
                        text: context.stringForKey(StringKeys.verify),
                        onPressed: () {
                          if (_otpController.text.length == 4) {
                            context
                                .read<OtpCubit>()
                                .verifyOtp(int.parse(_otpController.text));
                            // AiloitteNavigation.intentWithClearAllRoutes(
                            //     context, AppRoutes.selectAccountRoute);
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

  void resendOtpTimer() {
    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (time) {
      _timeCounter.value--;
      if (_timeCounter.value <= 0) {
        time.cancel();
      }
    });
  }
}
