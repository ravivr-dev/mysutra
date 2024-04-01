import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_small_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_sutra/injection_container.dart';

class CheckInCardWidget extends StatefulWidget {
  const CheckInCardWidget({super.key});

  @override
  State<CheckInCardWidget> createState() => _CheckInCardWidgetState();
}

class _CheckInCardWidgetState extends State<CheckInCardWidget> {
  final ValueNotifier<int> _timeCounter = ValueNotifier<int>(500);
  DateTime now = DateTime.now();

  bool isCheckedIn = false;
  CheckinItem? currentRunningBatch;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timeCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state is CheckinStatusState) {
          isCheckedIn = state.data.currentCheckingBatchId != null;
          List<CheckinItem> items = [];
          for (CheckinItem e in state.data.items) {
            if (e.batchId == state.data.currentCheckingBatchId) {
              items.add(e);
            }
          }
          if (items.isNotEmpty) {
            currentRunningBatch = items.first;
            DateTime batchTime =
                DateTime.parse(items.first.checkInAt!).toLocal();
            int totalMins = now.difference(batchTime).inMinutes;
            batchTimer(totalMins);
          } else {
            currentRunningBatch = null;
          }
        }
      },
      builder: (context, state) {
        DashboardCubit cubit = context.read<DashboardCubit>();
        if (cubit.batches.isNotEmpty) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.greyF3),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.read<DashboardCubit>().getUserNaem(),
                      style: theme.publicSansFonts.regularStyle(
                          fontSize: 14, fontColor: AppColors.black49),
                    ),
                    const Spacer(),
                    if (cubit.location != null) ...[
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.black49,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        cubit.location!,
                        style: theme.publicSansFonts.regularStyle(
                            fontSize: 14, fontColor: AppColors.black49),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  "Check In",
                  style: theme.publicSansFonts.regularStyle(fontSize: 20),
                ),
                const SizedBox(height: 24),
                if (currentRunningBatch != null)
                  ValueListenableBuilder(
                      valueListenable: _timeCounter,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Text(
                          "0${_timeCounter.value ~/ 60}:${(_timeCounter.value % 60).toString().padLeft(2, '0')} hrs",
                          style: theme.publicSansFonts.boldStyle(fontSize: 25),
                        );
                      }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    cubit.batches.length,
                    (hrs) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.5, vertical: 10),
                      child: SizedBox(
                        width: 24,
                        child: Divider(
                          thickness: 2,
                          color: hrs < cubit.checkinRecords.length
                              ? AppColors.success
                              : AppColors.greyD9,
                        ),
                      ),
                    ),
                  ),
                ),
                if (currentRunningBatch != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        DateFormat('h:mm a').format(
                            DateTime.parse(currentRunningBatch!.startDate!)
                                .toLocal()),
                        style: theme.publicSansFonts.mediumStyle(fontSize: 14),
                      ),
                      Text(
                        DateFormat('h:mm a').format(
                            DateTime.parse(currentRunningBatch!.endaDate!)
                                .toLocal()),
                        style: theme.publicSansFonts.mediumStyle(fontSize: 14),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                BlocProvider(
                  create: (context) => sl<DashboardCubit>(),
                  child: BlocConsumer<DashboardCubit, DashboardState>(
                    builder: (BuildContext context, state) {
                      return CustomSmallButton(
                        width: 176,
                        buttonColor: isCheckedIn
                            ? AppColors.error
                            : AppColors.primaryColor,
                        text: isCheckedIn ? "Checkout" : "Check-In",
                        onPressed: () {
                          // context.read<DashboardCubit>().checkIn();

                          if (isCheckedIn) {
                            context.read<DashboardCubit>().checkOut();
                          } else {
                            context.read<DashboardCubit>().checkIn();
                          }
                        },
                      );
                    },
                    listener: (BuildContext context, Object? state) {
                      if (state is CinLoaded) {
                        isCheckedIn = !isCheckedIn;
                        widget.showSuccessToast(
                            context: context, message: state.message);
                      }

                      if (state is CoutLoaded) {
                        isCheckedIn = !isCheckedIn;
                        widget.showSuccessToast(
                            context: context, message: state.message);
                      }

                      if (state is DashboardError) {
                        widget.showErrorToast(
                            context: context, message: state.error);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.greyF3),
            padding: const EdgeInsets.all(24),
            height: 270,
          );
        }
      },
    );
  }

  batchTimer(int value) {
    _timeCounter.value = value;
    Duration oneSec = const Duration(minutes: 1);
    Timer.periodic(oneSec, (time) {
      _timeCounter.value++;
      if (_timeCounter.value <= 0) {
        time.cancel();
      }
    });
  }
}
