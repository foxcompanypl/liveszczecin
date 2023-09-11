import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/camera_model.dart';

class CameraWidget extends StatefulWidget {
  final CameraModel camera;
  const CameraWidget({super.key, required this.camera});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late String _videoUrl;
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // TODO: Remove this line when certificate is valid
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _videoUrl = widget.camera.url.replaceFirst(RegExp("^https://"), "http://");
    initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void initVideoPlayer() {
    debugPrint("Url: $_videoUrl");
    var dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      _videoUrl,
      liveStream: true,
    );
    _controller = BetterPlayerController(const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: false,
        controlsConfiguration:
            BetterPlayerControlsConfiguration(showControls: false)));
    _controller.setupDataSource(dataSource);
    _controller.addEventsListener((p0) {
      if (p0.betterPlayerEventType == BetterPlayerEventType.exception) {
        Fluttertoast.showToast(
            msg:
                "Powstał błąd podczas odtwarzania strumienia. Spróbuj ponownie później.",
            toastLength: Toast.LENGTH_SHORT);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _controller),
    );
  }
}
