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
const _kCardIdealScale = 0.6;
const _kCardMinScale = 0.26;

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
  final cardKey = GlobalKey();
  final machineKey = GlobalKey<VendingMachineState>();
  late final machineScaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final cardInsertController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300));
  late final cardAnimation = CurvedAnimation(parent: cardInsertController, curve: Curves.linearToEaseOut);

  Offset? cardOffset;
  Size? cardSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((value) async {
      setState(() {
        getCardSize();
      });
      startTransaction();
    });
  }

  @override
  void dispose() {
    machineScaleController.dispose();
    cardInsertController.dispose();
    super.dispose();
  }

  Future<void> startTransaction() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    await machineScaleController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    await cardInsertController.forward();
  }

  void getCardSize() {
    final box = cardKey.currentContext?.findRenderObject() as RenderBox?;
    cardSize = box?.size;
  }

  Offset getCardOffset() {
    final slotOffset = machineKey.currentState?.cardSlotOffset ?? Offset.zero;
    final resetDx = (screenSize.width / 2) - 15;
    final effectiveDx = -resetDx + slotOffset.dx;
    final effectiveDy = screenSize.height - (slotOffset.dy + ((cardSize?.height ?? 0) / 2));

    return Tween<Offset>(
      begin: Offset.zero,
      end: Offset(effectiveDx, -effectiveDy),
    ).evaluate(cardAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: AnimatedBuilder(
          animation: Listenable.merge([machineScaleController, cardInsertController]),
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  child: Transform.scale(
                    scale: machineScaleController.value,
                    child: VendingMachine(
                      key: machineKey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipPath(
                    clipper: CardSlotClipper(
                      screenSize: screenSize,
                      cardSize: cardSize,
                      slotOffset: machineKey.currentState?.cardSlotOffset,
                    ),
                    child: GradientShadowBox(
                      key: cardKey,
                      child: AppHero(
                        tag: widget.card,
                        flightShuttleBuilder: flightShuttleBuilder,
                        child: buildCard(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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

    child = Transform.scale(
      scale: Tween<double>(
        begin: 1,
        end: _kCardMinScale,
      ).evaluate(cardAnimation),
      child: child,
    );

    child = Transform.translate(
      offset: getCardOffset(),
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

class CardSlotClipper extends CustomClipper<Path> {
  const CardSlotClipper({
    required this.screenSize,
    required this.cardSize,
    required this.slotOffset,
  });

  final Size screenSize;
  final Size? cardSize;
  final Offset? slotOffset;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height);

    final effectiveHeight = screenSize.height - (cardSize?.height ?? 0) - (slotOffset?.dy ?? 0);

    path.addRect(
      Rect.fromPoints(
        Offset(-100, -effectiveHeight),
        Offset(screenSize.width, 1000),
      ),
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
