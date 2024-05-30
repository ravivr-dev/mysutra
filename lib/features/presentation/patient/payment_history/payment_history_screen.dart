import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/payment_history_usecase.dart';
import 'package:my_sutra/features/presentation/patient/payment_history/cubit/payment_history_cubit.dart';
import 'package:my_sutra/features/presentation/patient/payment_history/widgets/payment_history_card.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context
            .read<PaymentHistoryCubit>()
            .getData(PaginationParams(pagination: _page));
      }
    });
  }

  final circularProgressIndicator =
      const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: component.text(context.stringForKey(StringKeys.paymentHistory)),
      ),
      body: BlocConsumer<PaymentHistoryCubit, PaymentHistoryState>(
        listener: (context, state) {
          if (state is PaymentHistoryLoaded) {
            _page = _page + 1;
          } else if (state is PaymentHistoryError) {
            widget.showErrorToast(context: context, message: state.error);
          }
        },
        builder: (ctx, state) {
          PaymentHistoryCubit cubit = ctx.read<PaymentHistoryCubit>();
          if (state is PaymentHistoryLoading && cubit.paymentHistoty.isEmpty) {
            return circularProgressIndicator;
          }
          return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: cubit.paymentHistoty.length + 1,
              itemBuilder: (ctx, ndx) {
                if (ndx == cubit.paymentHistoty.length) {
                  return (state is CircularProgressIndicator)
                      ? circularProgressIndicator
                      : const SizedBox();
                }
                return PaymentHistoryCard(data: cubit.paymentHistoty[ndx]);
              });
        },
      ),
    );
  }
}
