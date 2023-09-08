import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/camera_model.dart';

class CameraWidget extends StatefulWidget {
  final CameraModel camera;
  const CameraWidget({super.key, required this.camera});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late String _videoUrl;
  late VideoPlayerController _controller;

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
    _controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl));
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_controller),
    );
  }
}
