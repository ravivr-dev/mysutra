import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/my_profile_screen.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class MyPatientsScreen extends StatefulWidget {
  final MyPatientsArgs myPatientsArgs;

  const MyPatientsScreen({super.key, required this.myPatientsArgs});

  @override
  State<MyPatientsScreen> createState() => _MyPatientsScreenState();
}

class _MyPatientsScreenState extends State<MyPatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Patients'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  AiloitteNavigation.intent(
                      context, AppRoutes.doctorPastAppointment);
                },
                child: _buildPatientInfoCard(widget.myPatientsArgs.patients[index]));
          },
          separatorBuilder: (_, index) {
            return component.spacer(height: 12);
          },
          itemCount: widget.myPatientsArgs.patients.length),
    );
  }

  Widget _buildPatientInfoCard(PatientEntity patient) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      padding: const EdgeInsets.all(12),
      height: 96,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.white),
      child: Row(
        children: [
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            component.networkImage(
              url: patient.profilePic ?? Constants.tempNetworkUrl,
              height: 72,
              width: 72,
              borderRadius: 8,
            ),
            component.assetImage(path: Assets.iconsVideoCallIcon),
          ]),
          component.spacer(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              component.text(patient.userName,
                  style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
              Row(
                children: [
                  component.assetImage(
                    path: Assets.iconsCallReceivedIcon,
                  ),
                  component.spacer(width: 2),
                  component.text('+91 ${patient.phoneNumber}',
                      style: theme.publicSansFonts.regularStyle(
                          fontSize: 14, fontColor: AppColors.black81))
                ],
              ),
              component.spacer(height: 8),
              component.text(
                  'Last appointment on ${DateFormat("").format(DateTime.parse(patient.date ?? ''))}, ${patient.time}',
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 14, fontColor: AppColors.color0xFF85799E))
            ],
          )
        ],
      ),
    );
  }
}
