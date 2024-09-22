import 'dart:math';

import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);

  Size get screenSize => MediaQuery.sizeOf(context);

  double get screenWidth => min(screenSize.width, 360);
}
