import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        title: component.text(context.stringForKey(StringKeys.myProfile)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            component.assetImage(
                path: Assets.iconsDummyDoctor,
                height: 80,
                width: 80,
                fit: BoxFit.fill),
            component.spacer(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                component.text('Rahul Rathi',
                    style: theme.publicSansFonts.mediumStyle(
                      fontSize: 25,
                      fontColor: AppColors.black37,
                    )),
                component.spacer(width: 4),
                component.assetImage(
                  path: Assets.iconsVerify,
                  height: 24,
                  width: 24,
                  fit: BoxFit.fill,
                )
              ],
            ),
            component.text('Andrologist | 25 year experience',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.color0xFF526371,
                )),
            component.spacer(height: 24),
            const Divider(color: AppColors.dividerColor),
            component.spacer(height: 12),
            _buildCard(value: 'My Patients', icons: Assets.iconsUserCircle),
            component.spacer(height: 12),
            _buildCard(value: 'My Following', icons: Assets.iconsUserAdd),
            component.spacer(height: 12),
            _buildCard(value: 'Settings', icons: Assets.iconsSetting),
            component.spacer(height: 12),
            _buildTileCard(
                icon: Assets.iconsPhone,
                text: 'Mobile number',
                subText: '987654123'),
            component.spacer(height: 12),
            _buildTileCard(
                icon: Assets.iconsEmail,
                text: 'Email Address',
                subText: 'hemuk9720@gmail.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildTileCard({
    required String icon,
    required String text,
    required String subText,
  }) {
    return Container(
      decoration: _getDecoration,
      padding: _getCardPadding,
      child: Row(
        children: [
          component.assetImage(path: icon),
          component.spacer(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text(text,
                    style: theme.publicSansFonts.mediumStyle(
                      fontColor: AppColors.grey92,
                    )),
                component.text(text,
                    style: theme.publicSansFonts.semiBoldStyle(
                      fontColor: AppColors.black21,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          component.text('Change',
              style: theme.publicSansFonts.semiBoldStyle(
                fontColor: AppColors.color0xFF8338EC,
                fontSize: 14,
              )),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String value,
    required String icons,
  }) {
    return Container(
      decoration: _getDecoration,
      padding: _getCardPadding,
      child: Row(
        children: [
          component.assetImage(path: icons),
          component.spacer(width: 5),
          component.text(value,
              style: theme.publicSansFonts.semiBoldStyle(
                fontSize: 16,
                fontColor: AppColors.black21,
              ))
        ],
      ),
    );
  }

  EdgeInsets get _getCardPadding {
    return const EdgeInsets.symmetric(vertical: 15, horizontal: 16);
  }

  BoxDecoration get _getDecoration {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 24,
            color: AppColors.color0xFF88A6FF.withOpacity(.05),
          )
        ]);
  }
}
