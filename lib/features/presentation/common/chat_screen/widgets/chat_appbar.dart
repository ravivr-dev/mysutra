import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/room_entity.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/generated/assets.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? profileUrl;
  final String title;
  final String status;
  final VoidCallback deleteCallback;
  final bool hasChatData;
  final String userId;
  final bool isChatHistory;

  const ChatAppBar({
    super.key,
    this.profileUrl,
    this.hasChatData = false,
    required this.title,
    required this.status,
    required this.deleteCallback,
    required this.userId,
    required this.isChatHistory,
  });

  @override
  Widget build(BuildContext context) {
    return isChatHistory
        ? _buildAppBar(context)
        : StreamBuilder(
            stream: context.read<ChatCubit>().listenUserData(userId: userId),
            builder: (_, snapshot) {
              final data = snapshot.data;
              return _buildAppBar(context, data);
            });
  }

  Widget _buildAppBar(BuildContext context, [RoomUserEntity? data]) {
    return AppBar(
      centerTitle: true,
      elevation: .5,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(),
      leading: InkWell(
        borderRadius: BorderRadius.circular(
          20,
        ),
        onTap: () => AiloitteNavigation.back(context),
        child: Container(
          color: AppColors.transparent,
          child: component.assetImage(path: Assets.iconsArrowBack),
        ),
      ),
      titleSpacing: 5,
      title: Row(
        children: [
          Stack(
            children: [
              component.networkImage(
                isCircular: true,
                fit: BoxFit.cover,
                imageRadius: 20,
                url: profileUrl ?? '',
                errorWidget: component.assetImage(
                  path: Assets.imagesDefaultAvatar,
                  isCircular: true,
                  fit: BoxFit.cover,
                  imageRadius: 20,
                ),
              ),
              if (!isChatHistory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: (data?.isOnline ?? false)
                          ? AppColors.green2BEF83
                          : AppColors.grey92,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          component.spacer(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              component.text(
                title,
                style: theme.publicSansFonts.mediumStyle(
                  fontColor: AppColors.black000E08,
                  fontSize: 16,
                  height: 16,
                ),
              ),
              component.spacer(height: 4),
              if (!isChatHistory)
                component.text(
                  (data?.isOnline ?? false)
                      ? 'Active now'
                      : (data?.lastOnlineAt != null)
                          ? DateFormat('dd-MM-yy hh:mm a')
                              .format(data!.lastOnlineAt!)
                          : '',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.grey797C7B,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const Spacer(),
          if (hasChatData)
            InkWell(
              onTap: deleteCallback,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: component.text('Clear Chat',
                    style: theme.publicSansFonts.regularStyle(
                        fontColor: AppColors.color0xFFFF1100, fontSize: 16)),
              ),
            )
        ],
      ),
    );
  }

  final double customToolbarHeight = 60;

  @override
  Size get preferredSize => Size.fromHeight(customToolbarHeight);
}
