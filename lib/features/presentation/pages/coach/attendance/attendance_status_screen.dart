import 'package:flutter/material.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/pages/coach/attendance/mark_attendance_screen.dart';
import 'package:my_sutra/features/presentation/pages/coach/attendance/widgets/marking_attendance_card.dart';

class AttendanceStatusScreen extends StatefulWidget {
  const AttendanceStatusScreen({super.key});

  @override
  State<AttendanceStatusScreen> createState() => _AttendanceStatusScreenState();
}

class _AttendanceStatusScreenState extends State<AttendanceStatusScreen> {
  List<StudentItem> students = [
    StudentItem(name: "Sahil", title: "Sprint master", time: "14:15"),
    StudentItem(name: "Mukul", title: "Tabel tennis expert", time: "16:30"),
    StudentItem(name: "Abhinav Gupta", title: "Head boy", time: "12:20"),
    StudentItem(name: "Nikki Gupta", title: "Circuit Conquerer", time: "11:20"),
    StudentItem(
        name: "Emma Rana", title: "Ultimate Uproar Usher", time: "10:21"),
    StudentItem(name: "Himanshu", title: "Skill Sprint Star", time: "11:25"),
    StudentItem(
        name: "Brooklyn Simmons",
        title: "Supreme Showdown Specialist",
        time: "11:10"),
    StudentItem(name: "Gopal", title: "Sprint master", time: "14:15"),
    StudentItem(name: "Madhav", title: "Star player", time: "12:30"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Attendance Status",
        centerTitle: true,
        isTransparentAppbar: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: CustomButton(
          text: "Save changes",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 120, top: 20),
              itemBuilder: (_, index) {
                return MarkingAttendanceCard(data: students[index]);
              },
              separatorBuilder: (_, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: AppColors.greyEC),
                );
              },
              itemCount: students.length,
            ),
          ),
        ],
      ),
    );
  }
}
