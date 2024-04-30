import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/string_literal.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/chat_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/messages_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_message_use_case.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/input_widget/audio_message_widget.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/input_widget/bubble_widget.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_ui/src/models/date_header.dart' as header;

import 'package:my_sutra/features/presentation/common/chat_screen/input_widget/input.dart'
    as input;
import 'input_widget/chat_image_widget.dart';
import 'input_widget/text_message_widget.dart';
import 'input_widget/user_avatar_widget.dart';
import 'widgets/chat_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageItemEntity> _chatMessages = [];
  // final ScrollController _scrollController = ScrollController();
  // int _page = 1;
  // int _limit = 10;
  final localDataSource = sl<LocalDataSource>();

  List<types.Message> _messages = [];

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _uploadingMediaNotifier = ValueNotifier<bool>(false);

  final _previewMedia = ValueNotifier<List<String>>([]);

  AppointmentEntity? appointmentEntity;
  XFile? uploadedMedia;
  bool isRoleDoctor = false;
  @override
  void initState() {
    super.initState();
    // _loadMessages();
    if (localDataSource.getUserRole() == UserRole.doctor.name) {
      isRoleDoctor = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        appointmentEntity =
            ModalRoute.of(context)?.settings.arguments as AppointmentEntity?;

        if (appointmentEntity != null) {
          _getChatMsgDataFromServer();
        }
      }
    });
  }

  void _getChatMsgDataFromServer() {
    context.read<ChatCubit>().getChatMessages(
        GetMessageParams(appointmentId: appointmentEntity?.id ?? ''));
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateChatListMessageToMessageType() async {
    for (var element in _chatMessages) {
      if (element.mediaUrl != null && (element.mediaUrl ?? []).isNotEmpty) {
        if ((element.message ?? '').isNotEmpty) {
          _buildMsg(element);
        }
        final fileSize = await getFileSize(element.mediaUrl![0], 1);

        if (element.mediaUrl![0].checkIfFileTypeIsImage) {
          _messages.add(
            types.ImageMessage(
              name: element.mediaUrl![0].split('/').last,
              size: num.parse(fileSize),
              uri: element.mediaUrl![0],
              author: types.User(
                id: element.sender?.senderId ?? "",
                firstName: element.sender?.fullName?.split(' ').first,
                lastName: element.sender?.fullName?.split(' ').last ?? '',
                imageUrl: element.sender != null &&
                        element.sender?.profilePic != null &&
                        element.sender!.profilePic!.trim().isNotEmpty
                    ? element.sender!.profilePic
                    : null,
              ),
              id: element.id.toString(),
              createdAt: DateTime.parse(element.createdAt ?? '')
                  .millisecondsSinceEpoch,
            ),
          );
        } else if (element.mediaUrl![0].checkIfFileTypeIsAudio) {
          _messages.add(
            types.AudioMessage(
              name: element.mediaUrl![0].split('/').last,
              size: num.parse(fileSize),
              uri: element.mediaUrl![0],

              ///TODO need to add audio duration
              duration: const Duration(minutes: 2),
              author: types.User(
                id: element.sender?.senderId ?? "",
                firstName: element.sender?.fullName,
                // lastName: element.sender?.lastName,
                imageUrl: element.sender != null &&
                        element.sender?.profilePic != null &&
                        element.sender!.profilePic!.trim().isNotEmpty
                    ? element.sender!.profilePic
                    : null,
              ),
              id: element.id.toString(),
              createdAt: DateTime.parse(element.createdAt ?? '')
                  .millisecondsSinceEpoch,
            ),
          );
        } else {
          _messages.add(
            types.FileMessage(
              name: element.mediaUrl![0].split('/').last,
              size: num.parse(fileSize),
              uri: element.mediaUrl![0],
              author: types.User(
                id: element.sender?.senderId ?? "",
                firstName: element.sender?.fullName,
                lastName: element.sender?.fullName?.split(' ').last ?? '',
                imageUrl: element.sender != null &&
                        element.sender?.profilePic != null &&
                        (element.sender?.profilePic ?? '').trim().isNotEmpty
                    ? element.sender?.profilePic ?? ""
                    : null,
              ),
              id: element.id.toString(),
              createdAt: DateTime.parse(element.createdAt ?? '')
                  .millisecondsSinceEpoch,
            ),
          );
        }
      } else {
        _buildMsg(element);
      }
    }

    // _isMessageLoading = false;
  }

  void _buildMsg(MessageItemEntity element) {
    _messages.add(
      types.TextMessage(
        author: types.User(
          id: element.sender?.senderId ?? "",
          firstName: element.sender?.fullName,
          lastName: element.sender?.fullName?.split(' ').last ?? '',
          imageUrl: element.sender != null &&
                  element.sender?.profilePic != null &&
                  (element.sender?.profilePic ?? '').trim().isNotEmpty
              ? element.sender?.profilePic ?? ""
              : null,
        ),
        id: element.id.toString(),
        text: element.message ?? '',
        createdAt:
            DateTime.parse(element.createdAt ?? '').millisecondsSinceEpoch,
      ),
    );
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ';
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      callUploadAPI(result.xFiles.first);
    }
    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      // _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    callUploadAPI(result);

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      // _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    final list = _previewMedia.value;
    _previewMedia.value = [];

    if (list.isNotEmpty && message.text.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(ChatEntity(
          appointmentId: appointmentEntity?.id ?? '',
          sentTo: isRoleDoctor
              ? appointmentEntity?.doctorId
              : appointmentEntity?.userId,
          messageType: 'TEXT_WITH_MEDIA',
          message: message.text,
          mediaUrl: list));
    } else if (message.text.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(ChatEntity(
          appointmentId: appointmentEntity?.id ?? '',
          sentTo: isRoleDoctor
              ? appointmentEntity?.doctorId
              : appointmentEntity?.userId,
          messageType: 'TEXT',
          message: message.text,
          mediaUrl: null));
    } else if (list.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(ChatEntity(
          appointmentId: appointmentEntity?.id ?? '',
          sentTo: isRoleDoctor
              ? appointmentEntity?.doctorId
              : appointmentEntity?.userId,
          messageType: 'MEDIA',
          mediaUrl: list));
    }
    // _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/message.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _callChatDataFromServer() {
    context.read<ChatCubit>().getChatMessages(
        GetMessageParams(appointmentId: appointmentEntity?.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChattingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: ChatAppBar(
            title: appointmentEntity?.fullName ?? '',
            status: 'Active now',
            hasChatData: _chatMessages.isNotEmpty,
            deleteCallback: () {
              if (_chatMessages.isNotEmpty) {
                context
                    .read<ChatCubit>()
                    .clearChatMessages(appointmentEntity?.id ?? '');
              }
            },
          ),
          body: BlocConsumer<ChatCubit, ChattingState>(
            listener: (context, state) {
              if (state is SendMsgLoading) {
              } else if (state is ChatLoading) {
              } else if (state is ClearChatLoading) {
                widget.showProgressDialog(context, "Please wait...");
              } else if (state is ChatError) {
                widget.showErrorToast(context: context, message: state.error);
              } else if (state is ClearChatErrorState) {
                widget.showErrorToast(context: context, message: state.error);
                AiloitteNavigation.back(context);
              } else if (state is ClearMessageSuccess) {
                widget.showErrorToast(context: context, message: state.message);
                AiloitteNavigation.back(context);
                AiloitteNavigation.back(context);
              } else if (state is SendMessageSuccess) {
                _callChatDataFromServer();
              } else if (state is GetChatMessagesSuccess) {
                _chatMessages.clear();
                _chatMessages.addAll(state.messageList.chatMessages ?? []);
                _updateChatListMessageToMessageType();
              }
            },
            builder: (context, state) {
              return Chat(
                theme: DefaultChatTheme(
                  backgroundColor: AppColors.backgroundColor,
                  sentMessageBodyTextStyle: theme.publicSansFonts.regularStyle(
                    fontSize: 12,
                    height: 12,
                    fontColor: AppColors.white,
                  ),
                  receivedMessageBodyTextStyle:
                      theme.publicSansFonts.mediumStyle(
                    fontSize: 16,
                    fontColor: AppColors.black000E08,
                  ),
                  secondaryColor: AppColors.blackF2F7FB,
                  primaryColor: AppColors.primaryColor,
                ),
                messages: _messages,
                onAttachmentPressed: _handleAttachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                dateHeaderBuilder: (date) {
                  return _getDateHeader(date);
                },
                avatarBuilder: (avatar) {
                  return UserAvatarWidget(
                    author: avatar,
                  );
                },
                bubbleBuilder: (child,
                    {required message, required nextMessageInGroup}) {
                  return BubbleWidget(
                    message: message,
                    nextMessageInGroup: nextMessageInGroup,
                    user: _user,
                    child: child,
                  );
                },
                customStatusBuilder: (message,
                    {required BuildContext context}) {
                  return const SizedBox.shrink();
                },
                audioMessageBuilder: (audioMessage, {required messageWidth}) {
                  return AudioMessageWidget(
                    audioMessage: audioMessage,
                    user: _user,
                  );
                },
                textMessageBuilder: (testMessage,
                    {int messageWidth = 0, bool showName = true}) {
                  return TextMessageWidget(
                    usePreviewData: true,
                    user: _user,
                    emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
                    message: testMessage,
                    hideBackgroundOnEmojiMessages: true,
                    showName: true,
                    showUserAvatars: true,
                  );
                },
                imageMessageBuilder: (
                  fileMessage, {
                  int messageWidth = 0,
                }) {
                  return Container(
                    color: AppColors.backgroundColor,
                    child: Column(
                      children: [
                        ChatImageWidget(
                          user: _user,
                          message: fileMessage,
                          showUserAvatars: true,
                        ),
                      ],
                    ),
                  );
                },
                customBottomWidget: _getCustomButtonWidget(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _getCustomButtonWidget() {
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is UploadDocLoading) {
          widget.showProgressDialog(context, "Please wait...");
        } else if (state is RegistrationError) {
          widget.showErrorToast(context: context, message: state.error);
          AiloitteNavigation.back(context);
        } else if (state is UploadDocument) {
          AiloitteNavigation.back(context);
          uploadedMedia = state.file;
          final list = _previewMedia.value;
          list.add(state.file.path);
          _previewMedia.value = list;
          // context.read<ChatCubit>().sendMessage(ChatEntity(
          //     appointmentId: appointmentEntity?.id ?? '',
          //     sentTo: appointmentEntity?.doctorId,
          //     messageType: 'MEDIA',
          //     mediaUrl: [state.file.path]));
        }
      },
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _previewMedia,
            builder: (context, List<String>? medias, child) {
              if (medias != null && medias.isNotEmpty) {
                return Wrap(
                  children: List.generate(
                    medias.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blue25.withOpacity(.7),
                              ),
                              height: 100,
                              width: 100,
                              child: medias[index].checkIfFileTypeIsImage
                                  ? InkWell(
                                      onTap: () async {
                                        await OpenFilex.open(
                                          medias[index],
                                        );
                                      },
                                      child: component.fileImage(
                                          image: medias[index],
                                          fit: BoxFit.cover),
                                    )
                                  : medias[index].checkIfFileTypeIsDocumentPdf
                                      ? InkWell(
                                          onTap: () async {
                                            await OpenFilex.open(
                                              medias[index],
                                            );
                                          },
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  component.assetImage(
                                                      path: Assets.iconsFiles,
                                                      height: 25,
                                                      width: 25,
                                                      fit: BoxFit.cover),
                                                  Flexible(
                                                    child: Text(
                                                      medias[index]
                                                          .split('/')
                                                          .last,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .publicSansFonts
                                                          .thinStyle(
                                                        fontSize: 10,
                                                        fontColor:
                                                            AppColors.black01,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: InkWell(
                              onTap: () {
                                _previewMedia.value.remove(medias[index]);
                                final list = _previewMedia.value;
                                _previewMedia.value = [];
                                _previewMedia.value = list;
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.black01,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: component.assetImage(
                                  path: Assets.iconsClose,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.fillColor, width: 3),
                ),
                color: AppColors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: _handleFileSelection,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, right: 8),
                      child: component.assetImage(
                        path: Assets.iconsAttachment,
                      ),
                    ),
                  ),
                  Expanded(
                    child: input.Input(
                      onAttachmentPressed: _handleAttachmentPressed,
                      onSendPressed: _handleSendPressed,
                      uploadingMediaNotifier: _uploadingMediaNotifier,
                      // shareUrl: widget.shareUrl,
                    ),
                  ),
                  InkWell(
                    onTap: _handleImageSelection,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 8),
                      child: component.assetImage(
                        path: Assets.iconsCamera,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: component.assetImage(
                        path: Assets.iconsMicrophone,
                      ),
                    ),
                  ),
                ],
              )
              /*   Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _previewMedia,
                    builder: (context, List<MediaEntity>? medias, child) {
                      if (medias != null && medias.isNotEmpty) {
                        return Wrap(
                          children: List.generate(
                            medias.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 20, left: 20),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.blue25.withOpacity(.7),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: medias[index]
                                              .fileType
                                              .checkIfFileTypeIsImage
                                          ? InkWell(
                                              onTap: () async {
                                                await OpenFilex.open(
                                                  medias[index].file!.path,
                                                );
                                              },
                                              child: component.fileImage(
                                                  image: medias[index].file!.path,
                                                  fit: BoxFit.cover),
                                            )
                                          : medias[index]
                                                  .fileType
                                                  .checkIfFileTypeIsDocumentPdf
                                              ? InkWell(
                                                  onTap: () async {
                                                    await OpenFilex.open(
                                                      medias[index].file!.path,
                                                    );
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          component.assetImage(
                                                              path: Assets
                                                                  .iconsAttachment,
                                                              height: 25,
                                                              width: 25,
                                                              fit: BoxFit.cover),
                                                          Flexible(
                                                            child: Text(
                                                              medias[index].fileName,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                              textAlign:
                                                                  TextAlign.center,
                                                              style: theme
                                                                  .publicSansFonts
                                                                  .thinStyle(
                                                                fontSize: 10,
                                                                fontColor:
                                                                    AppColors.black01,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: InkWell(
                                      onTap: () {
                                        // _previewMedia.value.remove(medias[index]);
                                        // final list = _previewMedia.value;
                                        // _previewMedia.value = [];
                                        // _previewMedia.value = list;
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.black01,
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: component.assetImage(
                                          path: Assets.iconsCamera,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  // input.Input(
                  //   onAttachmentPressed: _handleAttachmentPressed,
                  //   onSendPressed: _handleSendPressed,
                  //   uploadingMediaNotifier: _uploadingMediaNotifier,
                  //   shareUrl: widget.shareUrl,
                  // ),
                ],
              ),
            */
              ),
        ],
      ),
    );
  }

  Widget _getDateHeader(header.DateHeader date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.blackColor.withOpacity(.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              date.dateTime.getFormattedDateTimeInStringYYYYMMDD(
                formatter: "dd MMM yy, hh:mm a",
              ),
              style: theme.publicSansFonts.mediumStyle(
                fontColor: AppColors.blackColor.withOpacity(.7),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.blackColor.withOpacity(.1),
            ),
          )
        ],
      ),
    );
  }

  void callUploadAPI(XFile? result) {
    if (result != null) {
      context.read<RegistrationCubit>().uploadDoc(result, isLoading: true);
    }
  }
}
