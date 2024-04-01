import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/common_widgets/custom_date_picker.dart';
import 'package:my_sutra/core/common_widgets/custom_small_button.dart';
import 'package:my_sutra/core/common_widgets/custom_small_outline_buttom.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/presentation/pages/coach/attendance/cubit/attendance_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/widgets/center_name_widget.dart';


class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
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

  static const String url =
      "https://source.unsplash.com/random?profile-picture";

  DateTime selectedDate = DateTime.now();

  List<UserProfileEntity> list = [];

  List<String> studentIds = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AttendanceCubit>().getBatchStudents(10, 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: "Mark Attendance",
        centerTitle: true,
        showNotification: true,
        isTransparentAppbar: true,
      ),
      // bottomSheet: bottomsheet(),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is GetBatchStudentsLoaded) {
            list = state.data;
          }

          if (state is MarkAttendanceLoaded) {
            widget.showSuccessToast(context: context, message: state.data);
          }

          if (state is AttendanceError) {
            widget.showSuccessToast(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: CenterNameWidget(
                  title: DateFormat('dd MMMM yyyy').format(selectedDate),
                  onTap: () {
                    showCalender((date) {
                      setState(() {
                        selectedDate = date;
                      });
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 110),
                  itemBuilder: (_, index) {
                    bool isSelected = studentIds.contains(list[index].id);
                    return InkWell(
                      onTap: () {
                        if (!isSelected) {
                          studentIds.add(list[index].id!);
                        } else {
                          studentIds.remove(list[index].id!);
                        }

                        setState(() {});
                      },
                      child: Container(
                        color: isSelected ? Colors.green : AppColors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}",
                              style: theme.publicSansFonts.regularStyle(
                                  fontSize: 14, fontColor: AppColors.black39),
                            ),
                            const SizedBox(width: 16),
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(list[index].profilePic ?? url),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index].name ?? '',
                                    style: theme.publicSansFonts
                                        .regularStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 6),
                                  // Text(
                                  //   list[index].phoneNumber ?? '',
                                  //   style: theme.publicSansFonts.regularStyle(
                                  //     fontSize: 14,
                                  //     fontColor: AppColors.black21.withOpacity(0.5),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // Text(
                            //   students[index].time,
                            //   style: theme.publicSansFonts.regularStyle(
                            //       fontSize: 16, fontColor: AppColors.black39),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.greyEC),
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomSmallOutlineButton(
            text: "Scan More",
            onPressed: () {},
          ),
          CustomSmallButton(
            width: 150,
            text: "Save",
            onPressed: () {
              context.read<AttendanceCubit>().markAttendance(
                  DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(selectedDate),
                  studentIds);
              Navigator.pop(context);
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // SafeArea bottomsheet() {
  //   return SafeArea(
  //     child: Container(
  //       padding: const EdgeInsets.only(top: 15),
  //       height: 90,
  //       color: AppColors.white,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CustomSmallOutlineButton(
  //             width: context.screenWidth / 2 - 50,
  //             text: "Scan more",
  //             onPressed: () {},
  //           ),
  //           CustomSmallButton(
  //             width: context.screenWidth / 2 - 50,
  //             text: "Save",
  //             onPressed: () {},
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  showCalender(Function(DateTime) callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              height: 400,
              width: 400,
              child: CustomDatePicker(
                callback: callback,
              )),
        );
      },
    );
  }
}

class StudentItem {
  final String name;
  final String time;
  final String title;

  StudentItem({
    required this.name,
    required this.time,
    required this.title,
  });
}
