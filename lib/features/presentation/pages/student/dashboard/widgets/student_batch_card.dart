import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/presentation/pages/student/enrollments/widgets/expertise_widget.dart';

class StudentBatchCard extends StatelessWidget {
  final int batch;
  const StudentBatchCard({
    super.key,
    required this.batch,
  });

  @override
  Widget build(BuildContext context) {
    List<String> skills = ['Batting', 'Bowling', 'Fielding'];
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Batch ${batch + 1}  ",
                style: theme.publicSansFonts.boldStyle(fontSize: 16),
              ),
              Text(
                '(0${batch + 1}:00 PM- 0${batch + 2}:00 PM)',
                style: theme.publicSansFonts.regularStyle(fontSize: 16),
              )
            ],
          ),
          Row(
            children: skills
                .map((value) => ExpertiseWidget(expertiseName: value))
                .toList(),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(), color: AppColors.greyF3),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(Constants.tempNetworkUrl),
                ),
                 SizedBox(
                  width: 10,
                ),
                Text("Tony Stark")
              ],
            ),
          ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       "Batch ${batch + 1} (0${batch + 1}:00 PM- 0${batch + 2}:00 PM)",
      //       style: theme.publicSansFonts.regularStyle(
      //           fontSize: 16, height: 24, fontColor: AppColors.neutralAlpha),
      //     ),
      //     Text(
      //       "${batch + 20} Students",
      //       style: theme.publicSansFonts.regularStyle(
      //           fontSize: 14, height: 24, fontColor: AppColors.black49),
      //     ),
      //   ],
      // ),
    );
  }
}
