import 'package:flutter/material.dart';

import 'package:marvel_t/features/home/progress_painter.dart';

class AvatarCircle extends StatefulWidget {
  final double size;
  final Color color;
  final double blurRadius;
  final double progress;

  AvatarCircle({
    this.size = 100.0,
    this.color = Colors.white,
    this.blurRadius = 20.0,
    required this.progress,
  });

  @override
  State<AvatarCircle> createState() => _AvatarCircleState();
}

class _AvatarCircleState extends State<AvatarCircle> with SingleTickerProviderStateMixin{
  late Animation<double> _progressAnimation;
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    print('progress ${widget.progress}');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: widget.progress).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(AvatarCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _controller.reset();
      _progressAnimation = Tween<double>(begin: _progressAnimation.value, end: widget.progress).animate(_controller);
      _controller.forward();
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            widget.color,
            widget.color.withOpacity(0.0),
          ],
          stops: [0.3, 1.0],
          center: Alignment.center,
          radius: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.5),
            blurRadius: widget.blurRadius,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Stack(
        children: [

          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return SizedBox(
                height: 300,
                width: 300,
                child: CustomPaint(
                  painter: ProgressPainter(_progressAnimation.value),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: ClipOval(
                child: SizedBox(
                  width: widget.size - 50,
                  height: widget.size - 50,
                  child: Image.asset(
                    'assets/heroes/iron_avatar.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}