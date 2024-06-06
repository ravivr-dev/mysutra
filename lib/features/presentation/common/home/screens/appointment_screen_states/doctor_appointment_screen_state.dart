part of 'package:my_sutra/features/presentation/common/home/screens/appointment_screen.dart';

class _DoctorAppointmentState extends _AppointmentScreenState {
  GetDoctorAppointmentEntity? entity;

  @override
  Widget _buildBody(HomeState state) {
    if (state is GetDoctorAppointmentSuccessState) {
      entity = state.entity;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderWidget(),
        // _buildAppointmentRequestWidget(),
        _buildAppointmentDateWidget(),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return _buildAppointmentWidget(entity!.list[index]);
          },
          separatorBuilder: (_, __) {
            return component.spacer(height: 12);
          },
          itemCount: entity?.list.length ?? 0,
        ),
        if (entity!= null && entity!.list.isEmpty) ...[
          Align(
              alignment: Alignment.center,
              child: component.text('No Appointments Found'))
        ],
      ],
    );
  }

  Widget _buildAppointmentWidget(AppointmentEntity entity) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: AppDeco.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              component.text(entity.username,
                  style: theme.publicSansFonts.mediumStyle(
                    fontSize: 16,
                  )),
              InkWell(
                  onTap: () =>
                      context.showBottomSheet(PatientAppointmentBottomSheet(
                        entity: entity,
                      )),
                  child: const Icon(Icons.more_horiz,
                      color: AppColors.color0xFFC4C4C4))
            ],
          ),
          component.spacer(height: 8),
          Row(
            children: [
              component.assetImage(path: Assets.iconsPhone2),
              component.spacer(width: 4),
              component.text('${entity.countryCode} ${entity.phoneNumber}',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.black81,
                  ))
            ],
          ),
          component.spacer(height: 4),
          if (entity.reason?.isNotEmpty ?? false) ...[
            component.text(entity.reason,
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 8),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TimeContainer(
                  time: _getAppointmentTime(entity.date, entity.time),
                ),
              ),
              component.spacer(width: 5),
              _buildCallingRowWidget(appointment: entity, isDoctor: true),
            ],
          )
        ],
      ),
    );
  }

//todo discuss this in scurm call like what is the use of appointment request
//   Widget _buildAppointmentRequestWidget() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
//       decoration: const BoxDecoration(
//         color: AppColors.color0xFFF3EBFF,
//       ),
//       child: Row(
//         children: [
//           component.assetImage(path: Assets.iconsCalendar2),
//           component.text(
//             'Appointment request',
//             style: theme.publicSansFonts.regularStyle(
//               fontColor: AppColors.color0xFF232323,
//             ),
//           ),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: AppColors.primaryColor.withOpacity(.15)),
//             child: component.text(
//               '13+',
//               style: theme.publicSansFonts.regularStyle(
//                   fontColor: AppColors.color0xFF232323, fontSize: 12),
//             ),
//           )
//         ],
//       ),
//     );
//   }

  Widget _buildHeaderWidget() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopHandler(),
          _buildAppBar(),
          component.spacer(height: 29),
          component.text(
            'Today\'s Appointments',
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 16,
            ),
          ),
          component.spacer(height: 12),
          _buildTodayAppointments(),
          component.spacer(height: 21),
        ],
      ),
    );
  }

  Widget _buildTodayAppointments() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTodayAppointmentsContainer(
            text: 'Total', subText: '${entity?.totalAppointments ?? 0}'),
        _buildTodayAppointmentsContainer(
            text: 'Completed',
            subText: '${entity?.completedAppointments ?? 0}'),
        _buildTodayAppointmentsContainer(
            text: 'Pending', subText: '${entity?.pendingAppointments ?? 0}'),
      ],
    );
  }

  Widget _buildTodayAppointmentsContainer(
      {required String text, required String subText}) {
    return Flexible(
      child: Container(
        width: 100,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            component.text(
              text,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 12,
              ),
            ),
            component.text(
              subText,
              style: theme.publicSansFonts.boldStyle(
                fontSize: 20,
                fontColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void _callAppointmentApi() {
    context.read<HomeCubit>().getDoctorAppointments(
        date: _getServerDate, pagination: _page, limit: 10);
  }
}
