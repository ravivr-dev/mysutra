import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class WithDrawBalanceScreen extends StatefulWidget {
  final num amount;
  const WithDrawBalanceScreen({super.key, required this.amount});

  @override
  State<WithDrawBalanceScreen> createState() => _WithDrawBalanceScreenState();
}

class _WithDrawBalanceScreenState extends State<WithDrawBalanceScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    _ctrl.text = widget.amount.toInt().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Withdraw Balance",
              style: theme.publicSansFonts
                  .mediumStyle(fontSize: 20, fontColor: AppColors.blackColor),
            ),
            const SizedBox(height: 16),
            Container(
              height: 70,
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 100, right: 80),
              decoration: const ShapeDecoration(
                  shape: StadiumBorder(
                      side: BorderSide(color: AppColors.color0xFFD8D8D8)),
                  color: AppColors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹',
                    style: theme.publicSansFonts.semiBoldStyle(
                        fontColor: AppColors.black21, fontSize: 24),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      showCursor: false,
                      controller: _ctrl,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                      ],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      style: theme.publicSansFonts.semiBoldStyle(
                          fontColor: AppColors.black21, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              softWrap: true,
              text: TextSpan(
                text: 'Available Balance',
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 14,
                  height: 20,
                  fontColor: AppColors.black23,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: NumberFormat('  ₹ #,##,##,###.00')
                        .format(widget.amount),
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 14,
                      height: 20,
                      fontColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: "Add Withdraw Request",
              onPressed: () {
                int val = int.parse(_ctrl.text);
                if (val > widget.amount) {
                  widget.showErrorToast(
                      context: context,
                      message:
                          'Exceeded your current withdrawal limit, i.e ${widget.amount}');
                } else if (val > 999) {
                  AiloitteNavigation.intentWithData(context,
                      AppRoutes.selectBankAccountRoute, int.parse(_ctrl.text));
                } else {
                  widget.showErrorToast(
                      context: context,
                      message: 'Minimum withdrawal limit is 1000');
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
