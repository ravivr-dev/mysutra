import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/common/registration/widgets/account_type_item_widget.dart';
import 'package:my_sutra/features/presentation/common/registration/widgets/app_logo_with_terms_condition_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class ChooseAccountTypeScreen extends StatefulWidget {
  const ChooseAccountTypeScreen({super.key});

  @override
  State<ChooseAccountTypeScreen> createState() =>
      _ChooseAccountTypeScreenState();
}

class _ChooseAccountTypeScreenState extends State<ChooseAccountTypeScreen> {
  List<AcountType> listOfAccountTypes = [
    AcountType(
      icon: Assets.iconsDoctor,
      title: "Health Professional",
      subtitle:
          "Healthcare provider managing providing medical assistance to patients.",
      profession: "Doctor",
    ),
    AcountType(
      icon: Assets.iconsSneeze,
      title: "Patient",
      subtitle:
          "Access medical care, appointments, and records for personalized treatment.",
      profession: "Patient",
    ),
    AcountType(
        icon: Assets.iconsInfluencer,
        title: "Influencer",
        subtitle:
            "Promote health tips, collaborate with brands, advocate for wellness.",
        profession: "Influencer"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: AppDeco.screenPadding,
        children: [
           AppDeco.screenTopHandler,
          const AppLogoWithTermsConditionWidget(),
          const SizedBox(height: 60),
          Text(
            context.stringForKey(StringKeys.chooseAccount),
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
          ),
          const SizedBox(height: 15),
          ...List.generate(listOfAccountTypes.length, (index) {
            return AccountTypeItemWidget(data: listOfAccountTypes[index]);
          }),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: () {
                AiloitteNavigation.intentWithClearAllRoutes(
                    context, AppRoutes.loginRoute);
              },
              child: Text(
                "Sign in Instead",
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  height: 22,
                  fontColor: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
