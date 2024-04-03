import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class SelectAccountScreen extends StatelessWidget {
  const SelectAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDeco.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDeco.screenTopHandler,
            Text(
              "Select Account",
              style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
            ),
            Text(
              "Tap on profile to login to account",
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16, fontColor: AppColors.black21.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: AppDeco.cardDecoration,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(Constants.tempNetworkUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. Surya Pandey",
                                style: theme.publicSansFonts
                                    .semiBoldStyle(fontSize: 18),
                              ),
                              Text(
                                "Physiotherapist",
                                style: theme.publicSansFonts.regularStyle(
                                    fontSize: 14, fontColor: AppColors.black49),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.neutral,
                          size: 16,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SafeArea(
              top: false,
              child: Center(
                child: InkWell(
                  onTap: () {
                    AiloitteNavigation.intentWithClearAllRoutes(
                        context, AppRoutes.loginRoute);
                  },
                  child: Text(
                    "Login with another account",
                    style: theme.publicSansFonts.regularStyle(
                      fontSize: 16,
                      height: 22,
                      fontColor: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
