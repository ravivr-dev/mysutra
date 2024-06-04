import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_withdrawals_usecase.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/earning_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/widgets/booking_card.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/widgets/withdraw_card.dart';
import 'package:my_sutra/features/presentation/patient/widgets/date_widget.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class PaymentCheckoutScreen extends StatefulWidget {
  const PaymentCheckoutScreen({super.key});

  @override
  State<PaymentCheckoutScreen> createState() => _PaymentCheckoutScreenState();
}

class _PaymentCheckoutScreenState extends State<PaymentCheckoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _withdrawalCtrl = ScrollController();
  final ScrollController _bookingCtrl = ScrollController();
  // final int _withdrawalPage = 1;
  // final int _bookingPage = 1;
  DateTime now = DateTime.now();
  String format = 'yyyy-MM-dd';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<EarningCubit>().getWithdrawalData(GetPayoutParams(
          date: DateFormat(format).format(now),
        ));
    context.read<EarningCubit>().getBookingData(GetPayoutParams(
          date: DateFormat(format).format(now),
        ));
    _withdrawalCtrl.addListener(() {
      if (_withdrawalCtrl.position.pixels ==
          _withdrawalCtrl.position.maxScrollExtent) {
        // TODO: call API
      }
    });
    _bookingCtrl.addListener(() {
      if (_bookingCtrl.position.pixels ==
          _bookingCtrl.position.maxScrollExtent) {
        // TODO: call API
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _withdrawalCtrl.dispose();
    _tabController.dispose();
    super.dispose();
  }

  final circularProgressIndicator =
      const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: component.text(context.stringForKey(StringKeys.earning)),
      ),
      body: BlocConsumer<EarningCubit, EarningState>(
        listener: (context, state) {
          if (state is EarningError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (_, state) {
          EarningCubit cubit = _.read<EarningCubit>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _revenueBuilder(cubit),
              _availableBuilder(),
              _buildDateBuilder(cubit),
              _tabBuilder(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      controller: _withdrawalCtrl,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      itemCount: cubit.withdrawals.length,
                      itemBuilder: (_, index) => WithdrawCard(
                        data: cubit.withdrawals[index],
                      ),
                      separatorBuilder: seperatedItemBuilder,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      controller: _bookingCtrl,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      itemCount: cubit.bookings.length,
                      itemBuilder: (_, index) => BookingCard(
                        data: cubit.bookings[index],
                      ),
                      separatorBuilder: seperatedItemBuilder,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Padding _tabBuilder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: 200,
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: theme.publicSansFonts
              .mediumStyle(fontSize: 14, fontColor: AppColors.blackTokens),
          unselectedLabelStyle: theme.publicSansFonts.regularStyle(
              fontSize: 14, fontColor: AppColors.blackTokens.withOpacity(0.6)),
          tabs: const [
            Tab(text: 'Withdraw'),
            Tab(text: 'Booking'),
          ],
        ),
      ),
    );
  }

  Widget seperatedItemBuilder(BuildContext ctx, int ndx) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: AppColors.color0xFFEBE2FF),
    );
  }

  Container _availableBuilder() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      color: AppColors.color0xFFF3EBFF,
      child: Row(
        children: [
          Expanded(
            child: RichText(
              softWrap: true,
              text: TextSpan(
                text: '₹ 8,000.00  ',
                style: theme.publicSansFonts.semiBoldStyle(
                  fontSize: 14,
                  height: 20,
                  fontColor: AppColors.primaryColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'available for checkout',
                      style: theme.publicSansFonts.regularStyle(
                        fontSize: 14,
                        height: 20,
                        fontColor: AppColors.black23,
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              'Withdraw',
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 14, height: 20, fontColor: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateBuilder(EarningCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "History",
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 16, fontColor: AppColors.blackColor),
          ),
          DateWidget(
            onDateChanged: (DateTime selectedDate) {
              cubit.getWithdrawalData(GetPayoutParams(
                date: DateFormat(format).format(selectedDate),
              ));
              cubit.getBookingData(GetPayoutParams(
                date: DateFormat(format).format(selectedDate),
              ));
            },
          )
        ],
      ),
    );
  }

  Padding _revenueBuilder(EarningCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              component.text(
                'Revenue',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  AiloitteNavigation.intent(
                      context, AppRoutes.paymentMethodRoute);
                },
                child: component.text(
                  'Payment Methods',
                  style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 16, fontColor: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          component.spacer(height: 12),
          _buildTodayAppointments(cubit),
          component.spacer(height: 21),
        ],
      ),
    );
  }

  Widget _buildTodayAppointments(EarningCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTodayAppointmentsContainer(
            text: 'Booking', subText: cubit.bookingAmount.toString()),
        _buildTodayAppointmentsContainer(
            text: 'Earnings', subText: cubit.earningAmount.toString()),
        _buildTodayAppointmentsContainer(
            text: 'Commission', subText: cubit.commisionAmount.toString()),
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
                fontColor: AppColors.color0xFF2F1455,
              ),
            )
          ],
        ),
      ),
    );
  }
}
