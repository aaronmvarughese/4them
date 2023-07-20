import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WhatsAppVideoTutorial extends StatefulWidget {
  const WhatsAppVideoTutorial({super.key});

  @override
  WhatsAppVideoTutorialState createState() => WhatsAppVideoTutorialState();
}

class WhatsAppVideoTutorialState extends State<WhatsAppVideoTutorial> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/videos/sg.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _reloadVideo() {
    _videoPlayerController.seekTo(Duration.zero);
    _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Customize the background color
        padding: EdgeInsets.all(16.0), // Customize the padding
        child: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reloadVideo,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
