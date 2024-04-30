import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/common_widgets/time_container.dart';
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
import 'package:my_sutra/features/presentation/patient/search/bottomsheet/dr_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/widgets/dashboard_helper_items.dart';
import 'package:my_sutra/features/presentation/patient/widgets/date_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import '../../../../domain/entities/patient_entities/appointment_entity.dart';

part 'appointment_screen_states/doctor_appointment_screen_state.dart';

part 'appointment_screen_states/patient_appointment_screen_state.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState.init();
}

abstract class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDateTime = DateTime.now();
  final DateFormat _serverDateFormat = DateFormat('yyyy-MM-dd');
  final List<AppointmentEntity> _appointments = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  UserEntity? _userEntity;

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
        if (state is GetHomeDataSuccessState) {
          _userEntity = state.entity;
        } else if (state is GetAppointmentsSuccessState) {
          //todo will have to improve the code for pagination
          _isLoading = false;
          _appointments.clear();
          _appointments.addAll(state.appointmentEntities);
        } else if (state is GetDoctorAppointmentSuccessState) {
          _isLoading = false;
        }
      },
      buildWhen: (previousState, newState) => previousState != newState,
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

  Widget _buildAppBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
              (_userEntity?.fullName ?? '').isNotEmpty
                  ? _userEntity?.fullName
                  : _userEntity?.username,
              style: theme.publicSansFonts.semiBoldStyle(
                fontColor: AppColors.blackColor,
                fontSize: 24,
                height: 28,
              ),
            ),
          ],
        ),
        // Container(
        //   width: 38,
        //   height: 38,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(8),
        //     child:
        component.networkImage(
            url: _userEntity?.profilePic ?? '',
            height: 38,
            width: 38,
            borderRadius: 4,
            fit: BoxFit.fill,
            errorWidget:
                component.assetImage(path: Assets.imagesDefaultAvatar)),
        // ),
        // ),
      ],
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

  void _navigateToSearchDoctorScreen() {
    AiloitteNavigation.intent(context, AppRoutes.searchResultRoute);
  }
}
