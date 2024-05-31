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
      builder: (context, state) {
        BankAccountCubit cubit = context.read<BankAccountCubit>();

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title:
                component.text(context.stringForKey(StringKeys.paymentMethod)),
            actions: [if (cubit.accounts.isNotEmpty) _addButton()],
          ),
          body: (state is BankAccountLoading)
              ? const Center(child: CircularProgressIndicator())
              : _bodyBuilder(cubit),
        );
      },
    );
  }

  Container _addButton() {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryColor),
      child: Text(
        'Add',
        style: theme.publicSansFonts
            .regularStyle(fontSize: 14, fontColor: AppColors.white),
      ),
    );
  }

  Widget _bodyBuilder(BankAccountCubit cubit) {
    if (cubit.accounts.isNotEmpty) {
      return AccountsWidget(cubit: cubit);
    }
    return const EmptyAccountCard();
  }

 
}
