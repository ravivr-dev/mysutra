import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class WithDrawBalanceScreen extends StatefulWidget {
  final int amount;
  const WithDrawBalanceScreen({super.key, required this.amount});

  @override
  State<WithDrawBalanceScreen> createState() => _WithDrawBalanceScreenState();
}

class _WithDrawBalanceScreenState extends State<WithDrawBalanceScreen> {
  final TextEditingController _ctrl = TextEditingController();

@override
  void initState() {
   _ctrl.text = widget.amount.toString();
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
            TextFormFieldWidget(
              prefix: const Text('₹'),
              borderRadius: 40,
              controller: _ctrl,
            ),
            const SizedBox(height: 16),
            RichText(
              softWrap: true,
              text: TextSpan(
                text: 'available for checkout',
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
              onPressed: () {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
