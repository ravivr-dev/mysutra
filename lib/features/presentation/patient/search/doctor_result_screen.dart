import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/follow_user_usecase.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../../../core/utils/app_colors.dart';
import '../schedule_appointment_screen.dart';

class DoctorResultScreen extends StatelessWidget {
  final DoctorEntity doctorEntity;

  const DoctorResultScreen({super.key, required this.doctorEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 160,
                width: 160,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: component.networkImage(
                  fit: BoxFit.fill,
                  url: doctorEntity.profilePic ?? '',
                  errorWidget: component.assetImage(
                    path: Assets.imagesDefaultAvatar,
                  ),
                ),
              ),
            ),
            component.spacer(height: 12),
            Align(
              alignment: Alignment.center,
              child: component.text(
                doctorEntity.fullName,
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: component.text(
                  '${doctorEntity.specialization}   |   ₹${doctorEntity.fees?.toDouble() ?? 'not updated'}',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.color0xFF526371,
                  )),
            ),
            component.spacer(height: 12),
            BlocConsumer<SearchDoctorCubit, SearchDoctorState>(
              listener: (context, state) {
                if (state is FollowDoctorSuccessState) {
                  doctorEntity.reInitIsFollowing();
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        context.read<SearchDoctorCubit>().followDoctor(
                            params: FollowUserParams(userId: doctorEntity.id!));
                        // doctorEntity.reInitIsFollowing();
                      },
                      child: _buildFollowButton(
                          context: context,
                          isFollowed: doctorEntity.isFollowing!),
                    )),
                    component.spacer(width: 12),
                    Expanded(child: _buildBookAppointmentButton(context)),
                  ],
                );
              },
            ),
            component.spacer(height: 24),
            Row(children: [
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFF55ACEE,
                text: '${doctorEntity.patients}+',
                subText: 'Patients',
                iconPath: Assets.iconsUser,
              )),
              component.spacer(width: 12),
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFFFB5607,
                text: '${doctorEntity.experience} Years',
                subText: 'Experience',
                iconPath: Assets.iconsMedal,
              )),
              component.spacer(width: 12),
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFF8338EC,
                text: '${doctorEntity.ratings?.ceilToDouble() ?? ''}',
                subText: 'Ratings',
                iconPath: Assets.iconsStar,
              )),
            ]),
            component.spacer(height: 24),
            component.text('About doctor',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                )),
            component.spacer(height: 8),
            component.text(doctorEntity.about,
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 24),
            component.text('Working time',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                )),
            component.spacer(height: 8),
            component.text(
                '${doctorEntity.timings.firstTimeSlot?.day ?? ''}-${doctorEntity.timings.lastTimeSlot?.day ?? ''} (${Utils.getTimeFromMinutes(doctorEntity.timings.firstTimeSlot?.startTime ?? 0)} - ${Utils.getTimeFromMinutes(doctorEntity.timings.lastTimeSlot?.endTime ?? 0)})',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDecoratedContainer({
    required String text,
    required String subText,
    required Color color,
    required String iconPath,
  }) {
    return Container(
      height: 101,
      width: 108,
      padding: const EdgeInsets.only(top: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          component.text(text,
              style: theme.publicSansFonts.mediumStyle(
                fontSize: 16,
                fontColor: AppColors.blackColor,
              )),
          component.text(subText,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 12,
                fontColor: AppColors.black81,
              )),
          component.spacer(height: 4),
          Expanded(
            child: Container(
              width: double.infinity,
              color: color.withOpacity(.1),
              child: component.assetImage(path: iconPath),
            ),
          )
        ],
      ),
    );
  }

  void _showToast(BuildContext context, {required String message}) {
    showErrorToast(context: context, message: message);
  }

  void _bookAppointment(BuildContext context, String doctorID) {
    AiloitteNavigation.intentWithData(
        context,
        AppRoutes.scheduleAppointment,
        ScheduleAppointmentScreenArgs(
            doctorId: doctorID,
            isNewAppointment: true,
            fees: doctorEntity.fees));
  }

  Widget _buildBookAppointmentButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (doctorEntity.id == null) {
          _showToast(context,
              message:
                  'Not about to book appointment with this doctor Please try again');
          return;
        }
        _bookAppointment(context, doctorEntity.id!);
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.color0xFF8338EC,
        ),
        child: component.text('Book Appointment',
            style: theme.publicSansFonts.semiBoldStyle(
              fontSize: 14,
              fontColor: AppColors.white,
            )),
      ),
    );
  }

  Widget _buildFollowButton(
      {required BuildContext context, required bool isFollowed}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFollowed ? Icons.check : Icons.add,
            color: isFollowed
                ? AppColors.color0xFF15C0B6
                : AppColors.color0xFF8338EC,
          ),
          component.text(
            isFollowed
                ? context.stringForKey(StringKeys.following)
                : context.stringForKey(StringKeys.follow),
            style: theme.publicSansFonts.regularStyle(
              fontColor: isFollowed
                  ? AppColors.color0xFF15C0B6
                  : AppColors.color0xFF8338EC,
            ),
          )
        ],
      ),
    );
  }
}
