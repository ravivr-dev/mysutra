import 'dart:io';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_search_field.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/common_widgets/upload_image_bottomsheet.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/custom_inkwell.dart';
import 'package:my_sutra/core/utils/screentop_handler.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/otp_bottomsheet.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/widgets/app_logo_with_terms_condition_widget.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchfield/searchfield.dart';

class CreateAccountScreen extends StatefulWidget {
  final String profession;
  const CreateAccountScreen({
    super.key,
    required this.profession,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _specializationCtrl = TextEditingController();
  final TextEditingController _regNumCtrl = TextEditingController();
  final TextEditingController _expCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _socialCtrl = TextEditingController();

  final ValueNotifier<List<String>> urlList = ValueNotifier<List<String>>([]);

  List<SpecializationEntity> specialisationList = [];
  String? selectedSpecification;

  final ImagePicker picker = ImagePicker();
  XFile? profilePic;
  String? profilePicKey;

  @override
  void didChangeDependencies() {
    if (widget.profession == "Doctor") {
      context
          .read<RegistrationCubit>()
          .getSpecialisations(GeneralPagination(start: 1, limit: 100));
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    urlList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomInkwell(
        child: BlocConsumer<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is SpecializationLoaded) {
              specialisationList = state.data;
            } else if (state is RegistrationError) {
              widget.showErrorToast(context: context, message: state.error);
            } else if (state is RegistrationSuccess) {
              widget.showSuccessToast(context: context, message: state.message);
              showOtpBottomSheet();
            } else if (state is UploadDocument) {
              profilePic = state.file;
              profilePicKey = state.data.key;
            }
          },
          builder: (context, state) {
            return ListView(
              padding: AppDeco.screenPadding,
              children: [
                const ScreenTopHandler(),
                const AppLogoWithTermsConditionWidget(),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "For ${widget.profession}s",
                      style: theme.publicSansFonts.mediumStyle(
                          fontSize: 14, fontColor: AppColors.primaryColor),
                    ),
                    InkWell(
                      onTap: () {
                        AiloitteNavigation.intentWithClearAllRoutes(
                            context, AppRoutes.chooseAccountTypeRoute);
                      },
                      child: Text(
                        "Switch user",
                        style: theme.publicSansFonts.mediumStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontColor: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Create an account",
                  style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
                ),
                const SizedBox(height: 20),
                if (widget.profession != "User")
                  Center(
                    child: InkWell(
                      onTap: () {
                        updateProfileImageSheet(
                          onChange: (image) {
                            if (image != null) {
                              context
                                  .read<RegistrationCubit>()
                                  .uploadDoc(image);
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: profilePic == null
                          ? DottedBorder(
                              strokeWidth: 2,
                              color: AppColors.greyD9,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              dashPattern: const [15, 10],
                              radius: const Radius.circular(20),
                              padding: const EdgeInsets.all(35),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.person_rounded,
                                    size: 50,
                                    color: AppColors.blackAE,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Upload Picture",
                                    style: theme.publicSansFonts.semiBoldStyle(
                                        fontSize: 14,
                                        fontColor: AppColors.blackAE),
                                  ),
                                ],
                              ),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              child: ClipPath(
                                clipper: const ShapeBorderClipper(
                                  shape: CircleBorder(),
                                ),
                                child: Image.file(
                                  File(profilePic!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  title:
                      widget.profession == "User" ? "User Name" : "Full Name",
                  controller: _nameCtrl,
                ),
                TextFormWithCountryCode(
                  title: context.stringForKey(StringKeys.mobileNumber),
                  countryCode: _countryCode,
                  controller: _mobCtrl,
                ),
                TextFormFieldWidget(
                  title: "Email",
                  controller: _emailCtrl,
                ),
                if (widget.profession == "Doctor") ...[
                  // TextFormFieldWidget(
                  //   title: "Specialization",
                  //   controller: _specializationCtrl,
                  // ),
                  TextSearchField(
                    textCapitalization: TextCapitalization.words,
                    title: "Specialization",
                    onSuggestionTap: (value) {
                      selectedSpecification = value.item;
                    },
                    suggestions: specialisationList
                        .map((e) => SearchFieldListItem(e.name,
                            item: e.id,
                            child: Text(
                              e.name.capitalizeFirstLetterOfSentence,
                              style: theme.publicSansFonts.regularStyle(
                                  fontSize: 18, fontColor: AppColors.black49),
                            )))
                        .toList(),
                  ),
                  TextFormFieldWidget(
                    title: "Professional Registration number",
                    controller: _regNumCtrl,
                  ),
                  TextFormFieldWidget(
                    hintText: "Experience",
                    title: "Total year of experience",
                    controller: _expCtrl,
                    suffixWidget: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        "Years",
                        style: theme.publicSansFonts
                            .regularStyle(fontSize: 16, height: 22),
                      ),
                    ),
                  ),
                ] else if (widget.profession == "Influencer") ...[
                  TextFormFieldWidget(
                    title: "Age",
                    controller: _ageCtrl,
                    suffixWidget: Padding(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Text(
                        "Years",
                        style: theme.publicSansFonts
                            .regularStyle(fontSize: 16, height: 22),
                      ),
                    ),
                  ),
                  TextFormFieldWidget(
                    title: "Social Profile URL",
                    controller: _socialCtrl,
                    suffixWidget: IconButton(
                      color: AppColors.primaryColor,
                      onPressed: () {
                        if (_socialCtrl.text.trim().isNotEmpty) {
                          urlList.value.add(_socialCtrl.text.trim());
                          urlList.value = [...urlList.value];
                          _socialCtrl.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.add_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                      valueListenable: urlList,
                      builder: (BuildContext context, List<String> list,
                          Widget? child) {
                        return Wrap(
                          runSpacing: 0,
                          spacing: 8,
                          children: list
                              .map((e) => InputChip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: AppColors.primaryColor),
                                    ),
                                    label: Text(e),
                                    labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                    backgroundColor: AppColors.primaryColor
                                        .withOpacity(0.15),
                                    deleteIconColor: AppColors.primaryColor,
                                    onDeleted: () {
                                      urlList.value.remove(e);
                                      urlList.value = [...urlList.value];
                                    },
                                  ))
                              .toList(),
                        );
                      }),
                ],
                const SizedBox(height: 70),
                CustomButton(
                  onPressed: () {
                    context.read<RegistrationCubit>().registration(
                          RegistrationParams(
                              role: giveRole(),
                              profilePic: null,
                              fullName: _nameCtrl.text,
                              countryCode: _countryCode.text,
                              phoneNumber: int.tryParse(_mobCtrl.text),
                              email: _emailCtrl.text,
                              specializationId: _specializationCtrl.text,
                              registrationNumber: _regNumCtrl.text,
                              experience: int.tryParse(_expCtrl.text),
                              age: int.tryParse(_ageCtrl.text),
                              socialUrls: urlList.value.isNotEmpty
                                  ? urlList.value
                                  : null),
                        );
                  },
                  text: "Continue",
                ),
                const SizedBox(height: 15),
                Center(
                  child: InkWell(
                    onTap: () {
                      AiloitteNavigation.intentWithClearAllRoutes(
                          context, AppRoutes.loginRoute);
                    },
                    child: Text(
                      "Sign in Instead",
                      style: theme.publicSansFonts.regularStyle(
                        fontSize: 16,
                        fontColor: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }

  showOtpBottomSheet() {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return BlocProvider(
            create: (context) => sl<OtpCubit>(),
            child: const OtpBottomsheet(),
          );
        });
  }

  updateProfileImageSheet({required dynamic Function(XFile?) onChange}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return UploadImageBottomSheet(
            showRemovePhoto: profilePic != null,
            removePhoto: () {
              profilePic = null;
              setState(() {});
              Navigator.pop(context);
            },
            onChange: onChange);
      },
    );
  }

  String giveRole() {
    if (widget.profession == "Doctor") {
      return ROLE_DOCTOR;
    } else if (widget.profession == "Influencer") {
      return ROLE_INFLUENCER;
    }
    return ROLE_PATIENT;
  }
}
