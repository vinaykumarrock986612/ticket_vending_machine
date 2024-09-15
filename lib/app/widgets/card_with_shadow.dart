import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardWithShadow extends StatelessWidget {
  final String filepath;

  const CardWithShadow({
    super.key,
    required this.filepath,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      filepath,
    );
  }
}
