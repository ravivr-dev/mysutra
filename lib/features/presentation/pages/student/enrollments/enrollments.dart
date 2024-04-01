import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/pages/student/enrollments/widgets/expertise_widget.dart';

class EnrollmentsScreen extends StatefulWidget {
  const EnrollmentsScreen({super.key});

  @override
  State<EnrollmentsScreen> createState() => _EnrollmentsState();
}

class _EnrollmentsState extends State<EnrollmentsScreen> {
  static const String url =
      "https://source.unsplash.com/random?profile-picture";

  final List<BatchDetails> listOfBatches = [
    BatchDetails(
        name: 'Batch 1',
        startTime: '01:00 PM',
        endTime: '02:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding'],
        coach: 'Bessie Cooper'),
    BatchDetails(
        name: 'Batch 2',
        startTime: '02:00 PM',
        endTime: '03:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding'],
        coach: 'Bessie Cooper'),
    BatchDetails(
        name: 'Batch 3',
        startTime: '03:00 PM',
        endTime: '04:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding', 'Badminton'],
        coach: 'Bessie Cooper'),
    BatchDetails(
        name: 'Batch 4',
        startTime: '05:00 PM',
        endTime: '06:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding'],
        coach: 'Eddie Murphy'),
    BatchDetails(
        name: 'Batch 5',
        startTime: '06:00 PM',
        endTime: '07:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding', 'Tennis'],
        coach: 'Eddie Murphy'),
    BatchDetails(
        name: 'Batch 6',
        startTime: '07:00 PM',
        endTime: '08:00 PM',
        expertise: ['Batting', 'Bowling', 'Fielding'],
        coach: 'Eddie Murphy'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'My Enrollments',
          centerTitle: true,
          isTransparentAppbar: true,
          showAddEnrollments: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
                Column(children: [
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              listOfBatches[i].name ?? 'No Name',
                              style:
                                  theme.publicSansFonts.boldStyle(fontSize: 16),
                            ),
                            Text(
                              '(${listOfBatches[i].startTime} - ${listOfBatches[i].endTime})',
                              style: theme.publicSansFonts
                                  .regularStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          children: listOfBatches[i]
                              .expertise!
                              .map((value) =>
                                  ExpertiseWidget(expertiseName: value))
                              .toList(),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: const ShapeDecoration(
                              shape: StadiumBorder(),
                              color: AppColors.greyF3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 14,
                                foregroundImage: NetworkImage(url),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(listOfBatches[i].coach!)
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, i) {
                    return const Divider(
                      color: AppColors.greyF3,
                    );
                  },
                  itemCount: listOfBatches.length)
            ]),
          ),
        ));
  }
}

class BatchDetails {
  final String? name;
  final String? startTime;
  final String? endTime;
  final List<String>? expertise;
  final String? coach;

  BatchDetails(
      {this.name, this.startTime, this.endTime, this.expertise, this.coach});
}
