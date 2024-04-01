import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class AddEnrollmentsScreen extends StatefulWidget {
  const AddEnrollmentsScreen({super.key});

  @override
  State<AddEnrollmentsScreen> createState() => _AddEnrollmentsState();
}

class _AddEnrollmentsState extends State<AddEnrollmentsScreen> {
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
        title: 'Add Enrollment',
        centerTitle: true,
        isTransparentAppbar: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              selectCenterDropdown(listOfBatches.length),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return buildBatchCard(listOfBatches[index]);
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: listOfBatches.length),
            ],
          ),
        ),
      ),
    );
  }
}

Widget selectCenterDropdown(int batchCount) {
  List<String> listOfCenters = [
    'center1',
    'center2',
    'center3',
    'center4',
    'center5'
  ];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '$batchCount BATCHES FOUND',
        style: theme.publicSansFonts.boldStyle(fontSize: 14),
      ),
      DropdownButton(
        iconEnabledColor: Colors.blueAccent,
        underline: const SizedBox(),
        hint: const Text(
          'Select academy',
          style: TextStyle(color: Colors.blueAccent),
        ),
        items: listOfCenters.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      )
    ],
  );
}

Widget buildBatchCard(BatchDetails batchDetails) {
  return Card(
    elevation: 0.5
    ,
    surfaceTintColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    child: Column(
      children: [
        ListTile(
          title: Text('${batchDetails.name}'),
          subtitle: Text('${batchDetails.coach}'),
          trailing: Text('${batchDetails.startTime}'),
        )
      ],
    ),
  );
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
