import 'dart:math';

import 'package:flutter/material.dart';

class DisplayFrame extends StatelessWidget {
  final Widget? child;
  final double height;

  const DisplayFrame({
    super.key,
    this.child,
    this.height = 132,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              child ?? const SizedBox(),

              /// Top
              Positioned(
                top: -5,
                child: topBottomFrame(width),
              ),

              /// Bottom
              Positioned(
                bottom: 0,
                child: topBottomFrame(width),
              ),

              /// Left
              const CustomPaint(
                painter: SideFramePainter(
                  color: Color(0xff696969),
                ),
              ),

              /// Right
              Transform.translate(
                offset: Offset(width, 0),
                child: Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  child: const CustomPaint(
                    painter: SideFramePainter(
                      color: Color(0xff696969),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget topBottomFrame(double? width) {
    return Container(
      color: const Color(0xff4E4E4E),
      height: 20,
      width: width,
    );
  }
}

class SideFramePainter extends CustomPainter {
  final double width;
  final Color color;

  const SideFramePainter({
    this.width = 8,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();

    path.lineTo(width, 0);
    path.lineTo(width, height - 20);
    path.lineTo(0, height);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
