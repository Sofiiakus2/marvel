import 'package:flutter/material.dart';

import '../hello_screen/speech_buble.dart';

class IronManSpeech extends StatelessWidget {
  final String ironManText;
  const IronManSpeech({super.key, required this.ironManText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -340,
          right: -100,
          child: SizedBox(
            width: 400,
            child: Image.asset('assets/heroes/iron_man_stand.png'),
          ),
        ),
        Positioned(
          bottom: 350,
          left: 20,
          child: SpeechBubble(text: ironManText),
        ),
      ],
    );
  }
}
