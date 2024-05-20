import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/send_message_usecase.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../domain/entities/chat_entities/chat_entity.dart';
import 'widgets/chat_appbar.dart';

class ChatScreen extends StatefulWidget {
  final ChatScreenArgs args;

  const ChatScreen({required this.args, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageItemEntity> _chatMessages = [];
  final TextEditingController _messageController = TextEditingController();

  // XFile? uploadedMedia;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        title: widget.args.username,
        status: 'Active now',
        hasChatData: _chatMessages.isNotEmpty,
        deleteCallback: () {
          // if (_chatMessages.isNotEmpty) {
          //   context
          //       .read<ChatCubit>()
          //       .clearChatMessages(appointmentEntity?.id ?? '');
          // }
        },
        profileUrl: widget.args.profilePic,
        userId: widget.args.remoteUserId,
      ),
      body: StreamBuilder(
          stream: context
              .read<ChatCubit>()
              .listenMessages(roomId: widget.args.roomId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SingleChildScrollView(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: component.text('Something Went Wrong '),
              );
            }
            ChatEntity entity = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: entity.messages.length,
                          itemBuilder: (_, index) {
                            final messageEntity = entity.messages[index];
                            final isMe = messageEntity.senderId ==
                                widget.args.currentUserId;
                            final showTime = _shouldShowTime(entity, index);
                            final showAvatar = _shouldShowAvatar(entity, index);

                            return isMe
                                ? _buildMessageAndTimeWidget(
                                    showTime: showTime,
                                    message: messageEntity.message,
                                    time: messageEntity.time,
                                    isMe: isMe,
                                  )
                                : _buildRemoteUserChatWidget(
                                    showAvatar: showAvatar,
                                    showTime: showTime,
                                    entity: messageEntity,
                                  );
                          })),
                  ValueListenableBuilder(
                      valueListenable: _messageController,
                      builder: (_, value, __) {
                        return Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            component.assetImage(path: Assets.pickImage),
                            component.spacer(width: 11),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: component.textField(
                                    controller: _messageController,
                                    fillColor: AppColors.fillColor,
                                    borderColor: AppColors.transparent,
                                    borderRadius: 12,
                                    hintText: 'Write your message',
                                  ),
                                ),
                              ),
                            ),
                            component.spacer(width: 16),
                            component.assetImage(path: Assets.iconsCamera),
                            component.spacer(width: 12),
                            if (value.text.trim().isEmpty)
                              component.assetImage(path: Assets.iconsMicrophone)
                            else
                              InkWell(
                                onTap: _sendMessage,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.color0xFF8338EC,
                                  child: component.assetImage(
                                      path: Assets.iconsSend,
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.fill),
                                ),
                              )
                          ],
                        );
                      }),
                  // component.spacer(height: 20)
                ],
              ),
            );
          }),
    );
  }

//todo these bold methods should not depend upon ChatEntity
  bool _shouldShowTime(ChatEntity entity, int index) {
    final list = entity.messages;
    final int nextMessageIndex = index + 1;
    if (list.length > nextMessageIndex) {
      if (list[index].senderId == list[nextMessageIndex].senderId) {
        return false;
      }
    }
    return true;
  }

  bool _shouldShowAvatar(ChatEntity entity, int index) {
    final list = entity.messages;
    final int previousChatIndex = index - 1;
    if (previousChatIndex >= 0 &&
        list[previousChatIndex].senderId == list[index].senderId) {
      return false;
    }
    return true;
  }

  Widget _buildMessageAndTimeWidget({
    required bool showTime,
    required String message,
    required DateTime time,
    bool isMe = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: _buildChatBubble(
            text: message,
            isMe: isMe,
          ),
        ),
        //todo will have to align this time widget
        if (showTime) ...[
          component.spacer(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: component.text(
              _getTime(time),
              style: theme.publicSansFonts.regularStyle(
                fontSize: 10,
                fontColor: AppColors.textColor,
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget _buildChatBubble({required String text, required bool isMe}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.color0xFF8338EC : AppColors.blackF2F7FB,
          borderRadius: BorderRadius.only(
              topLeft: isMe ? const Radius.circular(10) : Radius.zero,
              bottomLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10),
              topRight: isMe ? Radius.zero : const Radius.circular(10)),
        ),
        child: component.text(text,
            style: theme.publicSansFonts.regularStyle(
              fontSize: 12,
              fontColor: isMe ? AppColors.white : AppColors.black000E08,
            )),
      ),
    );
  }

  Widget _buildRemoteUserChatWidget(
      {required bool showAvatar,
      required bool showTime,
      required MessageEntity entity}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.transparent,
          child: showAvatar
              ? _buildAvatarWidget(profileUrl: widget.args.profilePic)
              : null,
        ),
        component.spacer(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showAvatar) ...[
                component.text(
                  widget.args.username,
                  style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 14,
                  ),
                ),
                component.spacer(height: 12)
              ],

              ///I'm using this Column because of Alignment of Time
              _buildMessageAndTimeWidget(
                  showTime: showTime,
                  message: entity.message,
                  time: entity.time),
              component.spacer(height: 10)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAvatarWidget({required String? profileUrl}) {
    return component.networkImage(
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
    );
  }

  void _sendMessage() {
    final message = _messageController.text;
    _messageController.text = '';
    context.read<ChatCubit>().sendMessage(SendMessageParams(
          senderID: widget.args.currentUserId,
          timeStamp: Timestamp.now(),
          roomId: widget.args.roomId,
          message: message,
        ));
  }

  String _getTime(DateTime time) {
    final format = DateFormat('HH:mm a');
    return format.format(time);
  }

  void callUploadAPI(XFile? result) {
    if (result != null) {
      context.read<RegistrationCubit>().uploadDoc(result, isLoading: true);
    }
  }
}

class ChatScreenArgs {
  final String roomId;
  final String username;
  final String currentUserId;
  final String? profilePic;

  ChatScreenArgs({
    required this.roomId,
    required this.username,
    required this.currentUserId,
    this.profilePic,
  });
}
