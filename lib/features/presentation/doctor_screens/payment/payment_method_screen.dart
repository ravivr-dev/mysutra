import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/cubit/bank_account_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/widgets/accounts_widget.dart';
import 'package:my_sutra/features/presentation/doctor_screens/payment/widgets/empty_account_card.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankAccountCubit, BankAccountState>(
      listener: (context, state) {
        if (state is BankAccountError) {
          showErrorToast(context: context, message: state.error);
        }
      },
      builder: (_, state) {
        BankAccountCubit cubit = _.read<BankAccountCubit>();
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title:
                component.text(context.stringForKey(StringKeys.paymentMethod)),
            actions: [if (cubit.accounts.isNotEmpty) _addButton(context)],
          ),
          body: (state is BankAccountLoading)
              ? const Center(child: CircularProgressIndicator())
              : _bodyBuilder(cubit),
        );
      },
    );
  }

  Padding _addButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: InkWell(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.primaryColor),
          child: Text(
            'Add',
            style: theme.publicSansFonts
                .regularStyle(fontSize: 14, fontColor: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget _bodyBuilder(BankAccountCubit cubit) {
    if (cubit.accounts.isNotEmpty) {
      return AccountsWidget(cubit: cubit);
    }
    return const EmptyAccountCard();
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add payment method',
                style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 18, fontColor: AppColors.color0xFF1E293B),
              ),
              const SizedBox(height: 20),
              _dropDownItem(
                text: 'Bank Account',
                onTap: () {
                  AiloitteNavigation.back(context);
                  AiloitteNavigation.intentWithData(
                          context, AppRoutes.addBankAccountRoute, false)
                      .then((value) {
                    context.read<BankAccountCubit>().getData();
                    AiloitteNavigation.back(context);
                  });
                },
              ),
              const Divider(
                color: AppColors.color0xFFEAECF0,
              ),
              _dropDownItem(
                text: 'UPI ID',
                onTap: () {
                  AiloitteNavigation.intentWithData(
                          context, AppRoutes.addUpiIdRoute, false)
                      .then((value) {
                    context.read<BankAccountCubit>().getData();
                    AiloitteNavigation.back(context);
                  });
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  _dropDownItem({required String text, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: theme.publicSansFonts.regularStyle(fontSize: 16),
      ),
    );
  }
}
