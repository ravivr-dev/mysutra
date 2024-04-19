import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_calender.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class WeekPicker extends StatefulWidget {
  final Function(DateTime)? onDateTimeSelected;

  const WeekPicker({super.key, this.onDateTimeSelected});

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  final DateTime _now = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _showDatePickerDialog(),
          child: Row(
            children: [
              component.text(
                DateFormat('MMMM yyyy').format(_selectedDate),
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 14,
                  fontColor: Colors.black,
                ),
              ),
              component.spacer(width: 5),
              const Icon(Icons.keyboard_arrow_down_outlined,
                  color: AppColors.blackTokens, size: 16)
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              //todo this condition is not working will have to check
              itemCount: _selectedDate.difference(_now).inDays < 100
                  ? 100
                  : _selectedDate.difference(_now).inDays,
              itemBuilder: (_, index) {
                DateTime temp = _now.add(Duration(days: index));
                final isSelected = _isDaySelected(temp);

                return SizedBox(
                  width: 46,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedDate = temp;
                        widget.onDateTimeSelected?.call(temp);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: deco(isSelected),
                      child: Column(
                        children: [
                          component.text(
                            DateFormat('E').format(temp),
                            style: theme.publicSansFonts.regularStyle(
                                fontColor: isSelected
                                    ? Colors.white
                                    : AppColors.black81,
                                fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          component.text(
                            '${temp.day}',
                            style: theme.publicSansFonts.mediumStyle(
                              fontSize: 14,
                              fontColor:
                                  isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  bool _isDaySelected(DateTime dateTime) {
    return _selectedDate.year == dateTime.year &&
        _selectedDate.month == dateTime.month &&
        _selectedDate.day == dateTime.day;
  }

  Decoration deco(bool selected) {
    if (selected) {
      return BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30));
    } else {
      return BoxDecoration(
          border: Border.all(color: AppColors.greyEC),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30));
    }
  }

  void _showDatePickerDialog() {
    context.showBottomSheet(CustomDatePicker(callback: (dateTime) {
      AiloitteNavigation.back(context);
      setState(() {
        _selectedDate = dateTime;
      });
      _scrollController.jumpTo((_selectedDate.difference(_now).inDays) * 46);
      widget.onDateTimeSelected?.call(dateTime);
    }));
  }
}
