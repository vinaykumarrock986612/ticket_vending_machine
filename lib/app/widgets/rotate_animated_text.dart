import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';
import 'base_widgets.dart';

class RotateAnimatedText extends StatefulWidget {
  final String text;

  const RotateAnimatedText({
    super.key,
    required this.text,
  });

  @override
  State<RotateAnimatedText> createState() => _RotateAnimatedTextState();
}

class _RotateAnimatedTextState extends BaseState<RotateAnimatedText> with TickerProviderStateMixin {
  String completeText = "";
  String remainingCharacters = "";
  String lastCharacter = "";
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  @override
  void initState() {
    super.initState();
    splitText(widget.text);
  }

  @override
  void didUpdateWidget(covariant RotateAnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    splitText(widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void splitText(String text) {
    if (completeText == text) return;
    controller.reset();
    final lastIndex = text.length - 1;

    if (text.length > completeText.length) {
      completeText = text;
      lastCharacter = text[lastIndex];
      remainingCharacters = text.substring(0, lastIndex);
      controller.forward();
    } else if (text.length < completeText.length) {
      completeText = text;
      remainingCharacters = completeText;
      controller.reverse(from: 1);
    }
    completeText = text;
  }

  double getRotation() {
    return lerpDouble(pi / 2, 0, controller.value)!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: theme.colors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildText(remainingCharacters),
          AnimatedBuilder(
            animation: controller,
            child: buildText(lastCharacter),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()..rotateX(getRotation()),
                child: child!,
              );
            },
          ),
        ],
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 17,
      ),
    );
  }
}
