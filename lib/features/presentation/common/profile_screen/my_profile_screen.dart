import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/change_data_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/bottom_sheets/about_me_bottomsheet.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../../../injection_container.dart';
import '../../../domain/entities/patient_entities/patient_entity.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileEntity? my;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProfileDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = UserHelper.role;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetPatientSuccessState) {
          _goToMyPatientScreen(state.patients);
        } else if (state is GetPatientErrorState) {
          _showToast(message: 'Not Able To Show Patient Please Try Again');
        } else if (state is GetProfileDetailsSuccessState) {
          my = state.entity;
        } else if (state is GetFollowingLoadedState) {
          if (userRole == UserRole.doctor) {
            _goToDoctorFollowingScreen(state.myFollowings);
          } else {
            AiloitteNavigation.intentWithData(
                context, AppRoutes.patientMyFollowing, state.myFollowings);
          }
        } else if (state is GetFollowingErrorState) {
          _showToast(message: state.message);
        }
      },
      builder: (context, state) {
        // if (userRole != UserRole.guest ||
        //     state is GetProfileDetailsSuccessState) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: component.text(context.stringForKey(StringKeys.myProfile)),
            actions: [
              IconButton(
                onPressed: () {
                  logoutDialog();
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// don't remove this container i was facing some isue after removing this so will have to debug
                _buildProfileWidget(),
                component.spacer(height: 16),
                if (userRole != UserRole.doctor)
                  _buildUserName()
                else
                  ..._buildDoctorDetailsWidgets(context),
                component.spacer(height: 12),
                const Divider(color: AppColors.dividerColor),
                component.spacer(height: 12),
                if (userRole == UserRole.doctor) ...[
                  _buildCard(
                      value: 'My Patients',
                      onTap: () {
                        if (userRole == UserRole.doctor) {
                          //todo make it dynamic (implement pagination)
                          context
                              .read<ProfileCubit>()
                              .getPatients(pagination: 1, limit: 25);
                        }
                      },
                      icons: Assets.iconsUserCircle),
                  component.spacer(height: 12),
                ],
                _buildCard(
                    value: 'My Following',
                    icons: Assets.iconsUserAdd,
                    onTap: () {
                      context
                          .read<ProfileCubit>()
                          .getFollowing(pagination: 1, limit: 35);
                    }),
                component.spacer(height: 12),
                if (userRole == UserRole.doctor) ...[
                  _buildCard(
                      value: 'Settings',
                      icons: Assets.iconsSetting,
                      onTap: () {
                        AiloitteNavigation.intent(
                            context, AppRoutes.settingRoute);
                      }),
                  component.spacer(height: 12),
                ],
                if (userRole ==
                        UserRole
                            .patient /*||
                      userRole == UserRole.guest*/
                    ) ...[
                  _buildCard(
                      value: 'Past Appointments',
                      icons: Assets.iconsClock,
                      onTap: () {
                        AiloitteNavigation.intent(
                            context, AppRoutes.patientPastAppointment);
                      }),
                  component.spacer(height: 12),
                ],
                _buildTileCard(
                    isEmail: false,
                    icon: Assets.iconsPhone,
                    text: 'Mobile number',
                    subText: my?.phoneNumber.toString() ?? ''),
                component.spacer(height: 12),
                _buildTileCard(
                    isEmail: true,
                    icon: Assets.iconsEmail,
                    text: 'Email Address',
                    subText: my?.email ?? ''),
              ],
            ),
          ),
        );
        // } else if (userRole == UserRole.guest) {
        //   return SizedBox(
        //     width: double.infinity,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         _buildProfileWidget(),
        //         component.spacer(height: 10),
        //         _buildUserName(name: 'Guest'),
        //       ],
        //     ),
        //   );
        // }
        // return const SizedBox.shrink();
      },
    );
  }

  Widget _buildProfileWidget() {
    return Container(
      height: 130,
      width: 130,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: AppColors.grey92.withOpacity(.1),
          borderRadius: BorderRadius.circular(12)),
      child: component.networkImage(
          url: my?.profilePic ?? '',
          errorWidget: component.assetImage(path: Assets.imagesDefaultAvatar)),
    );
  }

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }

  List<Widget> _buildDoctorDetailsWidgets(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserName(),
          component.spacer(width: 4),
          component.assetImage(
            path: Assets.iconsVerify,
            height: 24,
            width: 24,
            fit: BoxFit.fill,
          )
        ],
      ),
      component.text(
          '${my?.specialization?.name ?? ''} | ${my?.totalExperience} year experience'
              .capitalizeFirstLetterOfEveryWord,
          style: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF526371,
          )),
      component.spacer(height: 8),
      component.text('${my?.totalFollowers ?? ''} Followers',
          style: theme.publicSansFonts.semiBoldStyle(
            fontColor: AppColors.color0xFF85799E,
            fontSize: 16,
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: component.text(my?.about,
            textAlign: TextAlign.center,
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.neutral,
            )),
      ),
      component.textButton(
          title: 'Edit',
          callback: () async {
            final result = await context.showBottomSheet(
                BlocProvider<SettingCubit>(
                    create: (_) => sl<SettingCubit>(),
                    child: AboutMeBottomSheet(about: my?.about)));
            if (result != null && (result as String).isNotEmpty) {
              setState(() {
                my?.about = result;
              });
            }
          },
          titleStyle: theme.publicSansFonts.semiBoldStyle(
            fontSize: 14,
            fontColor: AppColors.color0xFF8338EC,
          )),
    ];
  }

  Widget _buildUserName() {
    return component.text(
      Utils.getNameOrUsername(my?.fullName, my?.username),
      style: theme.publicSansFonts.mediumStyle(
        fontSize: 25,
        fontColor: AppColors.black37,
      ),
    );
  }

  Widget _buildTileCard({
    required bool isEmail,
    required String icon,
    required String text,
    required String subText,
  }) {
    return Container(
      decoration: _getDecoration,
      padding: _getCardPadding,
      child: Row(
        children: [
          component.assetImage(path: icon),
          component.spacer(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text(text,
                    style: theme.publicSansFonts.mediumStyle(
                      fontColor: AppColors.grey92,
                      fontSize: 14,
                    )),
                component.text(subText,
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontColor: AppColors.black21,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // AiloitteNavigation.intentWithData(context,
              //     AppRoutes.changeDataRoute, ChangeDataParams(isEmail));
              Navigator.of(context)
                  .pushNamed(AppRoutes.changeDataRoute,
                      arguments: ChangeDataParams(isEmail))
                  .then((value) => _getProfileDetails());
            },
            child: component.text('Change',
                style: theme.publicSansFonts.semiBoldStyle(
                  fontColor: AppColors.color0xFF8338EC,
                  fontSize: 14,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      {required String value, required String icons, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: _getDecoration,
        padding: _getCardPadding,
        child: Row(
          children: [
            component.assetImage(path: icons),
            component.spacer(width: 5),
            component.text(value,
                style: theme.publicSansFonts.semiBoldStyle(
                  fontSize: 16,
                  fontColor: AppColors.black21,
                ))
          ],
        ),
      ),
    );
  }

  EdgeInsets get _getCardPadding {
    return const EdgeInsets.symmetric(vertical: 15, horizontal: 16);
  }

  BoxDecoration get _getDecoration {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 24,
            color: AppColors.color0xFF88A6FF.withOpacity(.05),
          )
        ]);
  }

  void _goToMyPatientScreen(List<PatientEntity> patients) {
    AiloitteNavigation.intentWithData(context, AppRoutes.myPatients, patients);
  }

  void _getProfileDetails() {
    context.read<ProfileCubit>().getProfileDetails();
  }

  void _goToDoctorFollowingScreen(List<UserDataEntity> followers) {
    AiloitteNavigation.intentWithData(
        context, AppRoutes.doctorMyFollowing, followers);
  }

  logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          iconPadding: const EdgeInsets.only(top: 40, bottom: 25),
          icon: SizedBox(
            height: 40,
            width: 40,
            child: component.assetImage(
              path: Assets.imagesLogout,
              fit: BoxFit.contain,
            ),
          ),
          title: component.text(
            "Logout",
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 30, fontColor: Colors.grey),
            textAlign: TextAlign.center,
          ),
          content: component.text(
            "Are you sure you want to logout ?",
            style: theme.publicSansFonts
                .regularStyle(fontSize: 16, fontColor: Colors.grey),
            textAlign: TextAlign.center,
          ),
          actionsPadding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          actions: [
            Column(
              children: [
                component.containedButton(
                  enabledColor: AppColors.primaryColor,
                  title: "Logout",
                  onTap: () {
                    AiloitteNavigation.intentWithClearAllRoutes(
                        context, AppRoutes.loginRoute);
                    context.read<MainCubit>().logout();
                  },
                ),
                const SizedBox(height: 15),
                component.outlinedButton(
                  title: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MyPatientsArgs {
  final List<PatientEntity> patients;

  MyPatientsArgs({required this.patients});
}
