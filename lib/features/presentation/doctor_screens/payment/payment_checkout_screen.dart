import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: component.text(context.stringForKey(StringKeys.earning)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _revenueBuilder(),
          _availableBuilder(),
          _buildDateBuilder(),
          _tabBuilder(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  itemCount: 10,
                  itemBuilder: (_, index) => const WithdrawCard(),
                  separatorBuilder: seperatedItemBuilder,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  itemCount: 5,
                  itemBuilder: (_, index) => const BookingCard(),
                  separatorBuilder: seperatedItemBuilder,
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildDateBuilder() {
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
            onDateChanged: (DateTime selectedDate) {},
          )
        ],
      ),
    );
  }

  Padding _revenueBuilder() {
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
                  AiloitteNavigation.intent(context, AppRoutes.paymentMethodRoute);
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
        _buildTodayAppointmentsContainer(text: 'Booking', subText: '10'),
        _buildTodayAppointmentsContainer(text: 'Earnings', subText: '20'),
        _buildTodayAppointmentsContainer(text: 'Commission', subText: '7'),
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
