import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/core/common_widgets/custom_calender.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class DateWidget extends StatefulWidget {
  final void Function(DateTime selectedDate) onDateChanged;

  const DateWidget({super.key, required this.onDateChanged});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildArrowButton(icon: Icons.arrow_back_ios, isPrevious: true),
        InkWell(
          onTap: () {
            context.showBottomSheet(CustomDatePicker(callback: (selectedData) {
              AiloitteNavigation.back(context);
              setState(() {
                _date = selectedData;
              });
              widget.onDateChanged.call(_date);
            }));
          },
          child: SizedBox(
            width: 65,
            child: Center(
              child: Text(DateFormat('d MMM').format(_date)),
            ),
          ),
        ),
        _buildArrowButton(icon: Icons.arrow_forward_ios, isPrevious: false)
      ],
    );
  }

  Widget _buildArrowButton({required IconData icon, required bool isPrevious}) {
    return InkWell(
      onTap: () {
        setState(() {
          _date = isPrevious
              ? _date.subtract(const Duration(days: 1))
              : _date.add(const Duration(days: 1));
        });
        widget.onDateChanged.call(_date);
      },
      child: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 10,
        child: Icon(
          icon,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}
