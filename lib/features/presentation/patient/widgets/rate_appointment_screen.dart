import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/past_appointment_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/rate_appointment_usecase.dart';
import 'package:my_sutra/features/presentation/patient/cubit/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/widgets/star_rating_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class RateAppointmentScreen extends StatefulWidget {
  final RateAppointmentArgs args;

  const RateAppointmentScreen({super.key, required this.args});

  @override
  State<RateAppointmentScreen> createState() => _RateAppointmentScreenState();
}

class _RateAppointmentScreenState extends State<RateAppointmentScreen> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is RateAppointmentSuccess) {
          AiloitteNavigation.back(context);
        } else if (state is RateAppointmentError) {
          widget.showErrorToast(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text('How Was Your Experience?',
                    style: theme.publicSansFonts.semiBoldStyle(fontSize: 20)),
                component.text('Tap on Star to give star ratings below',
                    style: theme.publicSansFonts.regularStyle(
                        fontSize: 14, fontColor: AppColors.grey81)),
                if (widget.args.appointmentEntity != null) ...[
                  _buildInfoCard(),
                  component.divider(color: AppColors.color0xFFE3D9F0),
                  component.spacer(height: 10),
                  component.text('Rating:',
                      style: theme.publicSansFonts.semiBoldStyle(fontSize: 18)),
                  component.spacer(height: 10),
                ],
                StarRatingWidget(
                    rating: _rating,
                    onRatingChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    }),
              ],
            ),
          ),
          floatingActionButton: _buildSubmitRatingButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          component.networkImage(
              url: widget.args.appointmentEntity?.profilePic ?? '',
              height: 72,
              width: 72,
              fit: BoxFit.fill,
              errorWidget: component.assetImage(
                  path: Assets.imagesDefaultAvatar, fit: BoxFit.fill)),
          component.spacer(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              component.text(
                  'Dr. ${widget.args.appointmentEntity?.fullName ?? ''}',
                  style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
              component.text(
                  widget.args.appointmentEntity?.specialization ?? '',
                  style: theme.publicSansFonts
                      .regularStyle(fontSize: 14, fontColor: AppColors.grey81)),
              component.text('Time'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitRatingButton() {
    return InkWell(
      onTap: () {
        context.read<AppointmentCubit>().rateAppointment(RateAppointmentParams(
            appointmentId:
                widget.args.appointmentEntity?.id ?? widget.args.appointmentId,
            doctorId:
                widget.args.appointmentEntity?.doctorId ?? widget.args.doctorId,
            rating: _rating));
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primaryColor),
        child: Center(
          child: Text(
            'Submit my Ratings',
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 20, fontColor: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class RateAppointmentArgs {
  final String appointmentId;
  final String doctorId;
  final PastAppointmentResponseEntity? appointmentEntity;

  RateAppointmentArgs(
      {this.appointmentEntity,
      required this.appointmentId,
      required this.doctorId});
}
