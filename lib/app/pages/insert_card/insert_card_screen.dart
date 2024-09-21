import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/passenger_details.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_shadow_box.dart';
import 'components/vending_machine.dart';

const _kCardRotation = pi / 2;
const _kCardIdealScale = 0.7;

class InsertCardScreen extends StatefulWidget {
  final PassengerDetails passenger;
  final String card;

  const InsertCardScreen({
    super.key,
    required this.passenger,
    required this.card,
  });

  @override
  State<InsertCardScreen> createState() => _InsertCardScreenState();
}

class _InsertCardScreenState extends BaseState<InsertCardScreen> with TickerProviderStateMixin {
  late final machineScaleController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((value) async {
      await Future.delayed(const Duration(milliseconds: 1200));
      machineScaleController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 0,
              child: AnimatedBuilder(
                animation: machineScaleController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: machineScaleController.value,
                    child: child,
                  );
                },
                child: const VendingMachine(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GradientShadowBox(
                child: AppHero(
                  tag: widget.card,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: buildCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard() {
    Widget child = CardWithShadow(
      filepath: widget.card,
    );

    child = Transform.rotate(
      angle: _kCardRotation,
      child: child,
    );

    child = Transform.scale(
      scale: _kCardIdealScale,
      child: child,
    );

    return child;
  }

  Widget flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    Widget child = CardWithShadow(
      filepath: widget.card,
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: animation,
    );

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        child = Transform.rotate(
          angle: Tween(
            begin: 0.0,
            end: _kCardRotation,
          ).animate(curvedAnimation).value,
          child: child,
        );

        child = Transform.scale(
          scale: lerpDouble(1, _kCardIdealScale, curvedAnimation.value),
          child: child,
        );

        return child;
      },
    );
  }
}
