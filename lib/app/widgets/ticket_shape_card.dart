import 'package:flutter/material.dart';

class TicketShapeCard extends StatelessWidget {
  const TicketShapeCard({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
  });

  final double width;
  final double height;
  final Widget? child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13),
          ),
          child: child,
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    final flexHeight = size.height / 5;
    final height = 3 * flexHeight;

    path.addOval(Rect.fromCircle(center: Offset(0.0, height), radius: 15.0));
    path.addOval(Rect.fromCircle(center: Offset(size.width, height), radius: 15.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
