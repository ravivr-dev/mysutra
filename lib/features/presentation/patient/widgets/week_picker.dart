import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class WeekPicker extends StatefulWidget {
  const WeekPicker({super.key});

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        component.text(
          DateFormat('d MMMM yyyy').format(selectedDate),
          style: theme.publicSansFonts.mediumStyle(
            fontSize: 14,
            fontColor: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 100,
              itemBuilder: (_, index) {
                DateTime temp = now.add(Duration(days: now.day + index));
                return SizedBox(
                  width: (context.screenWidth - 100) / 6,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedDate = temp;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: deco(selectedDate == temp),
                      child: Column(
                        children: [
                          component.text(
                            DateFormat('E').format(temp),
                            style: theme.publicSansFonts.regularStyle(
                                fontColor: selectedDate == temp
                                    ? Colors.white
                                    : AppColors.black81,
                                fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          component.text(
                            DateFormat('d').format(temp),
                            style: theme.publicSansFonts.mediumStyle(
                              fontSize: 14,
                              fontColor: selectedDate == temp
                                  ? Colors.white
                                  : Colors.black,
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
}
