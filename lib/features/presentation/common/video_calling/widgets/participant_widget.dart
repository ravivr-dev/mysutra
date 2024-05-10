import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:videosdk/videosdk.dart';

class ParticipantWidget extends StatefulWidget {
  final Participant participant;

  const ParticipantWidget({super.key, required this.participant});

  @override
  State<ParticipantWidget> createState() => _ParticipantWidgetState();
}

class _ParticipantWidgetState extends State<ParticipantWidget> {
  Stream? _videoStream;

  @override
  void initState() {
    _initVideoStream();
    _initStreamListeners();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ParticipantWidget oldWidget) {
    if (oldWidget.participant.id != widget.participant.id) {
      _initVideoStream();
      _initStreamListeners();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _videoStream != null
        ? RTCVideoView(
            _videoStream?.renderer as RTCVideoRenderer,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          )
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.blackColor.withOpacity(.01),
                  AppColors.blackColor.withOpacity(.57),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 100,
              ),
            ),
          );
  }

  void _initVideoStream() {
    widget.participant.streams.forEach((key, Stream stream) {
      if (stream.kind == 'video') {
        setState(() => _videoStream = stream);
      }
    });
  }

  void _initStreamListeners() {
    widget.participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => _videoStream = stream);
      }
    });

    widget.participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => _videoStream = null);
      }
    });
  }
}
