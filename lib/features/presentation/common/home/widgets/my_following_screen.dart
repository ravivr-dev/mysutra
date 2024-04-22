import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';

class MyFollowingScreen extends StatefulWidget {
  const MyFollowingScreen({super.key});

  @override
  State<MyFollowingScreen> createState() => _MyFollowingScreenState();
}

class _MyFollowingScreenState extends State<MyFollowingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => AiloitteNavigation.back(context),
          child: Icon(Icons.arrow_back,
              color: AppColors.color0xFF00082F.withOpacity(.27)),
        ),
        title: component.text(context.stringForKey(StringKeys.myFollowing),
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 20,
            )),
        bottom: TabBar(
          controller: _tabController,
          dividerHeight: 0.0,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelStyle: theme.publicSansFonts.mediumStyle(
            fontColor: AppColors.blackTokens,
          ),
          unselectedLabelStyle: theme.publicSansFonts.regularStyle(
            fontColor: AppColors.color0xFF000713.withOpacity(.62),
          ),
          tabs: [
            Tab(
              text: context.stringForKey(StringKeys.doctors),
            ),
            Tab(
              text: context.stringForKey(StringKeys.influencers),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            itemCount: 10,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _buildDoctorsCard();
            },
            separatorBuilder: (_, index) {
              return component.spacer(height: 12);
            },
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildDoctorsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: AppDeco.cardDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: component.assetImage(
                path: Assets.iconsDummyDoctor,
                height: 72,
                width: 72,
                borderRadius: 8),
          ),
          component.spacer(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text(
                  'Dr. Rita Rawat',
                  style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                ),
                component.spacer(height: 4),
                component.text(
                  'Sexologist',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.black81,
                  ),
                ),
                component.spacer(height: 4),
                Row(
                  children: [
                    component.assetImage(
                        path: Assets.iconsGroup,
                        color: AppColors.color0xFF8338EC),
                    component.text(
                      '25.6 k Followers',
                      style: theme.publicSansFonts.regularStyle(
                        fontColor: AppColors.color0xFF8338EC,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _buildFollowingButton(),
        ],
      ),
    );
  }

  Widget _buildFollowingButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.color0xFFF5F5F5,
      ),
      child: Row(
        children: [
          const Icon(Icons.check, color: AppColors.color0xFF15C0B6),
          component.text('Following',
              style: theme.publicSansFonts.regularStyle(
                fontColor: AppColors.color0xFF15C0B6,
              ))
        ],
      ),
    );
  }
}