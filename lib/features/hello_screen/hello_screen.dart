import 'package:flutter/material.dart';
import 'package:marvel_t/features/hello_screen/slide_to_confirm_button.dart';
import 'package:marvel_t/features/hello_screen/speech_buble.dart';
import 'package:video_player/video_player.dart';

class HelloScreen extends StatefulWidget {
  const HelloScreen({super.key});

  @override
  State<HelloScreen> createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/background/background.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
                : Container(),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black54,
          ),
          Positioned(
            bottom: -340,
            right: -100,
            child: SizedBox(
              width: 400,
              child: Image.asset('assets/heroes/iron_man.png'),
            ),
          ),
          Positioned(
            top: 200,
              left: 20,
              child: SpeechBubble(text: 'Hello superheroe! \n Let\'s track your missions!'),
          ),
          Positioned(
            bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                  child: SlideToConfirmButton()))
        ],
      ),
    );
  }
}
