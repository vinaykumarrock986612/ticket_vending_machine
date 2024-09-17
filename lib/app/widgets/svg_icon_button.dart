import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_inkwell.dart';

class SvgIconButton extends StatelessWidget {
  final String filePath;
  final VoidCallback? onTap;
  final double height;

  const SvgIconButton({
    super.key,
    required this.filePath,
    this.onTap,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        filePath,
        height: height,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
