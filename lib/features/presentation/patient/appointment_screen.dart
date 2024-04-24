import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/custom_inkwell.dart';
import 'package:my_sutra/core/utils/screentop_handler.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/bottomsheet/dr_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/widgets/dashboard_helper_items.dart';
import 'package:my_sutra/features/presentation/patient/widgets/date_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import '../../domain/entities/patient_entities/appointment_entity.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDateTime = DateTime.now();
  final DateFormat _serverDateFormat = DateFormat('yyyy-MM-dd');
  final List<AppointmentEntity> _appointments = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  ///This is for pagination
  bool _isLoading = false;

  //todo find logic for Join Now button
  // late Timer _joinNowButtonTimer;

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomInkwell(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is GetAppointmentsSuccessState) {
                _isLoading = false;
                _appointments.clear();
                _appointments.addAll(state.appointmentEntities);
              }
            },
            buildWhen: (previousState, newState) => previousState != newState,
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 40),
                    decoration: AppDeco.drawerDecoration,
                    width: context.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ScreenTopHandler(),
                        Row(
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
                                Text(
                                  "Sahil Gopal",
                                  style: theme.publicSansFonts.mediumStyle(
                                    fontColor: AppColors.blackColor,
                                    fontSize: 24,
                                    height: 28,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  Constants.tempNetworkUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SearchWithFilter(
                          onTapFilter: () {},
                          onTap: _navigateToSearchDoctorScreen,
                        ),
                        const SizedBox(height: 32),
                        const DashboardHelperItems(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Appointments",
                          style: theme.publicSansFonts.semiBoldStyle(
                              fontSize: 16, fontColor: AppColors.blackColor),
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
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 40, top: 20),
                      itemCount: _appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = _appointments[index];
                        return InkWell(
                          onTap: () {
                            context.showBottomSheet(
                              const DrBottomSheet(),
                              borderRadius: 22,
                            );
                          },
                          child: Container(
                            decoration: AppDeco.cardDecoration,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      Constants.tempNetworkUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          component.text(
                                            "Dr. ${appointment.fullName}",
                                            style: theme.publicSansFonts
                                                .mediumStyle(
                                                    fontSize: 12,
                                                    height: 20,
                                                    fontColor:
                                                        AppColors.blackColor),
                                          ),
                                          const SizedBox(width: 5),
                                          component.assetImage(
                                              path: Assets.iconsVerify),
                                        ],
                                      ),
                                      component.text(
                                        appointment.specialization,
                                        style: theme.publicSansFonts
                                            .regularStyle(
                                                fontSize: 10,
                                                height: 20,
                                                fontColor: AppColors.black81),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.blackF2,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.schedule_outlined,
                                              size: 11,
                                              color: AppColors.black81,
                                            ),
                                            const SizedBox(width: 5),
                                            component.text(
                                              "${_getLocalTime(appointment.date!)}, ${appointment.time}",
                                              style: theme.publicSansFonts
                                                  .regularStyle(
                                                      fontSize: 10,
                                                      fontColor:
                                                          AppColors.black64),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                component.assetImage(
                                    path: Assets.iconsThreeDots),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _reInitPage() {
    _page = 1;
  }

  String _getLocalTime(String date) {
    final dateTime = DateTime.parse(date);
    return DateFormat('MMM dd').format(dateTime);
  }

  String get _getServerDate {
    return _serverDateFormat.format(_selectedDateTime);
  }

  ///Only Patient can fetch appointments
  void _callAppointmentApi() {
    if (UserHelper.role != UserRole.patient) {
      return;
    }
    context
        .read<HomeCubit>()
        .getAppointments(date: _getServerDate, pagination: _page, limit: 10);
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
