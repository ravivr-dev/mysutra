import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/common_widgets/time_container.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/custom_inkwell.dart';
import 'package:my_sutra/core/utils/screentop_handler.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_entity.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/screens/bottom_sheets/patient_appointment_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/common/video_calling/video_calling_screen.dart';
import 'package:my_sutra/features/presentation/patient/search/bottomsheet/dr_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/search/search_result_screen.dart';
import 'package:my_sutra/features/presentation/patient/widgets/date_widget.dart';
import 'package:my_sutra/features/presentation/patient/widgets/rate_appointment_screen.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/main.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../patient/search_filter_screen.dart';
import '../../chat_screen/chat_screen.dart';

part 'appointment_screen_states/doctor_appointment_screen_state.dart';

part 'appointment_screen_states/patient_appointment_screen_state.dart';

class AppointmentScreen extends StatefulWidget {
  final UserEntity? entity;

  const AppointmentScreen({super.key, required this.entity});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState.init();
}

abstract class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDateTime = DateTime.now();
  final DateFormat _serverDateFormat = DateFormat('yyyy-MM-dd');
  final List<AppointmentEntity> _appointments = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool isCalling = false;

  ///This is for pagination
  bool _isLoading = false;

  //todo find logic for Join Now button
  // late Timer _joinNowButtonTimer;

  _AppointmentScreenState();

  factory _AppointmentScreenState.init() {
    final isDoctor = UserHelper.role == UserRole.doctor;
    return isDoctor ? _DoctorAppointmentState() : _PatientAppointmentState();
  }

  Widget _buildBody(HomeState state);

  void _callAppointmentApi();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _callAppointmentApi();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetAppointmentsSuccessState) {
          //todo will have to improve the code for pagination
          _isLoading = false;
          _appointments.clear();
          _appointments.addAll(state.appointmentEntities);
        } else if (state is GetDoctorAppointmentSuccessState) {
          _isLoading = false;
        } else if (state is GetVideoRoomSuccessState) {
          AiloitteNavigation.intentWithData(
            context,
            AppRoutes.videoCallingRoute,
            VideoCallingArgs(
              appointment: state.appointment,
              entity: state.data,
              isVideoCall: state.isVideoCall,
              name: state.name,
              roomId: state.roomId,
              remoteUserId: state.remoteUserId,
              currentUserId: state.currentUserId,
            ),
          ).then((_) {
            if (UserHelper.role == UserRole.patient) {
              AiloitteNavigation.intentWithData(
                  context,
                  AppRoutes.rateAppointmentRoute,
                  RateAppointmentArgs(
                      appointmentId: state.appointmentId,
                      doctorId: state.remoteUserId));
            }
            isCalling = false;
          });
        } else if (state is GetVideoRoomErrorState) {
          isCalling = false;
          widget.showErrorToast(context: context, message: state.message);
        } else if (state is GetVideoRoomSuccessState) {
          isCalling = false;
        }
      },
      buildWhen: (previousState, newState) =>
          previousState != newState ||
          newState is GetVideoRoomSuccessState ||
          newState is GetVideoRoomErrorState,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: CustomInkwell(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: _buildBody(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCallingRowWidget(
      {required AppointmentEntity appointment, required bool isDoctor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCallingRowItem(
            icon: Assets.iconsChat,
            onTap: () {
              final canJoin = _canJoinAppointment(
                  appointment: appointment,
                  errorMessage: "Can't chat before time");
              if (canJoin) {
                _goToChatScreen(appointment, isDoctor);
              }
            }),
        component.spacer(width: 8),
        _buildCallingRowItem(
            icon: Assets.iconsPhone,
            onTap: () {
              if (!isCalling) {
                _onVideoCallClick(
                    appointment: appointment,
                    isVideoCall: false,
                    isDoctor: isDoctor);
              }
            }),
        component.spacer(width: 8),
        _buildCallingRowItem(
            icon: Assets.iconsVideo2,
            color: AppColors.color0xFF8338EC,
            onTap: () {
              if (!isCalling) {
                _onVideoCallClick(appointment: appointment, isDoctor: isDoctor);
              }
            }),
      ],
    );
  }

  bool _canJoinAppointment(
      {required AppointmentEntity appointment, String? errorMessage}) {
    final appointmentHours = DateFormat('hh:mm a').parse(appointment.time);
    DateTime appointmentStartTime = DateTime.parse(appointment.date)
        .toUtc()
        .add(Duration(
            hours: appointmentHours.hour, minutes: appointmentHours.minute));
    final appointmentEndTime =
        appointmentStartTime.add(Duration(minutes: appointment.duration));
    final now = DateTime.now();

    if (Utils.isFutureTime(appointmentStartTime)) {
      widget.showErrorToast(
          context: context,
          message: errorMessage ?? "Can't join call before time");
      setState(() {
        isCalling = false;
      });
      return false;
    } else if (now.hour > appointmentEndTime.hour ||
        (now.hour == appointmentEndTime.hour &&
            now.minute > appointmentEndTime.minute) ||
        Utils.isPastTime(appointmentEndTime)) {
      debugPrint(appointmentHours.toString());
      widget.showErrorToast(
          context: context, message: 'Appointment time has finished');
      setState(() {
        isCalling = false;
      });
      return false;
    } else if (now.hour < appointmentEndTime.hour ||
        (now.hour == appointmentEndTime.hour &&
            now.minute < appointmentEndTime.minute)) {
      return true;
    }
    setState(() {
      isCalling = false;
    });
    return false;
  }

  bool _canShowRatingScreen({required AppointmentEntity appointment}) {
    final appointmentHours = DateFormat('hh:mm a').parse(appointment.time);
    DateTime appointmentStartTime = DateTime.parse(appointment.date)
        .toUtc()
        .add(Duration(
            hours: appointmentHours.hour, minutes: appointmentHours.minute));
    final appointmentEndTime =
        appointmentStartTime.add(Duration(minutes: appointment.duration));

    if (Utils.isPastTime(appointmentEndTime)) {
      return true;
    }
    return false;
  }

  void _onVideoCallClick(
      {required AppointmentEntity appointment,
      bool isVideoCall = true,
      required bool isDoctor}) {
    setState(() {
      isCalling = true;
    });
    if (_canJoinAppointment(appointment: appointment)) {
      _callVideoSdkRoomApi(
        appointment,
        isVideoCall: isVideoCall,
        isDoctor: isDoctor,
      );
    }
  }

  Widget _buildCallingRowItem(
      {required String icon, Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: color ?? AppColors.color0xFFE2E8F0,
            borderRadius: BorderRadius.circular(6)),
        child: component.assetImage(
            path: icon,
            color: color != null ? AppColors.white : AppColors.color0xFF3D3D3D),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back",
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              component.text(
                widget.entity?.fullName ?? widget.entity?.username ?? '',
                // Utils.getNameOrUsername(
                //     widget.entity?.fullName, widget.entity?.username),
                style: theme.publicSansFonts.mediumStyle(
                  fontColor: AppColors.blackColor,
                  fontSize: 24,
                  height: 28,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          width: 38,
          height: 38,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.grey92.withOpacity(.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: component.networkImage(
              url: widget.entity?.profilePic ?? '',
              fit: BoxFit.fill,
              errorWidget: Icon(
                Icons.person,
                color: AppColors.black21.withOpacity(.5),
              )),
        ),
      ],
    );
  }

  void _goToChatScreen(AppointmentEntity appointment, bool isDoctor) {
    AiloitteNavigation.intentWithData(
      context,
      AppRoutes.chatScreen,
      ChatScreenArgs(
        roomId: '${appointment.doctorId}${appointment.userId}',
        username: appointment.fullName ?? appointment.username ?? '',
        currentUserId: isDoctor ? appointment.doctorId! : appointment.userId!,
        profilePic: appointment.profilePic,
        remoteUserId: isDoctor ? appointment.userId! : appointment.doctorId!,
      ),
    );
  }

  void _callVideoSdkRoomApi(AppointmentEntity appointment,
      {bool isVideoCall = true, required bool isDoctor}) {
    context.read<HomeCubit>().getVideoRoomId(
          appointment: appointment,
          appointmentId: appointment.id,
          isVideoCall: isVideoCall,
          name: appointment.fullName ?? appointment.username ?? '',
          currentUserId: isDoctor ? appointment.doctorId! : appointment.userId!,
          remoteUserId: isDoctor ? appointment.userId! : appointment.doctorId!,
          roomId: '${appointment.doctorId}${appointment.userId}',
        );
  }

  Widget _buildAppointmentDateWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Appointments",
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 16, fontColor: AppColors.blackColor),
          ),
          DateWidget(
            onDateChanged: (DateTime selectedDate) {
              _selectedDateTime = selectedDate;
              _reInitPage();
              _callAppointmentApi();
            },
          )
        ],
      ),
    );
  }

  String _getAppointmentTime(String date, String time) {
    return '${Utils.getMonthDay(date)}, $time';
  }

  void _reInitPage() {
    _page = 1;
  }

  String get _getServerDate {
    return _serverDateFormat.format(_selectedDateTime);
  }

  void _initIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _onScroll() {
    if (_isLoading) return;
    _initIsLoading();
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      _page++;
      _callAppointmentApi();
    }
  }
}
