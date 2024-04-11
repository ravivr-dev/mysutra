import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 10,
        child: InkWell(
          onTap: () {
            if (!(date.day == DateTime.now().day &&
                date.month == DateTime.now().month)) {
              setState(() {
                date = date.add(const Duration(days: 1));
              });
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 12,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 65,
        child: Center(
          child: Text(DateFormat('d MMM').format(date)),
        ),
      ),
      CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 10,
        child: InkWell(
          onTap: () {
            setState(() {
              date = date.subtract(const Duration(days: 1));
            });
          },
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 12,
          ),
        ),
      )
    ]);
  }
}
