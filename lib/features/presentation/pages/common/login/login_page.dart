import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/mobile_form_widget.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/presentation/pages/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/login/otp_bottomsheet.dart';
import 'package:my_sutra/features/presentation/pages/common/registration/widgets/app_logo_with_terms_condition_widget.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _countryCode = TextEditingController();
  final TextEditingController _mobCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _countryCode.dispose();
    _mobCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 22, right: 22),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                // if (state is AcademyLoaded) {
                //   listOfCenters = state.academies;
                // } else if (state is LoginError) {
                //   widget.showErrorToast(context: context, message: state.error);
                // } else if (state is LoginSuccess) {
                //   widget.showSuccessToast(
                //       context: context, message: state.message);
                //   showOtpBottomSheet();
                // }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLogoWithTermsConditionWidget(),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          context.stringForKey(StringKeys.login),
                          style:
                              theme.publicSansFonts.semiBoldStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormWithCountryCode(
                          title: context.stringForKey(StringKeys.mobileNumber),
                          countryCode: _countryCode,
                          controller: _mobCtrl,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomButton(
                          text: StringKeys.login.toUpperCase(),
                          isLoading: false,
                          onPressed: () {
                            if (_mobCtrl.text == "" ||
                                _mobCtrl.text.length != 10) {
                              widget.showErrorToast(
                                  context: context,
                                  message:
                                      "Please enter a valid mobile number");
                            } else {
                              showOtpBottomSheet();
                              // context.read<LoginCubit>().login(
                              //       LoginParams(
                              //           academy: selectedAcademy!,
                              //           countryCode: _countryCode.text,
                              //           phoneNumber: _mobCtrl.text),
                              //     );
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: () {
                            AiloitteNavigation.intentWithClearAllRoutes(
                                context, AppRoutes.chooseAccountTypeRoute);
                          },
                          child: Text(
                            "Create an account",
                            style: theme.publicSansFonts.regularStyle(
                              fontSize: 16,
                              height: 22,
                              fontColor: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(),
                    const SizedBox(),
                  ],
                );
              },
            ),
          ),
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
            child: OtpBottomsheet(
              data: LoginParams(
                  countryCode: _countryCode.text, phoneNumber: _mobCtrl.text),
            ),
          );
        });
  }
}
