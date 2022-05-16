import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

///基于Chewie再次封装
class VideoPlayWidget extends StatefulWidget {
  final String url;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedChanging;

  const VideoPlayWidget({
    Key? key,
    required this.url,
    this.autoPlay = true,
    this.looping = true,
    this.aspectRatio = 16 / 9,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedChanging = true,
  }) : super(key: key);

  @override
  State<VideoPlayWidget> createState() => VideoPlayWidgetState();
}

class VideoPlayWidgetState extends State<VideoPlayWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _cheWieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _cheWieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      aspectRatio: widget.aspectRatio,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedChanging,
      allowFullScreen: widget.allowFullScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = width / widget.aspectRatio;
    return SizedBox(
      width: width,
      height: height,
      child: Chewie(controller: _cheWieController),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _cheWieController.dispose();
    super.dispose();
  }

  void play() {
    _cheWieController.play();
  }
  void pause() {
    _videoPlayerController.pause();
  }
}
