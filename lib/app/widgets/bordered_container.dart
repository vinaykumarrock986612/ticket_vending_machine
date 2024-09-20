import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';

class BorderedContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;

  const BorderedContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
        margin: margin,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
