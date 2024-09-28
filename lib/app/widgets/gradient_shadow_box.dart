import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';

class GradientShadowBox extends StatelessWidget {
  final Widget? child;

  final double intensity;

  const GradientShadowBox({
    super.key,
    this.child,
    this.intensity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 65),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.elliptical(100, 90),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colors.gradient[0].withOpacity(0.3 * intensity),
            blurRadius: 200,
            spreadRadius: 0,
            offset: const Offset(0, -30),
          ),
          BoxShadow(
            color: theme.colors.gradient[2].withOpacity(0.3 * intensity),
            blurRadius: 200,
            spreadRadius: 0,
            offset: const Offset(0, 30),
          ),
          BoxShadow(
            color: theme.colors.gradient[1].withOpacity(0.4 * intensity),
            blurRadius: 100,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
