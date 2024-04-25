import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class BookingSuccessfulScreen extends StatelessWidget {
  const BookingSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => AiloitteNavigation.back(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            component.assetImage(
              path: Assets.iconsVerify,
              color: AppColors.color0xFF15C0B6,
              height: 64,
              width: 64,
              fit: BoxFit.fill,
            ),
            component.spacer(height: 13),
            component.text(context.stringForKey(StringKeys.bookingSuccessful),
                style: theme.publicSansFonts.semiBoldStyle(
                  fontSize: 18,
                  fontColor: AppColors.black21,
                )),
            component.spacer(height: 8),
            component.text(
                context.stringForKey(StringKeys.yourBookingHasBeenConfirmed),
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 28),
            _buildChatButton(context),
            component.spacer(height: 70)
          ],
        ),
      ),
    );
  }

  Widget _buildChatButton(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: () => AiloitteNavigation.intent(context, AppRoutes.chatScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            component.text(context.stringForKey(StringKeys.chatNow),
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.color0xFF8338EC,
                )),
            component.assetImage(path: Assets.iconsChat)
          ],
        ),
      ),
    );
  }
}
