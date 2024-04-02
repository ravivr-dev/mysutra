import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/pages/common/registration/widgets/app_logo_with_terms_condition_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: AppDeco.screenPadding,
        children: [
          const SafeArea(child: SizedBox()),
          const AppLogoWithTermsConditionWidget(),
          const SizedBox(height: 60),
          Text(
            "For Doctors",
            style: theme.publicSansFonts
                .mediumStyle(fontSize: 14, fontColor: AppColors.primaryColor),
          ),
          Text(
            "Create an account",
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          Center(
            child: DottedBorder(
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
                        fontSize: 14, fontColor: AppColors.blackAE),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormFieldWidget(
            title: "Full Name",
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
          TextFormFieldWidget(
            title: "Specialization",
            controller: _specializationCtrl,
          ),
          TextFormFieldWidget(
            title: "Professional Registration number",
            controller: _regNumCtrl,
          ),
        ],
      ),
    );
  }
}
