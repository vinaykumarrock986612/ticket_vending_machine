import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'base_widgets.dart';



class GradientLoader extends StatefulWidget {
  final double height;

  const GradientLoader({
    super.key,
    this.height = 4.5,
  });

  @override
  State<GradientLoader> createState() => _GradientLoaderState();
}

class _GradientLoaderState extends BaseState<GradientLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ColorTween _startColorTween;
  late ColorTween _endColorTween;
  late final ValueNotifier<Color> _currentStartColor = ValueNotifier(Colors.transparent);
  late final ValueNotifier<Color> _currentEndColor = ValueNotifier(Colors.transparent);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _startColorTween = ColorTween(
      begin: _currentStartColor.value,
      end: getRandomColor(),
    );

    _endColorTween = ColorTween(
      begin: _currentEndColor.value,
      end: getRandomColor(),
    );

    _startAnimation();

    _controller.addListener(() {
      _currentStartColor.value = _startColorTween.evaluate(_controller)!;
      _currentEndColor.value = _endColorTween.evaluate(_controller)!;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void _startAnimation() {
    _controller.forward();
    _controller.addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          _startColorTween.begin = _currentStartColor.value;
          _startColorTween.end = getRandomColor();
          _endColorTween.begin = _currentEndColor.value;
          _endColorTween.end = getRandomColor();
          _controller.reset();
          _controller.forward();
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _currentStartColor.value,
                _currentEndColor.value,
                _currentStartColor.value,
                _currentEndColor.value,
              ],
            ),
          ),
        );
      },
    );
  }

}
