import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(DateTime) callback;
  const CustomDatePicker({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: theme.publicSansFonts
            .semiBoldStyle(fontSize: 12, fontColor: Colors.grey.shade600),
        weekendStyle: theme.publicSansFonts.semiBoldStyle(
            fontSize: 12, fontColor: AppColors.error.withOpacity(0.7)),
      ),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: theme.publicSansFonts.semiBoldStyle(fontSize: 18)),
      calendarStyle: CalendarStyle(
        weekNumberTextStyle: theme.publicSansFonts
            .regularStyle(fontSize: 14, fontColor: Colors.transparent),
        defaultTextStyle: theme.publicSansFonts
            .regularStyle(fontSize: 14, fontColor: Colors.transparent),
        weekendTextStyle: theme.publicSansFonts
            .regularStyle(fontSize: 14, fontColor: Colors.transparent),
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      onDaySelected: (selectedDay, focusedDay) {
        callback(selectedDay);
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, list) {
          if (date.isAfter(DateTime.now())) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                date.day.toString(),
                style: theme.publicSansFonts.regularStyle(fontSize: 14),
              ),
            );
          } else if (date.isBefore(DateTime.now())) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                date.day.toString(),
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 14,
                    fontColor: AppColors.black49.withOpacity(0.7)),
              ),
            );
          } else {
            return null;
          }
        },
        todayBuilder: (context, date, events) => _currentDayContainer(date),
      ),
    );
  }

  Container _currentDayContainer(DateTime date) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        date.day.toString(),
        style: theme.publicSansFonts
            .regularStyle(fontSize: 14, fontColor: AppColors.primaryColor),
      ),
    );
  }
}
