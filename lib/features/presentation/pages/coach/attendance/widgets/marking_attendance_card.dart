import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/pages/coach/attendance/mark_attendance_screen.dart';

class MarkingAttendanceCard extends StatefulWidget {
  final StudentItem data;

  const MarkingAttendanceCard({super.key, required this.data});

  @override
  State<MarkingAttendanceCard> createState() => _MarkingAttendanceCardState();
}

class _MarkingAttendanceCardState extends State<MarkingAttendanceCard> {
  static const String url =
      "https://source.unsplash.com/random?profile-picture";

  bool attendance = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(url),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.name,
                  style: theme.publicSansFonts
                      .regularStyle(fontSize: 18, height: 23),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.data.time,
                  style: theme.publicSansFonts.regularStyle(
                    fontSize: 14,
                    fontColor: AppColors.black21.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            attendenceContainer(false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Switch(
                  value: attendance,
                  onChanged: (val) {
                    setState(() {
                      attendance = val;
                    });
                  }),
            ),
            attendenceContainer(true),
          ],
        )
      ],
    );
  }

  InkWell attendenceContainer(bool isPresent) {
    return InkWell(
      onTap: () {
        if (isPresent) {
          setState(() {
            !attendance ? attendance = true : null;
          });
        } else {
          setState(() {
            attendance ? attendance = false : null;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: isPresent
              ? AppColors.success.withOpacity(0.16)
              : AppColors.error.withOpacity(0.16),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          isPresent ? "Present" : "Absent",
          style: theme.publicSansFonts.regularStyle(
              fontSize: 14,
              height: 22,
              fontColor: isPresent ? AppColors.success : AppColors.error),
        ),
      ),
    );
  }
}
