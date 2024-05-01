import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/follow_button.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../../domain/entities/user_entities/user_data_entity.dart';

class PatientMyFollowingScreen extends StatefulWidget {
  final List<UserDataEntity> myFollowing;

  const PatientMyFollowingScreen({super.key, required this.myFollowing});

  @override
  State<PatientMyFollowingScreen> createState() =>
      _PatientMyFollowingScreenState();
}

class _PatientMyFollowingScreenState extends State<PatientMyFollowingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  late final List<UserDataEntity> _doctorList =
      _getFilteredList(UserRole.doctor);
  late final List<UserDataEntity> _inFluencerList =
      _getFilteredList(UserRole.influencer);

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
          child: Icon(
            Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27),
          ),
        ),
        title: component.text(
          context.stringForKey(StringKeys.myFollowing),
          style: theme.publicSansFonts.mediumStyle(
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          padding: const EdgeInsets.only(left: 15),
          controller: _tabController,
          isScrollable: true,
          dividerColor: AppColors.backgroundColor,
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
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDoctorWidgets(list: _doctorList),
          _buildDoctorWidgets(list: _inFluencerList, isDoctor: false)
        ],
      ),
    );
  }

  List<UserDataEntity> _getFilteredList(UserRole role) {
    return widget.myFollowing
        .where((element) => element.role == role.name)
        .toList();
  }

  Widget _buildEmptyText({required String role}) {
    return Center(
        child: component.text('No $role Found',
            style: theme.publicSansFonts.mediumStyle(fontSize: 20)));
  }

  Widget _buildDoctorWidgets(
      {required List<UserDataEntity> list, bool isDoctor = true}) {
    return list.isEmpty
        ? _buildEmptyText(role: isDoctor ? 'Doctor' : 'Influencer')
        : ListView.separated(
            itemCount: list.length,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _buildDoctorsCard(list[index], isDoctor: isDoctor);
            },
            separatorBuilder: (_, index) {
              return component.spacer(height: 12);
            },
          );
  }

  Widget _buildDoctorsCard(UserDataEntity entity, {required bool isDoctor}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: AppDeco.cardDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: component.networkImage(
                url: entity.profilePic,
                height: 72,
                width: 72,
                borderRadius: 8,
                errorWidget:
                    component.assetImage(path: Assets.imagesDefaultAvatar)),
          ),
          component.spacer(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: component.text(
                    'Dr. ${entity.fullName}',
                    style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                  ),
                ),
                component.spacer(height: 4),
                if (isDoctor) ...[
                  component.text(
                    entity.specialization,
                    style: theme.publicSansFonts.regularStyle(
                      fontColor: AppColors.black81,
                    ),
                  ),
                  component.spacer(height: 4),
                ],
                Row(
                  children: [
                    component.assetImage(
                        path: Assets.iconsGroup,
                        color: AppColors.color0xFF8338EC),
                    component.text(
                      '${entity.totalFollowers} Followers',
                      style: theme.publicSansFonts.regularStyle(
                        fontColor: AppColors.color0xFF8338EC,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _buildFollowingButton(entity),
        ],
      ),
    );
  }

  Widget _buildFollowingButton(UserDataEntity entity) {
    return FollowButton(
      followingUserId: entity.id,
      isFollowing: entity.isFollowing,
      onFollowingChanged: (_) {
        entity.reInitIsFollowing();
      },
    );
  }
}
