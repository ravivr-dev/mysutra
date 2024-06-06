import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/bank_account_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/checkout_usecase.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/earning_cubit.dart';

class SelectBankAccountScreen extends StatefulWidget {
  final int amount;
  const SelectBankAccountScreen({super.key, required this.amount});

  @override
  State<SelectBankAccountScreen> createState() =>
      _SelectBankAccountScreenState();
}

class _SelectBankAccountScreenState extends State<SelectBankAccountScreen> {
  BankAccountEntity? selectedAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Select Account Screen'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<EarningCubit, EarningState>(
          listener: (context, state) {
            if (state is EarningError) {
              widget.showErrorToast(context: context, message: state.error);
            } else if (state is EarningCheckout) {
              widget.showErrorToast(
                  context: context, message: 'Payment requested Successfully');
              AiloitteNavigation.back(context);
              AiloitteNavigation.back(context);
            }
          },
          builder: (context, state) {
            EarningCubit cubit = context.read<EarningCubit>();
            return Column(
              children: [
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cubit.accounts.length,
                  itemBuilder: (_, index) {
                    String? account =
                        cubit.accounts[index].bankAccount?.accountNumber;
                    String? upi = cubit.accounts[index].vpa?.address;

                    bool isSelected = selectedAccount == cubit.accounts[index];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedAccount = cubit.accounts[index];
                        });
                      },
                      child: Container(
                        color: isSelected ? AppColors.white : null,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (account != null) ...[
                                  Text(
                                    getMaskedAccountNumber(account),
                                    style: theme.publicSansFonts.mediumStyle(
                                        fontSize: 16,
                                        fontColor: AppColors.blackColor),
                                  ),
                                  Text(
                                    "Bank Account",
                                    style: theme.publicSansFonts.regularStyle(
                                        fontSize: 16,
                                        fontColor: AppColors.color0xFF000713),
                                  ),
                                ] else if (upi != null) ...[
                                  Text(
                                    getMaskedAccountNumber(upi),
                                    style: theme.publicSansFonts.mediumStyle(
                                        fontSize: 16,
                                        fontColor: AppColors.blackColor),
                                  ),
                                  Text(
                                    "UPI ID",
                                    style: theme.publicSansFonts.regularStyle(
                                        fontSize: 16,
                                        fontColor: AppColors.color0xFF000713),
                                  ),
                                ]
                              ],
                            ),
                            // TextButton(
                            //   onPressed: () {
                            //     cubit.updateAccount(
                            //         ActivateDeactivateBankAccountParams(
                            //             accountId: cubit.accounts[index].id ?? '',
                            //             activate:
                            //                 cubit.accounts[index].active != null
                            //                     ? !cubit.accounts[index].active!
                            //                     : true),
                            //         index);
                            //   },
                            //   child: Text(
                            //     cubit.accounts[index].active == true
                            //         ? 'Deactivate'
                            //         : 'Activate',
                            //     style: theme.publicSansFonts.semiBoldStyle(
                            //         fontSize: 14,
                            //         fontColor: AppColors.primaryColor),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(color: AppColors.color0xFFEBE2FF),
                ),
                if (selectedAccount != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: CustomButton(
                      text: "Withdraw",
                      isLoading: state is EarningWithdrawalLoader,
                      onPressed: () {
                        cubit.checkout(CheckoutParams(
                            accountId: selectedAccount!.id!,
                            mode: (selectedAccount!.vpa != null)
                                ? "VPA"
                                : "BANK_ACCOUNT",
                            amount: widget.amount));
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  String getMaskedUpi(String upiId) {
    final atIndex = upiId.indexOf('@');
    if (atIndex == -1) return upiId;

    final prefix = upiId.substring(0, atIndex);
    final maskedPrefix = '*' * prefix.length;
    final suffix = upiId.substring(atIndex);

    return maskedPrefix + suffix;
  }

  String getMaskedAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) {
      return accountNumber;
    }
    final visiblePart = accountNumber.substring(accountNumber.length - 4);
    final maskedPart = '*' * (accountNumber.length - 4);
    return '$maskedPart$visiblePart';
  }
}
