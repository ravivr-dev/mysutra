import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/common/video_calling_screen/widgets/participant_widget.dart';
import 'package:videosdk/videosdk.dart';

String token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNzY2YTc2Mi0wMmQ2LTRlM2MtOGRkOC1hODFjMDY5OGM5NTkiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNTE2Nzg1MSwiZXhwIjoxNzE3NzU5ODUxfQ.2H3T4_8QVrSkjbFGSChWaqilR51LPH3Rg4soMhnhr7I';

class VideoCallingScreen extends StatefulWidget {
  const VideoCallingScreen({super.key});

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  bool _isMute = false;
  Room? _room;
  Mode mode = Mode.CONFERENCE;
  bool _isJoined = false;
  final Map<String, Participant> _participants = {};

  @override
  void initState() {
    _callCreateRoomApi();
    //todo Don't remove this code
    // _room =
    //     VideoSDK.createRoom(roomId: 'roomId', displayName: 'Name', token: '');
    // _setMeetingEventListener();
    // _room.join();
    super.initState();
  }

  void _callCreateRoomApi() async {
    Dio dio = Dio();
    final result = await dio.post('https://api.videosdk.live/v2/rooms',
        options: Options(headers: {
          'Authorization': token,
        }));

    _room = VideoSDK.createRoom(
        roomId: result.data['roomId'], displayName: 'Niki Rana', token: token);
    _initRoomListener();
    _room!.join();
    print('data ${result.data}');
  }

  /// This method should be called after joining Room (after init Room object)
  void _initRoomListener() {
    _setMeetingEventListener();
    _participants.putIfAbsent(
        _room!.localParticipant.id, () => _room!.localParticipant);
    //filtering the CONFERENCE participants to be shown in the grid
    for (var participant in _room!.participants.values) {
      if (participant.mode == Mode.CONFERENCE) {
        _participants.putIfAbsent(participant.id, () => participant);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final remoteParticipant = _room!.participants.values
        .where((element) => element.id != _room!.localParticipant.id)
        .firstOrNull;
    return Scaffold(
      body: !_isJoined
          ? CircularProgressIndicator()
          : Stack(
              children: [
                if (remoteParticipant != null)
                  ParticipantWidget(participant: remoteParticipant),
                _buildSmallVideoRow(),
                _buildBottomSheetWidget(),
              ],
            ),
    );
  }

  Widget _buildSmallVideoRow() {
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
                  'Dr. Catherine Lynch',
                  style: theme.publicSansFonts.boldStyle(
                    fontColor: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                component.spacer(height: 2),
                component.text(
                  '02:35',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(8)),
            child: ParticipantWidget(participant: _room!.localParticipant),
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
              component.spacer(height: 10),
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)),
              ),
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
                      setState(() {
                        _isMute = !_isMute;
                      });
                    },
                  ),
                  _buildBottomCallButton(
                      icon: Icons.flip_camera_ios_rounded,
                      name: 'Flip',
                      onClick: () {}),
                  _buildBottomCallButton(
                    icon: Icons.close,
                    name: 'End',
                    backgroundColor: Colors.red,
                    onClick: () {},
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

  /// This method is for listening Room events and performing operation on the bases of that event
  void _setMeetingEventListener() {
    //Setting the joining flag to true when meeting is joined
    _room!.on(Events.roomJoined, () {
      if (mode == Mode.CONFERENCE) {
        _room!.localParticipant.pin();
      }
      setState(() {
        _isJoined = true;
      });
    });

    //Handling navigation when meeting is left
    _room!.on(Events.roomLeft, () {
      AiloitteNavigation.back(context);
    });
  }
}
