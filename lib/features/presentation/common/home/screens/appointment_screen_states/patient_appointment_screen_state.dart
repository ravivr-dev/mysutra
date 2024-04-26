part of 'package:my_sutra/features/presentation/common/home/screens/appointment_screen.dart';

class _PatientAppointmentState extends _AppointmentScreenState {
  @override
  Widget _buildBody() {
    return BlocConsumer<HomeCubit, HomeState>(
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
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
              decoration: AppDeco.drawerDecoration,
              width: context.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ScreenTopHandler(),
                  _buildAppBar(),
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
            _buildAppointmentDateWidget(),
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
                        DrBottomSheet(
                          entity: appointment,
                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    component.text(
                                      "Dr. ${appointment.fullName}",
                                      style: theme.publicSansFonts.mediumStyle(
                                          fontSize: 12,
                                          height: 20,
                                          fontColor: AppColors.blackColor),
                                    ),
                                    const SizedBox(width: 5),
                                    component.assetImage(
                                        path: Assets.iconsVerify),
                                  ],
                                ),
                                component.text(
                                  appointment.specialization,
                                  style: theme.publicSansFonts.regularStyle(
                                      fontSize: 10,
                                      height: 20,
                                      fontColor: AppColors.black81),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.blackF2,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                        "${_getLocalTime(appointment.date)}, ${appointment.time}",
                                        style: theme.publicSansFonts
                                            .regularStyle(
                                                fontSize: 10,
                                                fontColor: AppColors.black64),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          component.assetImage(path: Assets.iconsThreeDots),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  @override
  void _callAppointmentApi() {
    context
        .read<HomeCubit>()
        .getAppointments(date: _getServerDate, pagination: _page, limit: 10);
  }
}
