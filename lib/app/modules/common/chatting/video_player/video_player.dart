import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String url;

  const VideoPlayerView({super.key, required this.url});

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  final Duration _skipDuration = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _fastForward() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;
    final skipForwardPosition = currentPosition + _skipDuration;
    _controller.seekTo(
        skipForwardPosition < duration ? skipForwardPosition : duration);
  }

  void _rewind() {
    final currentPosition = _controller.value.position;
    final skipBackwardPosition = currentPosition - _skipDuration;
    _controller.seekTo(skipBackwardPosition > Duration.zero
        ? skipBackwardPosition
        : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
          // title: const Text('Video Player'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _rewind,
                child: const Icon(Icons.fast_rewind),
              ),
              // Provide some space between the buttons
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),

              FloatingActionButton(
                onPressed: _fastForward,
                child: const Icon(Icons.fast_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
