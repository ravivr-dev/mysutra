import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/patient/bottom_sheets/appointment_bottom_sheet.dart';
import 'package:my_sutra/generated/assets.dart';

class PatientPastAppointmentsScreen extends StatelessWidget {
  const PatientPastAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => AiloitteNavigation.back(context),
            child: const Icon(Icons.arrow_back)),
        title: component.text(context.stringForKey(StringKeys.pastAppointments),
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 20,
            )),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) {
          return _buildCard(context);
        },
        separatorBuilder: (_, __) => component.spacer(height: 12),
        itemCount: 3,
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return InkWell(
      onTap: () {
        context.showBottomSheet(const AppointmentBottomSheet());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 23),
        decoration: AppDeco.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            component.text('17/09.2024',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.assetImage(
                  path: Assets.iconsDummyDoctor,
                  height: 72,
                  width: 72,
                  borderRadius: 8,
                ),
                component.spacer(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      component.text(
                        'Dr. Rite Rawat',
                        style: theme.publicSansFonts.mediumStyle(
                          fontSize: 16,
                        ),
                      ),
                      component.text('Sexologist',
                          style: theme.publicSansFonts.regularStyle(
                            fontColor: AppColors.black81,
                          )),
                      component.spacer(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.color0xFF8338EC,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                            component.spacer(width: 6),
                            component.text(
                                context
                                    .stringForKey(StringKeys.bookAppointment),
                                style: theme.publicSansFonts.regularStyle(
                                  fontColor: AppColors.white,
                                ))
                          ],
                        ),
                      ),
                      component.spacer(width: 5)
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: AppColors.color0xFFC4C4C4,
                  size: 20,
                )
              ],
            ),
            component.spacer(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.color0xFFF5F5F5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  component.assetImage(path: Assets.iconsDocument),
                  component.text('Prescription 12-05-24 wpc',
                      style: theme.publicSansFonts.regularStyle(
                        fontColor: AppColors.color0xFF8338EC,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
