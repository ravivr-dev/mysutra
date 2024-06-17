import 'dart:io';
import 'dart:math';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/chat_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/send_message_usecase.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';
import 'package:open_file/open_file.dart';
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
  final ScrollController _chatController = ScrollController();

  // XFile? uploadedMedia;

  @override
  void dispose() {
    _messageController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ';
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return Scaffold(
      appBar: ChatAppBar(
        title: widget.args.username,
        status: 'Active now',
        hasChatData: _chatMessages.isNotEmpty,
        showBackButton: widget.args.showBackButton,
        deleteCallback: () {
          // if (_chatMessages.isNotEmpty) {
          //   context
          //       .read<ChatCubit>()
          //       .clearChatMessages(appointmentEntity?.id ?? '');
          // }
        },
        profileUrl: widget.args.profilePic,
        userId: widget.args.remoteUserId,
        isChatHistory: widget.args.showChatHistory,
      ),
      body: BlocListener<ChatCubit, ChattingState>(
          listener: (_, state) {
            if (state is DownloadPdfErrorState) {
              widget.showErrorToast(context: context, message: state.message);
            } else if (state is DownloadPdfSuccessState) {
              _showOpenFileToast(path: state.filePath);
            }
          },
          child: StreamBuilder(
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
                final messageList = entity.messages;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      BlocConsumer<RegistrationCubit, RegistrationState>(
                          listener: (_, state) {
                        if (state is UploadDocumentSuccessState) {
                          _sendMessage(
                            state.data.fileUrl ?? '',
                            isImage: state.isPdf ? null : true,
                            isPdf: state.isPdf ? true : null,
                          );
                        } else if (state is UploadDocumentError) {
                          widget.showErrorToast(
                              context: context,
                              message: 'Something went wrong');
                        }
                      }, builder: (context, state) {
                        return Expanded(
                            child: messageList.isEmpty
                                ? Center(
                                    child:
                                        component.text('No chat history found'))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    padding: const EdgeInsets.only(top: 5),
                                    itemCount: messageList.length,
                                    itemBuilder: (_, index) {
                                      ///Reversed this list because reverse is true show listview is showing item from last
                                      final messageEntity = messageList[index];
                                      final isMe = messageEntity.senderId ==
                                          widget.args.currentUserId;
                                      final showTime = _shouldShowTime(
                                          entity, index, messageList);
                                      final showAvatar = _shouldShowAvatar(
                                          entity, index, messageList);
                                      final showDate =
                                          _showTime(entity, index, messageList);
                                      final isToday =
                                          Utils.isTodayDate(messageEntity.time);

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (showDate) ...[
                                            _buildTimeWidget(
                                              isToday: isToday,
                                              time: dateFormat
                                                  .format(messageEntity.time),
                                            ),
                                            component.spacer(height: 8)
                                          ],
                                          isMe
                                              ? _buildMessageAndTimeWidget(
                                                  showTime: showTime,
                                                  isMe: isMe,
                                                  entity: messageEntity,
                                                )
                                              : _buildRemoteUserChatWidget(
                                                  showAvatar: showAvatar,
                                                  showTime: showTime,
                                                  entity: messageEntity,
                                                ),
                                        ],
                                      );
                                    }));
                      }),
                      if (!widget.args.showChatHistory)
                        ValueListenableBuilder(
                            valueListenable: _messageController,
                            builder: (_, value, __) {
                              return Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () => _handleImageSelection(
                                          source: ImageSource.gallery),
                                      child: component.assetImage(
                                          path: Assets.pickImage)),
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
                                          hintTextStyle: theme.publicSansFonts
                                              .regularStyle(
                                            fontSize: 12,
                                            fontColor: AppColors.textColor,
                                          ),
                                          hintText: 'Write your message',
                                          suffixWidget: _buildSendDocWidget(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  component.spacer(width: 16),
                                  InkWell(
                                      onTap: () => _handleImageSelection(
                                          source: ImageSource.camera),
                                      child: component.assetImage(
                                          path: Assets.iconsCamera)),
                                  component.spacer(width: 12),
                                  InkWell(
                                    onTap: () {
                                      if (value.text.trim().isEmpty) {
                                        widget.showErrorToast(
                                            context: context,
                                            message: 'Enter Valid Message');
                                        return;
                                      }
                                      _sendMessage(_messageController.text);
                                      _messageController.text = '';
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          AppColors.color0xFF8338EC,
                                      child: component.assetImage(
                                        path: Assets.iconsSend,
                                        width: 15,
                                        height: 15,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                    ],
                  ),
                );
              })),
    );
  }

  Widget _buildTimeWidget({required bool isToday, required String time}) {
    return Center(
        child: component.text(isToday ? 'Today' : time,
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 12,
              fontColor: AppColors.black000E08,
            )));
  }

  // void _navigateToLastMessage() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     _chatController.animateTo(_chatController.position.maxScrollExtent,
  //         duration: const Duration(microseconds: 1),
  //         curve: Curves.fastOutSlowIn);
  //   });
  // }

  Widget _buildSendDocWidget() {
    return InkWell(
      onTap: () async {
        FilePickerResult? file = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (file != null) {
          final xFile = file.files.single.xFile;
          _callUploadAPI(xFile, isPdf: true);
        }
      },
      child: component.assetImage(
        path: Assets.iconsDocs2,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  void _handleImageSelection({required ImageSource source}) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: source,
    );
    _callUploadAPI(result);
  }

  void _showOpenFileToast({required String path}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        component.text('File downloaded successfully'),
        TextButton(
            onPressed: () {
              OpenFile.open(path);
            },
            child: component.text(
              'open file',
              style: theme.publicSansFonts.regularStyle(
                fontColor: AppColors.white,
              ),
            ))
      ],
    )));
  }

//todo these bold methods should not depend upon ChatEntity
  bool _shouldShowTime(
      ChatEntity entity, int index, List<MessageEntity> messages) {
    final int nextMessageIndex = index - 1;
    if (nextMessageIndex >= 0) {
      if (messages[index].senderId == messages[nextMessageIndex].senderId) {
        return false;
      }
    }
    return true;
  }

  bool _shouldShowAvatar(
      ChatEntity entity, int index, List<MessageEntity> messages) {
    final int nextIndex = index + 1;
    if (nextIndex < messages.length &&
        messages[nextIndex].senderId == messages[index].senderId) {
      return false;
    }
    return true;
  }

  bool _showTime(ChatEntity entity, int index, List<MessageEntity> messages) {
    if (index == messages.length - 1) {
      return true;
    }
    final lastMessageTime = messages[index + 1].time;
    final currentMessageTime = messages[index].time;
    if (!Utils.isSameTime(lastMessageTime, currentMessageTime)) {
      return true;
    }
    return false;
  }

  Widget _buildMessageAndTimeWidget({
    required bool showTime,
    bool isMe = false,
    required MessageEntity entity,
  }) {
    /// We are using IntrinsicWidth because this column is taking full width
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: _buildChatImageBubble(
              text: entity.message,
              isMe: isMe,
              isImage: entity.isImage,
              isPdf: entity.isPdf,
            ),
          ),
          if (showTime) ...[
            component.spacer(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: component.text(
                _getTime(entity.time),
                style: theme.publicSansFonts.regularStyle(
                  fontSize: 10,
                  fontColor: AppColors.textColor,
                ),
              ),
            )
          ],
          component.spacer(height: 10)
        ],
      ),
    );
  }

  ///this text(message) would be image in case of image and message in case of normal message
  Widget _buildChatImageBubble({
    required String text,
    required bool isMe,
    required bool isImage,
    required bool isPdf,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: isPdf
          ? _buildPdfWidget(text)
          : isImage
              ? _buildImageContainer(text)
              : Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.color0xFF8338EC
                        : AppColors.blackF2F7FB,
                    borderRadius: BorderRadius.only(
                        topLeft: isMe ? const Radius.circular(10) : Radius.zero,
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                        topRight:
                            isMe ? Radius.zero : const Radius.circular(10)),
                  ),
                  child: component.text(text,
                      style: theme.publicSansFonts.regularStyle(
                        fontSize: 12,
                        fontColor:
                            isMe ? AppColors.white : AppColors.black000E08,
                      )),
                ),
    );
  }

  Widget _buildImageContainer(String url) {
    return InkWell(
      onTap: () {
        AiloitteNavigation.intentWithData(
            context, AppRoutes.imageViewRoute, url);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.blackF2F7FB,
          borderRadius: BorderRadius.circular(8),
        ),
        child: component.networkImage(
            url: url, height: 68, width: 68, borderRadius: 8),
      ),
    );
  }

  Widget _buildPdfWidget(String url) {
    return InkWell(
      onTap: () {
        context.read<ChatCubit>().downloadPdf(url);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.color0xFFF5F5F5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            component.assetImage(path: Assets.iconsDocument),
            component.spacer(width: 5),
            component.text('Download Prescription',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.color0xFF8338EC,
                ))
          ],
        ),
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
            mainAxisSize: MainAxisSize.min,
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
                entity: entity,
              ),
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

  void _sendMessage(String message, {bool? isImage, bool? isPdf}) {
    context.read<ChatCubit>().sendMessage(SendMessageParams(
          senderID: widget.args.currentUserId,
          timeStamp: Timestamp.now(),
          roomId: widget.args.roomId,
          message: message,
          isImage: isImage,
          isPdf: isPdf,
        ));
  }

  String _getTime(DateTime time) {
    final format = DateFormat('HH:mm a');
    return format.format(time);
  }

  void _callUploadAPI(XFile? result, {bool isPdf = false}) {
    if (result != null) {
      context
          .read<RegistrationCubit>()
          .uploadDoc(result, isLoading: true, isPdf: isPdf);
    }
  }
}

class ChatScreenArgs {
  final String roomId;
  final String username;
  final String currentUserId;
  final String? profilePic;
  final String remoteUserId;
  final bool showBackButton;
  final String? date;

  ///if this flag is try than we will not allow current user to chat
  final bool showChatHistory;

  ChatScreenArgs({
    required this.roomId,
    required this.username,
    required this.currentUserId,
    this.profilePic,
    required this.remoteUserId,
    this.showChatHistory = false,
    this.showBackButton = true,
    this.date,
  });
}
