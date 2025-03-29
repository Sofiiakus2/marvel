import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideToConfirmButton extends StatefulWidget {
  const SlideToConfirmButton({super.key});

  @override
  _SlideToConfirmButtonState createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<SlideToConfirmButton> {
  double position = 0.0;
  bool confirmed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          position += details.delta.dx;
          position = position.clamp(0.0, 250.0);
        });
      },
      onHorizontalDragEnd: (details) {
        if (position >= 250.0) {
          setState(() {
            confirmed = true;
            Navigator.pushNamed(context, '/registration');
          });
        } else {
          setState(() {
            position = 0.0;
          });
        }
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white,

                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              confirmed ? "GOOOO!" : "READY?",
              style: Theme.of(context).textTheme.labelMedium
            ),
          ),
          Positioned(
            left: position,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Icon(Icons.double_arrow_rounded, color: Colors.black, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}