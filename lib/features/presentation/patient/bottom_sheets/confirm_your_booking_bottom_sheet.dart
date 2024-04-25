import 'dart:async';
import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/common_widgets/custom_otp_field.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ConfirmYourBookingBottomSheet extends StatefulWidget {
  final String token;

  const ConfirmYourBookingBottomSheet({super.key, required this.token});

  @override
  State<ConfirmYourBookingBottomSheet> createState() =>
      _ConfirmYourBookingBottomSheetState();
}

class _ConfirmYourBookingBottomSheetState
    extends State<ConfirmYourBookingBottomSheet> {
  final ValueNotifier<int> _timeCounter = ValueNotifier<int>(60);
  final TextEditingController _otpController = TextEditingController();
  final int _timerInitVal = 60;
  late Timer _resendOtpTimer;

  @override
  void initState() {
    _resendOtp();
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
          BlocConsumer<AppointmentCubit, AppointmentState>(
            listener: (context, state) {
              if (state is ConfirmAppointmentErrorState) {
                widget.showErrorToast(
                    context: context, message: 'Something Went Wrong');
              } else if (state is ConfirmAppointmentSuccessState) {
                widget.showErrorToast(
                    context: context,
                    message: 'Appointment Confirmed Successfully');
                _navigateToBookingSuccessfulScreen();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    context.stringForKey(StringKeys.confirmYourBooking),
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 24,
                      fontColor: AppColors.black21,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: component.text(
                      context.stringForKey(
                          StringKeys.pleaseConfirmYourBookingByText),
                      textAlign: TextAlign.center,
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 12, fontColor: AppColors.grey92),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: _buildOtpTextField(),
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
                                _timeCounter.value = _timerInitVal;
                                _resendOtp();
                              }
                            },
                            child: Text(
                              context.stringForKey(StringKeys.sendMeANewCode),
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
                    child: CustomButton(
                      height: 70,
                      borderRadius: 20,
                      isLoading: state is OtpLoading,
                      text: context.stringForKey(StringKeys.verify),
                      onPressed: () {
                        if (_otpController.text.length == 4) {
                          _confirmAppointment();
                        } else {
                          widget.showErrorToast(
                              context: context,
                              message: "Pelase enter a valid OTP");
                        }
                      },
                      titleStyle: theme.publicSansFonts.semiBoldStyle(
                        fontSize: 20,
                        fontColor: AppColors.white,
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

  void _navigateToBookingSuccessfulScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.bookingSuccessful, (route) => route.isFirst);
  }

  void _confirmAppointment() {
    context.read<AppointmentCubit>().confirmAppointment(
        data: ConfirmAppointmentParams(
            otp: int.parse(_otpController.text), token: widget.token));
  }

  Widget _buildOtpTextField() {
    return CustomOtpField(otpController: _otpController);
  }

  void _resendOtp() {
    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (time) {
      _timeCounter.value--;
      if (_timeCounter.value <= 0) {
        time.cancel();
      }
    });
  }
}
