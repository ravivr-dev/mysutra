import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/activate_deactivate_bank_account_usecase.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/bank_account_cubit.dart';

class AccountsWidget extends StatelessWidget {
  final BankAccountCubit cubit;
  const AccountsWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: component.text(
              '${cubit.accounts.length} payment methods added',
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16, fontColor: AppColors.color0xFF000713)),
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shrinkWrap: true,
          itemCount: cubit.accounts.length,
          itemBuilder: (_, index) {
            String? account = cubit.accounts[index].bankAccount?.accountNumber;
            String? upi = cubit.accounts[index].vpa?.address;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (account != null) ...[
                      Text(
                        getMaskedAccountNumber(account),
                        style: theme.publicSansFonts.mediumStyle(
                            fontSize: 16, fontColor: AppColors.blackColor),
                      ),
                      Text(
                        "Bank Account",
                        style: theme.publicSansFonts.regularStyle(
                            fontSize: 16, fontColor: AppColors.color0xFF000713),
                      ),
                    ] else if (upi != null) ...[
                      Text(
                        getMaskedAccountNumber(upi),
                        style: theme.publicSansFonts.mediumStyle(
                            fontSize: 16, fontColor: AppColors.blackColor),
                      ),
                      Text(
                        "UPI ID",
                        style: theme.publicSansFonts.regularStyle(
                            fontSize: 16, fontColor: AppColors.color0xFF000713),
                      ),
                    ]
                  ],
                ),
                TextButton(
                  onPressed: () {
                    cubit.updateAccount(
                        ActivateDeactivateBankAccountParams(
                            accountId: cubit.accounts[index].id ?? '',
                            activate: cubit.accounts[index].active != null
                                ? !cubit.accounts[index].active!
                                : true),
                        index);
                  },
                  child: Text(
                    cubit.accounts[index].active == true
                        ? 'Deactivate'
                        : 'Activate',
                    style: theme.publicSansFonts.semiBoldStyle(
                        fontSize: 14, fontColor: AppColors.primaryColor),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.color0xFFEBE2FF),
          ),
        )
      ],
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
