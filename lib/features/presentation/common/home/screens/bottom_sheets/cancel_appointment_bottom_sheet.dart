import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/patient/cubit/appointment_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class CancelAppointmentBottomSheet extends StatelessWidget {
  final String appointmentId;

  const CancelAppointmentBottomSheet({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is CancelAppointmentSuccessState) {
          showErrorToast(
              context: context, message: 'Appointment Canceled Successfully');
          AiloitteNavigation.intentWithoutBack(
              context, AppRoutes.bookingCancelled, null);
        } else if (state is CancelAppointmentErrorState) {
          showErrorToast(context: context, message: state.message);
        }
      },
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: component.text(
                      context.stringForKey(StringKeys.areYouSure),
                      style: theme.publicSansFonts.semiBoldStyle(
                        fontSize: 18,
                        fontColor: AppColors.color0xFF1E293B,
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: AppColors.blackTokens.withOpacity(.5),
                    size: 20,
                  ),
                )
              ],
            ),
            component.text(
                context.stringForKey(StringKeys.uouWantToCancelThisAppointment),
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: 10,
                    elevation: 0,
                    titlePadding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    height: 50,
                    titleStyle: theme.publicSansFonts.regularStyle(
                      fontColor: AppColors.color0xFF292D32,
                    ),
                    text: context.stringForKey(StringKeys.noDoNotCancel),
                    buttonColor: AppColors.color0xFFF1F5F9,
                  ),
                ),
                component.spacer(width: 12),
                Expanded(
                  child: CustomButton(
                    borderRadius: 10,
                    elevation: 0,
                    onPressed: () {
                      context
                          .read<AppointmentCubit>()
                          .cancelAppointment(appointmentId: appointmentId);
                    },
                    height: 50,
                    fontSize: 14,
                    text: context.stringForKey(StringKeys.yesCancel),
                    buttonColor: AppColors.primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
