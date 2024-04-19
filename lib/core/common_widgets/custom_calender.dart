import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../ailoitte_component_injector.dart';
import '../utils/app_colors.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime)? callback;

  const CustomDatePicker({super.key, required this.callback});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TableCalendar(
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: theme.publicSansFonts
                .semiBoldStyle(fontSize: 12, fontColor: Colors.grey.shade600),
            weekendStyle: theme.publicSansFonts.semiBoldStyle(
                fontSize: 12, fontColor: AppColors.error.withOpacity(0.7)),
          ),
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
                  theme.publicSansFonts.semiBoldStyle(fontSize: 18)),
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
          focusedDay: _focusedDay,
          onDaySelected: (selectedDay, focusedDay) {
            _focusedDay = focusedDay;

            widget.callback?.call(selectedDay);
          },
          selectedDayPredicate: (dateTime) {
            return dateTime.compareTo(_focusedDay) == 0;
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (_, __, ___) {
              return _currentDayContainer(__);
            },
            markerBuilder: (context, date, list) {
              if (date.isAfter(DateTime.now())) {
                return _buildFutureDateContainer(date);
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
            todayBuilder: (context, date, events) =>
                _buildFutureDateContainer(date),
          ),
        ),
      ),
    );
  }

  Container _buildFutureDateContainer(DateTime date) {
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
