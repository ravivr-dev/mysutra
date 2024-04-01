import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/styles_and_decorations.dart';
import 'package:my_sutra/features/presentation/pages/student/dashboard/widgets/dashboard_helper_item_student.dart';
import 'package:my_sutra/features/presentation/pages/student/dashboard/widgets/renew_widget.dart';
import 'package:my_sutra/features/presentation/pages/student/dashboard/widgets/student_batch_card.dart';
import 'package:my_sutra/features/presentation/pages/student/dashboard/widgets/user_info_card.dart';

class DashboardStudent extends StatelessWidget {
  const DashboardStudent({super.key});

  @override
  Widget build(BuildContext context) {
    int numberOfBatches = 6;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
          decoration: StylesAndDecorations.generalContainerDecoration(),
          child: const Column(
            children: [
              RenewWidget(remainingDays: 7),
              UserInfoCard(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: AppColors.greyF3,
                ),
              ),
              DashboardHelperItemsStudent()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            "My Batches",
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 16),
          ),
        ),
        ...List<StudentBatchCard>.generate(
          numberOfBatches,
          (batch) => StudentBatchCard(batch: batch),
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
