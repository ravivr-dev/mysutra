import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';
import '../../../core/common_widgets/custom_dropdown.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  String selectedSpeciality = 'All';
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27)),
        title: component.text(context.stringForKey(StringKeys.searchFilter)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(value: context.stringForKey(StringKeys.speciality)),
            component.spacer(height: 8),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSpecialityWidget(value: 'All'),
                  component.spacer(width: 12),
                  _buildSpecialityWidget(value: 'Obstetrician'),
                  component.spacer(width: 12),
                  _buildSpecialityWidget(value: 'Andrologist'),
                  component.spacer(width: 12),
                  _buildSpecialityWidget(value: 'Pediatric '),
                ],
              ),
            ),
            component.spacer(height: 30),
            _buildHeader(value: context.stringForKey(StringKeys.reviews)),
            component.spacer(height: 8),
            _buildReviewWidget(star: 4),
            component.spacer(height: 30),
            _buildReviewWidget(star: 3),
            component.spacer(height: 30),
            _buildReviewWidget(star: 2),
            component.spacer(height: 30),
            _buildReviewWidget(star: 1),
            component.spacer(height: 30),
            _buildHeader(value: context.stringForKey(StringKeys.location)),
            component.spacer(height: 16),
            _buildTextField(),
            component.spacer(height: 8),
            Row(
              children: [
                component.assetImage(path: Assets.iconsGps),
                component.spacer(width: 8),
                component.text(
                    context.stringForKey(StringKeys.detectMyLocation),
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 16,
                      fontColor: AppColors.color0xFF8338EC,
                    ))
              ],
            ),
            component.spacer(height: 30),
            _buildHeader(
                value: context.stringForKey(StringKeys.yearOfExperience)),
            component.spacer(height: 16),
            CustomDropdown(
              controller: SingleValueDropDownController(),
              dropDownList: [],
              height: 70,
              borderRadius: 90,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 33),
            ),
            component.spacer(height: 26),
            CustomButton(
              text: context.stringForKey(StringKeys.applyFilter),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewWidget({required int star}) {
    return Row(
      children: [
        ...List.generate(5, (index) => _buildStar(isSelected: index < star)),
        component.spacer(width: 8),
        component.text('$star.0 and above',
            style: theme.publicSansFonts.mediumStyle(
                fontSize: 16, fontColor: AppColors.color0xFF1E293B)),
        const Spacer(),
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.grey92),
            shape: BoxShape.circle,
          ),
        )
      ],
    );
  }

  Widget _buildStar({required bool isSelected}) {
    return Row(
      children: [
        Icon(Icons.star, color: isSelected ? AppColors.star : AppColors.greyD9),
        component.spacer(width: 4)
      ],
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      height: 70,
      child: component.textField(
        controller: TextEditingController(),
        fillColor: AppColors.white,
        hintText: '',
        contentPadding: const EdgeInsets.only(top: 25, bottom: 25, left: 33),
        borderRadius: 90,
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: component.assetImage(path: Assets.iconsLocation),
        ),
        filled: true,
        focusedBorderColor: AppColors.color0xFFDADCE0,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  Widget _buildSpecialityWidget({required String value}) {
    bool isSelected = selectedSpeciality == value;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.color0xFF8338EC : AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: component.text(value,
          style: theme.publicSansFonts.mediumStyle(
            fontColor: isSelected ? AppColors.white : AppColors.neutral,
          )),
    );
  }

  Widget _buildHeader({required String value}) {
    return component.text(value,
        style: theme.publicSansFonts.semiBoldStyle(
          fontSize: 16,
        ));
  }
}
