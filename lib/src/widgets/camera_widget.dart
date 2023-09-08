import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import '../models/camera_model.dart';

class CameraWidget extends StatefulWidget {
  final CameraModel camera;
  const CameraWidget({super.key, required this.camera});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late String _videoUrl;
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    // TODO: Remove this line when certificate is valid
    _videoUrl =
        widget.camera.url.replaceFirst(RegExp("^https\:\/\/"), "http://");
    initVideoPlayer();
  }

  void initVideoPlayer() {
    print("Url: ${_videoUrl}");
    var dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      _videoUrl,
      liveStream: true,
    );
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoPlay: true,
            looping: false,
            controlsConfiguration:
                BetterPlayerControlsConfiguration(showControls: false)));
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
