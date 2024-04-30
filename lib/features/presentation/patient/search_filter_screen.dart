import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:searchfield/searchfield.dart';
import '../../../core/common_widgets/custom_dropdown.dart';
import '../../../core/common_widgets/custom_search_field.dart';
import '../../domain/entities/doctor_entities/specialisation_entity.dart';

class SearchFilterScreen extends StatefulWidget {
  final SearchFilterArgs? args;

  const SearchFilterScreen({super.key, this.args});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  String selectedSpeciality = 'All';
  final TextEditingController _locationController = TextEditingController();
  List<SpecializationEntity> _specialisationList = [];
  String? _selectedSpecification;
  late int? _selectedRatings = widget.args?.reviews;
  late int? _experience = widget.args?.experience;

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
        leading: InkWell(
          onTap: () => AiloitteNavigation.back(context),
          child: Icon(Icons.arrow_back,
              color: AppColors.color0xFF00082F.withOpacity(.27)),
        ),
        title: component.text(context.stringForKey(StringKeys.searchFilter)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocConsumer<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
          if (state is SpecializationLoaded) {
            _specialisationList = state.data;
          } else if (state is RegistrationError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        }, builder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(value: context.stringForKey(StringKeys.speciality)),
              TextSearchField(
                textCapitalization: TextCapitalization.words,
                validator: (value) =>
                    value.isEmpty ? 'Please Select Specialization' : null,
                onSuggestionTap: (value) {
                  _selectedSpecification = value.item;
                },
                hintText:
                    _getDefaultSpeciality() ?? 'Please Select Specialization',
                maxLength: 100,
                suggestions: _specialisationList
                    .map((e) => SearchFieldListItem(e.name,
                        item: e.id,
                        child: component.text(
                          e.name.capitalizeFirstLetterOfSentence,
                          style: theme.publicSansFonts.regularStyle(
                              fontSize: 18, fontColor: AppColors.black49),
                        )))
                    .toList(),
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
              // _buildHeader(value: context.stringForKey(StringKeys.location)),
              // component.spacer(height: 16),
              // _buildTextField(),
              // component.spacer(height: 8),
              // Row(
              //   children: [
              //     component.assetImage(path: Assets.iconsGps),
              //     component.spacer(width: 8),
              //     component.text(
              //         context.stringForKey(StringKeys.detectMyLocation),
              //         style: theme.publicSansFonts.semiBoldStyle(
              //           fontSize: 16,
              //           fontColor: AppColors.color0xFF8338EC,
              //         ))
              //   ],
              // ),
              // component.spacer(height: 30),
              _buildHeader(
                  value: context.stringForKey(StringKeys.yearOfExperience)),
              component.spacer(height: 16),
              CustomDropdown(
                // controller: SingleValueDropDownController(),
                onChanged: (model) => _experience = model.value,

                /// i+1 because i would be start from 0
                dropDownList: List.generate(
                    30,
                    (i) => DropDownValueModel(
                        name: '${i + 1} years', value: i + 1)),
                height: 70,
                borderRadius: 90,
                hintText: '${_experience ?? ''}',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 33),
              ),
              component.spacer(height: 26),
              CustomButton(
                text: context.stringForKey(StringKeys.applyFilter),
                onPressed: () {
                  AiloitteNavigation.backWithData(
                      context,
                      SearchFilterArgs(
                        experience: _experience,
                        reviews: _selectedRatings,
                        specializationId: _selectedSpecification ??
                            _getDefaultSpeciality(getId: true),
                      ));
                },
              )
            ],
          );
        }),
      ),
    );
  }

  String? _getDefaultSpeciality({bool getId = false}) {
    final spec = _specialisationList
        .where((element) => element.id == widget.args?.specializationId)
        .firstOrNull;
    return getId ? spec?.id : spec?.name;
  }

  Widget _buildReviewWidget({required int star}) {
    final isSelected = _selectedRatings == star;
    return Row(
      children: [
        ...List.generate(5, (index) => _buildStar(isSelected: index < star)),
        component.spacer(width: 8),
        component.text('$star.0 and above',
            style: theme.publicSansFonts.mediumStyle(
                fontSize: 16, fontColor: AppColors.color0xFF1E293B)),
        const Spacer(),
        InkWell(
          onTap: () => setState(
            () => _selectedRatings == star
                ? _selectedRatings = null
                : _selectedRatings = star,
          ),
          child: Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue25 : AppColors.white,
              border: Border.all(color: AppColors.grey92),
              shape: BoxShape.circle,
            ),
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

  // Widget _buildTextField() {
  //   return SizedBox(
  //     height: 70,
  //     child: component.textField(
  //       controller: TextEditingController(),
  //       fillColor: AppColors.white,
  //       hintText: '',
  //       contentPadding: const EdgeInsets.only(top: 25, bottom: 25, left: 33),
  //       borderRadius: 90,
  //       suffixWidget: Padding(
  //         padding: const EdgeInsets.only(right: 30),
  //         child: component.assetImage(path: Assets.iconsLocation),
  //       ),
  //       filled: true,
  //       focusedBorderColor: AppColors.color0xFFDADCE0,
  //       borderColor: AppColors.color0xFFDADCE0,
  //     ),
  //   );
  // }

  // Widget _buildSpecialityWidget({required String value}) {
  //   bool isSelected = selectedSpeciality == value;
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
  //     decoration: BoxDecoration(
  //       color: isSelected ? AppColors.color0xFF8338EC : AppColors.white,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: component.text(value,
  //         style: theme.publicSansFonts.mediumStyle(
  //           fontColor: isSelected ? AppColors.white : AppColors.neutral,
  //         )),
  //   );
  // }

  Widget _buildHeader({required String value}) {
    return component.text(value,
        style: theme.publicSansFonts.semiBoldStyle(
          fontSize: 16,
        ));
  }
}

class SearchFilterArgs {
  final int? experience;
  final int? reviews;
  final String? specializationId;

  SearchFilterArgs({
    required this.experience,
    required this.reviews,
    required this.specializationId,
  });
}
