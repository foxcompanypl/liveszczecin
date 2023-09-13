import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';
//
import 'package:liveszczecin/src/globals.dart';
import 'package:liveszczecin/src/models/camera_model.dart';

class CameraScreen extends StatefulWidget {
  final CameraModel camera;
  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final String _videoUrl = widget.camera.url;
  late BetterPlayerController _controller;
  bool _exiting = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
        BetterPlayerDataSourceType.network, _videoUrl,
        liveStream: true, useAsmsAudioTracks: false, useAsmsSubtitles: false);
    _controller = BetterPlayerController(const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: false,
        showPlaceholderUntilPlay: true,
        allowedScreenSleep: false,
        placeholder: Center(child: CircularProgressIndicator()),
        controlsConfiguration:
            BetterPlayerControlsConfiguration(showControls: false)));
    _controller.setupDataSource(dataSource);
    _controller.addEventsListener((p0) {
      if (p0.betterPlayerEventType == BetterPlayerEventType.exception) {
        exit();
      }
    });
  }

  void exit() {
    if (_exiting) {
      return;
    }
    _exiting = true;
    showSnack(
        "Powstał błąd podczas odtwarzania strumienia. Spróbuj ponownie później.");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _controller),
    );
  }
}
