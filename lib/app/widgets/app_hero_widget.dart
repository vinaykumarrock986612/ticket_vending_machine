import 'package:flutter/cupertino.dart';

class AppHero extends Hero {
  const AppHero({
    super.key,
    required super.tag,
    required super.child,
    super.createRectTween,
    super.flightShuttleBuilder,
    super.placeholderBuilder,
    super.transitionOnUserGestures = true,
  });
}
