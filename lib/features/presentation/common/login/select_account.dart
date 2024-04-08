import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/screentop_handler.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class SelectAccountScreen extends StatefulWidget {
  const SelectAccountScreen({super.key});

  @override
  State<SelectAccountScreen> createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  List<UserData> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopHandler(),
          Padding(
            padding: AppDeco.screenPadding,
            child: Text(
              "Select Account",
              style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: AppDeco.screenPadding,
            child: Text(
              "Tap on profile to login to account",
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16, fontColor: AppColors.black21.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<SelectAccountCubit, SelectAccountState>(
              listener: (context, state) {
                if (state is SelectAccountError) {
                  widget.showErrorToast(context: context, message: state.error);
                } else if (state is SelectAccountLoaded) {
                  users = state.data;
                } else if (state is SelectedAccountLoaded) {}
              },
              builder: (context, state) {
                if (state is SelectAccountLoading) {
                  return LoadingAnimationWidget.hexagonDots(
                    color: AppColors.primaryColor,
                    size: 30,
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<SelectAccountCubit>()
                            .getSelectedAccountData(users[index].id!);
                      },
                      child: Container(
                        decoration: AppDeco.cardDecoration,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  users[index].profilePic ??
                                      Constants.tempNetworkUrl),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index].fullName ?? "",
                                    style: theme.publicSansFonts
                                        .semiBoldStyle(fontSize: 18),
                                  ),
                                  Text(
                                    users[index]
                                            .role
                                            ?.capitalizeFirstLetterOfEveryWord ??
                                        "",
                                    style: theme.publicSansFonts.regularStyle(
                                        fontSize: 14,
                                        fontColor: AppColors.black49),
                                  ),
                                  if (users[index].specializationName != null)
                                    Text(
                                      users[index].specializationName!,
                                      style: theme.publicSansFonts.regularStyle(
                                          fontSize: 14,
                                          fontColor: AppColors.black49),
                                    ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.neutral,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                  "Login with another number",
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
