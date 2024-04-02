import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/pages/common/registration/widgets/app_logo_with_terms_condition_widget.dart';

class ChooseAccountTypeScreen extends StatelessWidget {
  const ChooseAccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: ListView(
          padding: const EdgeInsets.only(top: 25, left: 22, right: 22),
          children: [
            const AppLogoWithTermsConditionWidget(),
            const SizedBox(height: 60),
            Text(
              context.stringForKey(StringKeys.chooseAccount),
              style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
            ),
            const SizedBox(height: 60),

            
          ],
        ),
      ),
    );
  }
}
