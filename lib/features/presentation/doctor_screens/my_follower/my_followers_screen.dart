import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_data_entity.dart';
import 'package:my_sutra/generated/assets.dart';

class MyFollowersScreen extends StatelessWidget {
  final List<UserDataEntity> followers;

  const MyFollowersScreen({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('My Followers'),
        centerTitle: true,
      ),
      body: followers.isEmpty
          ? Center(
              child: Text(
                'No Followers Found',
                style: theme.publicSansFonts
                    .mediumStyle(fontSize: 20, fontColor: AppColors.grey92),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                if (followers[index].userName != null &&
                    followers[index].userName != '') {
                  return _buildFollowerCard(followers[index]);
                }
                return Container();
              },
              itemCount: followers.length,
            ),
    );
  }

  Widget _buildFollowerCard(UserDataEntity follower) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Row(
        children: [
          component.networkImage(
              height: 50,
              width: 50,
              borderRadius: 5,
              url: follower.profilePic,
              errorWidget:
                  component.assetImage(path: Assets.imagesDefaultAvatar)),
          component.spacer(width: 8),
          component.text(follower.fullName != '' && follower.fullName != null
              ? follower.fullName
              : follower.userName),
        ],
      ),
    );
  }
}
