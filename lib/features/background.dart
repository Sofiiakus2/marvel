import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Color color;

  Background({
    this.color = Colors.black54,
  });


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
          color: color,
        ),
      ],
    );
  }
}
