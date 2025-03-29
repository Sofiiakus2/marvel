import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: SizedBox.expand(
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'assets/background/back.jpg',
                  )
              ),
            )
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black54,
        ),
      ],
    );
  }
}
