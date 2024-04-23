import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        title: component.text(context.stringForKey(StringKeys.myProfile)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetPatientSuccessState) {
              _goToMyPatientScreen(state.patients);
            } else if (state is GetPatientErrorState) {
              _showToast(message: 'Not Able To Show Patient Please Try Again');
            } else if (state is GetProfileDetailsSuccessState) {
              my = state.entity;
            }
          },
          builder: (BuildContext context, ProfileState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                component.networkImage(
                  url: my?.profilePic ?? '',
                  height: 80,
                  width: 80,
                  errorWidget: const Icon(Icons.person),
                  fit: BoxFit.fill,
                ),
                component.spacer(height: 16),
                if (userRole == UserRole.patient)
                  _buildUserName()
                else
                  ..._buildDoctorDetailsWidgets(context),
                component.spacer(height: 12),
                const Divider(color: AppColors.dividerColor),
                component.spacer(height: 12),
                if (userRole != UserRole.influencer)
                  _buildCard(
                      value: userRole == UserRole.patient
                          ? 'My Doctors'
                          : 'My Patients',
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
                _buildCard(
                    value: 'My Following',
                    icons: Assets.iconsUserAdd,
                    onTap: () {
                      AiloitteNavigation.intent(context, AppRoutes.myFollowing);
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
                if (userRole == UserRole.patient) ...[
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
                    icon: Assets.iconsPhone,
                    text: 'Mobile number',
                    subText: '987654123'),
                component.spacer(height: 12),
                _buildTileCard(
                    icon: Assets.iconsEmail,
                    text: 'Email Address',
                    subText: 'hemuk9720@gmail.com'),
              ],
            );
          },
        ),
      ),
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
          '${my?.specialization?.name ?? ''} | ${my?.totalExperience} year experience',
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
      my?.fullName,
      style: theme.publicSansFonts.mediumStyle(
        fontSize: 25,
        fontColor: AppColors.black37,
      ),
    );
  }

  Widget _buildTileCard({
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
                    )),
                component.text(subText,
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontColor: AppColors.black21,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          component.text('Change',
              style: theme.publicSansFonts.semiBoldStyle(
                fontColor: AppColors.color0xFF8338EC,
                fontSize: 14,
              )),
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
}

class MyPatientsArgs {
  final List<PatientEntity> patients;

  MyPatientsArgs({required this.patients});
}
