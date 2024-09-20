import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';
import 'base_widgets.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.padding,
    this.width,
  });

  @override
  State<AppButton> createState() => AppButtonState();
}

class AppButtonState extends BaseState<AppButton> with TickerProviderStateMixin {
  late final scaleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  );

  void onTap() {
    widget.onTap?.call();
    scaleController.forward().then((value) {
      scaleController.reverse();
    });
  }

  Offset getSlideOffset() {
    return Tween<Offset>(
      begin: const Offset(0, 60),
      end: const Offset(0, 0),
    ).evaluate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.linearToEaseOut,
      ),
    );
  }

  void show() {
    slideController.forward();
  }

  void hide() {
    slideController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: Listenable.merge([slideController, scaleController]),
          builder: (context, child) {
            Widget child = button();
            child = scaleWrapper(child);
            child = slideWrapper(child);
            child = scaleFactorWrapper(child);
            return child;
          },
        ),
      ),
    );
  }

  Widget button() {
    return Container(
      height: 48,
      width: widget.width,
      margin: widget.padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorTween(
          begin: theme.colors.primary,
          end: theme.colors.secondary,
        ).evaluate(scaleController),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(3, 2),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Text(
        widget.label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget scaleWrapper(Widget child) {
    return Transform.scale(
      scale: lerpDouble(1, 0.95, scaleController.value),
      child: GestureDetector(
        onTap: onTap,
        onTapDown: (_) => scaleController.forward(),
        onTapCancel: () => scaleController.reverse(),
        onTapUp: (_) => scaleController.reverse(),
        child: child,
      ),
    );
  }

  Widget slideWrapper(Widget child) {
    return Transform.translate(
      offset: getSlideOffset(),
      child: Transform.scale(
        scale: lerpDouble(0.7, 1, slideController.value),
        child: GestureDetector(
          onTap: onTap,
          onTapDown: (_) => scaleController.forward(),
          onTapCancel: () => scaleController.reverse(),
          onTapUp: (_) => scaleController.reverse(),
          child: child,
        ),
      ),
    );
  }

  Widget scaleFactorWrapper(Widget child) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: Tween<double>(
        begin: 0,
        end: 1,
      ).evaluate(
        CurvedAnimation(
          parent: slideController,
          curve: Curves.fastEaseInToSlowEaseOut,
        ),
      ),
      child: child,
    );
  }
}
