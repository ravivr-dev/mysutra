import 'dart:async';

import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/user_entities/video_room_response_entity.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_screen.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/common/video_calling/widgets/participant_widget.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:videosdk/videosdk.dart';

class VideoCallingScreen extends StatefulWidget {
  final VideoCallingArgs args;

  const VideoCallingScreen({super.key, required this.args});

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  bool _isMute = false;
  Room? _room;
  bool _isJoined = false;
  final Map<String, Participant> _participants = {};
  bool _isFrontCameraEnabled = true;
  bool _showLocalParticipantFullVideo = false;
  final ValueNotifier<String> _timerNotifier = ValueNotifier('00:00');
  late Timer _timer;
  bool _isChatEnabled = false;

  @override
  void initState() {
    _room = VideoSDK.createRoom(
        roomId: widget.args.entity.videoSdkRoomId,
        displayName: '',
        defaultCameraIndex: 1,
        camEnabled: widget.args.isVideoCall,
        token: widget.args.entity.videoSdkToken);
    _initRoomListener();
    _initLocalParticipants();
    _room!.join();
    _initCallTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteParticipant = _room?.participants.values
        .where((element) => element.id != _room?.localParticipant.id)
        .firstOrNull;
    final Participant? localParticipant = _room?.localParticipant;

    return Scaffold(
      body: !_isJoined
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                if (_showLocalParticipantFullVideo || remoteParticipant != null)

                  ///This is a widget that will show video in full screen
                  ParticipantWidget(
                      participant: _showLocalParticipantFullVideo
                          ? localParticipant!
                          : remoteParticipant!)
                else
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.01, 0.4],
                      colors: [
                        AppColors.blackColor.withOpacity(.01),
                        AppColors.color0xFFEEEEEE,
                      ],
                    )),
                    child: component.text(
                        '${UserHelper.role == UserRole.patient ? 'Doctor' : 'Patient'} will be joining soon',
                        style: theme.publicSansFonts.regularStyle(
                          fontSize: 20,
                          fontColor: AppColors.color0xFF5C5C5C,
                        )),
                  ),
                _buildSmallVideoRow(!_showLocalParticipantFullVideo
                    ? localParticipant
                    : remoteParticipant),
                _buildBottomSheetWidget(),
                if (_isChatEnabled) _buildChatWidget()
              ],
            ),
    );
  }

  Widget _buildChatWidget() {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) => setState(() => _isChatEnabled = false),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isChatEnabled = false;
                });
              },
              child: Container(
                height: 50,
                color: AppColors.green2BEF83,
              ),
            ),
            Expanded(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<RegistrationCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<ChatCubit>(),
                  ),
                ],
                child: ChatScreen(
                    args: ChatScreenArgs(
                        roomId: widget.args.roomId,
                        username: widget.args.name,
                        currentUserId: widget.args.currentUserId,
                        remoteUserId: widget.args.remoteUserId,
                        showBackButton: false)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSmallVideoRow(Participant? participant) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.text(
                  widget.args.name,
                  style: theme.publicSansFonts.boldStyle(
                    fontColor: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                component.spacer(height: 2),
                ValueListenableBuilder(
                    valueListenable: _timerNotifier,
                    builder: (_, value, __) {
                      return component.text(
                        value,
                        style: theme.publicSansFonts.regularStyle(
                          fontColor: AppColors.white,
                        ),
                      );
                    })
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _showLocalParticipantFullVideo =
                    !_showLocalParticipantFullVideo;
              });
            },
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: participant != null
                  ? ParticipantWidget(participant: participant)
                  : const Icon(Icons.person),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheetWidget() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(17)),
              color: AppColors.black37.withOpacity(.3)),
          child: Column(
            children: [
              // component.spacer(height: 10),
              // Container(
              //   height: 4,
              //   width: 50,
              //   decoration: BoxDecoration(
              //       color: AppColors.color0xFFD8D8D8,
              //       borderRadius: BorderRadius.circular(10)),
              // ),
              component.spacer(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBottomCallButton(
                    icon: Icons.mic_off,
                    name: 'Mute',
                    backgroundColor: _isMute ? AppColors.color0xFF8338EC : null,
                    onClick: () {
                      if (_isMute) {
                        _room?.unmuteMic();
                      } else {
                        _room?.muteMic();
                      }
                      setState(() {
                        _isMute = !_isMute;
                      });
                    },
                  ),
                  _buildBottomCallButton(
                      icon: Icons.chat_bubble_outline,
                      name: 'Chat',
                      onClick: () => setState(() {
                            _isChatEnabled = true;
                          })),
                  if (_room?.camEnabled ?? true)
                    _buildBottomCallButton(
                        icon: Icons.flip_camera_ios_rounded,
                        name: 'Flip',
                        onClick: () {
                          ///0 index of list is for back camera 1 for front
                          final list = _room?.getCameras() ?? [];
                          if (list.isNotEmpty && _isFrontCameraEnabled) {
                            _isFrontCameraEnabled = !_isFrontCameraEnabled;
                            _room?.changeCam(list[0].deviceId);
                          } else if (list.length > 1 &&
                              !_isFrontCameraEnabled) {
                            _isFrontCameraEnabled = !_isFrontCameraEnabled;
                            _room?.changeCam(list.last.deviceId);
                          }
                        }),
                  _buildBottomCallButton(
                    icon: Icons.close,
                    name: 'End',
                    backgroundColor: AppColors.color0xFFF83D39,
                    onClick: () {
                      _room?.end();
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildBottomCallButton(
      {required IconData icon,
      required String name,
      Color? backgroundColor,
      required VoidCallback onClick}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onClick,
          child: CircleAvatar(
              backgroundColor:
                  backgroundColor ?? AppColors.white.withOpacity(.2),
              radius: 35,
              child: Icon(icon, color: AppColors.white, size: 30)),
        ),
        component.spacer(height: 15),
        component.text(name,
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.white,
            ))
      ],
    );
  }

  /// This method is for checking call duration
  void _initCallTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final min = timer.tick ~/ 60;
      final sec = timer.tick - min * 60;
      _timerNotifier.value =
          '${'${min > 0 ? min : '0'}'.padLeft(2, '0')}:${'$sec'.padLeft(2, '0')}';
    });
  }

  /// This method is for listening Room events and performing operation on the bases of that event
  void _initRoomListener() {
    _room!.on(Events.roomJoined, () {
      // if (_room == Mode.CONFERENCE) {
      //   _room!.localParticipant.pin();
      // }
      setState(() {
        _isJoined = true;
      });
    });
    _room!.on(Events.participantJoined, () {
      _initRemoteParticipants();
    });

    //Handling navigation when meeting is left
    _room!.on(Events.roomLeft, () {
      AiloitteNavigation.back(context);
    });
  }

  void _initLocalParticipants() {
    _participants.putIfAbsent(
        _room!.localParticipant.id, () => _room!.localParticipant);
  }

  void _initRemoteParticipants() {
    for (var participant in _room!.participants.values) {
      if (participant.mode == Mode.CONFERENCE) {
        _participants.putIfAbsent(participant.id, () => participant);
      }
    }
    setState(() {});
  }
}

class VideoCallingArgs {
  VideoRoomResponseEntity entity;
  final bool isVideoCall;
  final String name;
  final String roomId;
  final String currentUserId;
  final String remoteUserId;

  VideoCallingArgs({
    required this.entity,
    required this.name,
    required this.isVideoCall,
    required this.roomId,
    required this.remoteUserId,
    required this.currentUserId,
  });
}
