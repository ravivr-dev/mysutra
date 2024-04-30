import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class VerificationPendingBottomSheet extends StatelessWidget {
  const VerificationPendingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetHomeDataSuccessState) {
          if (state.entity.isVerified == true) {
            AiloitteNavigation.intentWithClearAllRoutes(
                context, AppRoutes.homeRoute);
          } else {
            _showToast(context, 'You are not verified Yet');
          }
        } else if (state is GetHomeDataErrorState) {
          _showToast(context, state.message);
        }
      },
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            component.assetImage(
              path: Assets.iconsVerify,
              height: 33,
              width: 33,
              fit: BoxFit.fill,
              color: AppColors.color0xFF15C0B6,
            ),
            component.spacer(height: 28),
            component.text(
              'Account creation successfull',
              textAlign: TextAlign.center,
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 18,
                fontColor: AppColors.black21,
              ),
            ),
            component.spacer(height: 28),
            component.text(
              'Professional Registration number',
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 14,
                fontColor: AppColors.black21,
              ),
            ),
            component.text(
              'Verification pending',
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 14,
                fontColor: AppColors.star,
              ),
            ),
            component.spacer(height: 28),
            InkWell(
              onTap: () {
                context.read<HomeCubit>().getHomeData();
              },
              child: component.text(
                'Open Home',
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  fontColor: AppColors.color0xFF8338EC,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    showErrorToast(context: context, message: message);
  }
}
