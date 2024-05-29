import 'dart:io';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/otp_bottomsheet.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/widgets/app_logo_with_terms_condition_widget.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';
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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  // final TextEditingController _specializationCtrl = TextEditingController();
  final TextEditingController _regNumCtrl = TextEditingController();
  final TextEditingController _expCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _socialCtrl = TextEditingController();
  final FocusNode _socialUrlFocusNode = FocusNode();

  final ValueNotifier<List<String>> urlList = ValueNotifier<List<String>>([]);

  List<SpecializationEntity> specialisationList = [];
  String? selectedSpecification;

  final ImagePicker picker = ImagePicker();
  XFile? profilePic;
  String? profilePicKey;
  List<String> _userNames = [];
  String? _selectedUserName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isUserNameAvailable = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    if (widget.profession == "Doctor") {
      context.read<RegistrationCubit>().getSpecialisations();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _focusNode.addListener(_onFocusNodeChanges);
    _socialUrlFocusNode.addListener(_socialMediaNodeChanges);
    super.initState();
  }

  @override
  void dispose() {
    urlList.dispose();
    _userNameController.dispose();
    _focusNode.removeListener(() {});
    _focusNode.dispose();
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
            } else if (state is UploadDocumentSuccessState) {
              profilePic = state.file;
              profilePicKey = state.data.key;
            } else if (state is GenerateUserNamesSuccessState) {
              _isUserNameAvailable = state.entity.userNameAvailable;
              _userNames = state.entity.userNames;
            } else if (state is GenerateUserNamesErrorState) {
              _isUserNameAvailable = false;
              widget.showErrorToast(context: context, message: state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
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
                  if (widget.profession == "User")
                    _buildPatientScreen()
                  else ...[
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
                                      style: theme.publicSansFonts
                                          .semiBoldStyle(
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
                    // if (widget.profession == "Doctor" ||
                    //     widget.profession == 'Influencer') ...[
                    TextFormFieldWidget(
                      validator: (value) =>
                          value.isEmpty ? 'Please Enter Full Name' : null,
                      title: "Full Name",
                      controller: _nameCtrl,
                      hintText: 'Enter Full Name',
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                    ),
                    const SizedBox(height: 20),
                    // ],
                    TextFormFieldWidget(
                      validator: (value) => value.isEmpty
                          ? 'Please Enter UserName'
                          : !_isUserNameAvailable && _selectedUserName == null
                              ? 'UserName is not Available'
                              : null,
                      title: "User Name",
                      hintText: 'Enter User Name',
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                      focusNode: _focusNode,
                      controller: _userNameController,
                    ),
                    if (!_isUserNameAvailable) component.spacer(height: 10),
                    if (!_isUserNameAvailable)
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            _userNames.map((e) => _buildUserName(e)).toList(),
                      ),
                    component.spacer(height: 20),
                    TextFormWithCountryCode(
                      title: context.stringForKey(StringKeys.mobileNumber),
                      hintText: 'Enter Mobile Number',
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                      countryCode: _countryCode,
                      controller: _mobCtrl,
                    ),
                    component.spacer(height: 20),
                    TextFormFieldWidget(
                      title: "Email",
                      validator: (value) => value.isEmpty
                          ? 'Please Enter Email'
                          : !value.isValidEmail
                              ? 'Please Enter Valid Email'
                              : null,
                      hintText: 'Enter Email Address',
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                      controller: _emailCtrl,
                      textCapitalization: TextCapitalization.none,
                    ),
                    component.spacer(height: 20),
                    TextFormFieldWidget(
                      title: "Age",
                      controller: _ageCtrl,
                      textInputType: TextInputType.number,
                      hintText: 'Enter Age',
                      maxLength: 2,
                      hintTextStyle: theme.publicSansFonts.regularStyle(
                          fontSize: 16, fontColor: AppColors.grey92),
                      validator: (value) => value.isEmpty
                          ? 'Please Enter Age'
                          : Utils.isValidAge(value),
                      suffixWidget: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Text(
                          "Years",
                          style: theme.publicSansFonts
                              .regularStyle(fontSize: 16, height: 22),
                        ),
                      ),
                    ),
                    component.spacer(height: 20),
                    if (widget.profession == "Doctor") ...[
                      // TextFormFieldWidget(
                      //   title: "Specialization",
                      //   controller: _specializationCtrl,
                      // ),
                      TextSearchField(
                        textCapitalization: TextCapitalization.words,
                        title: "Specialization",
                        hintTextStyle: theme.publicSansFonts.regularStyle(
                            fontSize: 16, fontColor: AppColors.grey92),
                        validator: (value) => value.isEmpty
                            ? 'Please Select Specialization'
                            : null,
                        onSuggestionTap: (value) {
                          selectedSpecification = value.item;
                        },
                        suggestions: specialisationList
                            .map((e) => SearchFieldListItem(e.name,
                                item: e.id,
                                child: component.text(
                                  e.name.capitalizeFirstLetterOfSentence,
                                  style: theme.publicSansFonts.regularStyle(
                                      fontSize: 18,
                                      fontColor: AppColors.black49),
                                )))
                            .toList(),
                      ),
                      component.spacer(height: 20),
                      TextFormFieldWidget(
                        title: "Professional Registration number",
                        validator: (value) => value.isEmpty
                            ? 'Please Enter Registration Number'
                            : null,
                        hintText: 'Enter Registration Number',
                        hintTextStyle: theme.publicSansFonts.regularStyle(
                            fontSize: 16, fontColor: AppColors.grey92),
                        controller: _regNumCtrl,
                      ),
                      component.spacer(height: 20),
                      TextFormFieldWidget(
                        hintText: "Experience",
                        hintTextStyle: theme.publicSansFonts.regularStyle(
                            fontSize: 16, fontColor: AppColors.grey92),
                        textInputType: TextInputType.number,
                        title: "Total year of experience",
                        validator: (value) =>
                            value.isEmpty ? 'Please Enter Experience' : null,
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
                      component.spacer(height: 20),
                    ] else if (widget.profession == "Influencer") ...[
                      TextFormFieldWidget(
                        focusNode: _socialUrlFocusNode,
                        title: "Social Profile URL",
                        controller: _socialCtrl,
                        validator: (value) => urlList.value.isEmpty
                            ? 'Please Enter Social Profile URL'
                            : null,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          if (_socialCtrl.text.trim().isNotEmpty) {
                            _initUrl();
                          }
                        },
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                        ),
                        label: component.text('Add more',
                            style: theme.publicSansFonts.semiBoldStyle(
                              fontColor: AppColors.color0xFF8338EC,
                              fontSize: 16,
                            )),
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 30,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                  ],
                  const SizedBox(height: 70),
                  CustomButton(
                    isLoading: state is RegistrationLoading,
                    onPressed: () {
                      // if (_selectedUserName == null && !_isUserNameAvailable) {
                      //   widget.showErrorToast(
                      //       context: context,
                      //       message: 'Please Select Any UserName');
                      //   return;
                      // }
                      if (_formKey.currentState!.validate()) {
                        _callRegistrationApi(
                            isPatient: widget.profession == "User");
                      }
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
              ),
            );
          },
        ),
      ),
    );
  }

  void _callRegistrationApi({bool isPatient = false}) {
    context.read<RegistrationCubit>().registration(
          RegistrationParams(
              role: giveRole(),
              profilePic: profilePicKey,
              fullName: isPatient ? null : _nameCtrl.text,
              countryCode: _countryCode.text,
              phoneNumber: int.tryParse(_mobCtrl.text),
              email: isPatient ? null : _emailCtrl.text,
              specializationId: selectedSpecification,
              registrationNumber: isPatient ? null : _regNumCtrl.text,
              experience: int.tryParse(_expCtrl.text),
              age: isPatient ? null : _ageCtrl.text,
              socialUrls: urlList.value.isNotEmpty ? urlList.value : null,
              userName: isPatient
                  ? null
                  : _isUserNameAvailable
                      ? _userNameController.text
                      : _selectedUserName!),
        );
  }

  void _initUrl() {
    urlList.value.add(_socialCtrl.text.trim());
    urlList.value = [...urlList.value];
    _socialCtrl.clear();
  }

  void _onFocusNodeChanges() {
    if (!_focusNode.hasFocus && _userNameController.text.isNotEmpty) {
      _callUserNameApi();
    }
  }

  void _socialMediaNodeChanges() {
    if (!_socialUrlFocusNode.hasFocus && _socialCtrl.text.isNotEmpty) {
      _initUrl();
    }
  }

  void _callUserNameApi() {
    context
        .read<RegistrationCubit>()
        .generateUsernames(userName: _userNameController.text);
  }

  Widget _buildUserName(String userName) {
    final isSelected = _selectedUserName == userName;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUserName = userName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primaryColor : AppColors.color0xFFFCFCFD,
            borderRadius: BorderRadius.circular(44),
            border: Border.all(color: AppColors.color0xFFDBDBDB)),
        child: component.text(userName,
            style: theme.publicSansFonts.mediumStyle(
                fontSize: 16,
                fontColor:
                    isSelected ? AppColors.white : AppColors.color0xFF85799E)),
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
            child: OtpBottomsheet(
              regData: RegistrationParams(
                  role: giveRole(),
                  profilePic: profilePicKey,
                  fullName: _nameCtrl.text,
                  countryCode: _countryCode.text,
                  phoneNumber: int.tryParse(_mobCtrl.text),
                  email: _emailCtrl.text,
                  specializationId: selectedSpecification,
                  registrationNumber: _regNumCtrl.text,
                  experience: int.tryParse(_expCtrl.text),
                  age: _ageCtrl.text,
                  socialUrls: urlList.value.isNotEmpty ? urlList.value : null,
                  userName: _isUserNameAvailable
                      ? _userNameController.text
                      : _selectedUserName!),
            ),
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

  Widget _buildPatientScreen() {
    return TextFormWithCountryCode(
      title: context.stringForKey(StringKeys.mobileNumber),
      countryCode: _countryCode,
      controller: _mobCtrl,
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
