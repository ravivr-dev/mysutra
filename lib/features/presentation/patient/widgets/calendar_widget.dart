import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 180)).toUtc(),
      lastDay: DateTime.utc(
        now.year + 2,
        now.month,
        now.day,
      ),
      focusedDay: selectedDate,
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: headerDrawer,
      ),
      calendarFormat: CalendarFormat.week,
      currentDay: selectedDate,
      onDaySelected: (selectedDay, focusedDay) {
        selectedDate = selectedDay;
        setState(() {});
      },
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) {
          return DateFormat('E').format(date);
        },
        weekendStyle: theme.publicSansFonts
            .regularStyle(fontColor: AppColors.primaryColor, fontSize: 12),
        weekdayStyle: theme.publicSansFonts
            .regularStyle(fontColor: AppColors.primaryColor, fontSize: 12),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        defaultTextStyle: theme.publicSansFonts.semiBoldStyle(
          fontSize: 14,
          fontColor: AppColors.primaryColor,
        ),
        outsideTextStyle: theme.publicSansFonts.semiBoldStyle(
          fontSize: 14,
          fontColor: AppColors.primaryColor,
        ),
        weekendTextStyle: theme.publicSansFonts.semiBoldStyle(
          fontSize: 14,
          fontColor: AppColors.primaryColor,
        ),
        defaultDecoration: BoxDecoration(
          border: Border.all(color: AppColors.greyEC),
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          border: Border.all(color: AppColors.greyEC),
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: theme.publicSansFonts.mediumStyle(
          fontSize: 14,
        ),
        headerPadding: EdgeInsets.zero,
        headerMargin: const EdgeInsets.only(bottom: 4),
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget headerDrawer(BuildContext context, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 8),
      child: component.text(
        DateFormat('d MMMM yyyy').format(selectedDate),
        style: theme.publicSansFonts.mediumStyle(
          fontSize: 14,
          fontColor: Colors.black,
        ),
      ),
    );
  }
}
