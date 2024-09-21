import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/app_extensions.dart';
import '../../../widgets/base_widgets.dart';

class VendingMachine extends StatefulWidget {
  const VendingMachine({super.key});

  @override
  State<VendingMachine> createState() => _VendingMachineState();
}

class _VendingMachineState extends BaseState<VendingMachine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 490,
      width: min(screenSize.width, 360) - 80,
      decoration: BoxDecoration(
        color: theme.colors.machineColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
