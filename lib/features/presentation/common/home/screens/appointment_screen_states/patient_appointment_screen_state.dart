part of 'package:my_sutra/features/presentation/common/home/screens/appointment_screen.dart';

class _PatientAppointmentState extends _AppointmentScreenState {
  SearchFilterArgs? args;

  @override
  Widget _buildBody(state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          decoration: AppDeco.drawerDecoration,
          width: context.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenTopHandler(),
              _buildAppBar(),
              const SizedBox(height: 16),
              SearchWithFilter(
                onTapFilter: (searchModel) {
                  args = searchModel;
                  _navigateToSearchDoctorScreen(args: args);
                },
                filter: args,
                hintText: 'Search for doctors',
                readOnly: true,
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
              return Container(
                decoration: AppDeco.cardDecoration,
                padding: const EdgeInsets.all(12),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    component.networkImage(
                      url: appointment.profilePic ?? '',
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                      borderRadius: 8,
                      errorWidget: component.assetImage(
                          path: Assets.imagesDefaultAvatar),
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
                                    fontSize: 16,
                                    fontColor: AppColors.blackColor),
                              ),
                              const SizedBox(width: 5),
                              component.assetImage(path: Assets.iconsVerify),
                            ],
                          ),
                          component.text(
                            appointment.specialization,
                            style: theme.publicSansFonts
                                .regularStyle(fontColor: AppColors.black81),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.blackF2,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                                  "${Utils.getMonthDay(appointment.date)}, ${appointment.time}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          context.showBottomSheet(
                            DrBottomSheet(
                              appointment: appointment,
                            ),
                            borderRadius: 22,
                          );
                        },
                        child:
                            component.assetImage(path: Assets.iconsThreeDots)),
                  ],
                ),
              );
            }),
      ],
    );
  }

  @override
  void _callAppointmentApi() {
    context
        .read<HomeCubit>()
        .getAppointments(date: _getServerDate, pagination: _page, limit: 10);
  }

  void _navigateToSearchDoctorScreen({SearchFilterArgs? args}) {
    AiloitteNavigation.intentWithData(
        context, AppRoutes.searchResultRoute, SearchResultArgs(filter: args));
  }
}
