import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants/hero_tags.dart';
import '../../models/passenger_details.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/base_widgets.dart';
import '../insert_card/components/travel_receipt.dart';

const _kReceiptScale = 0.2;

class BookingSuccessfulScreen extends StatefulWidget {
  final PassengerDetails passenger;

  const BookingSuccessfulScreen({
    super.key,
    required this.passenger,
  });

  @override
  State<BookingSuccessfulScreen> createState() => _BookingSuccessfulScreenState();
}

class _BookingSuccessfulScreenState extends BaseState<BookingSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppHero(
          tag: HeroTags.receipt,
          flightShuttleBuilder: flightShuttleBuilder,
          child: TravelReceipt(
            passenger: widget.passenger,
          ),
        ),
      ),
    );
  }

  Widget flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    Widget child = toHeroContext.widget;

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        child = Center(
          child: Transform.scale(
            scale: lerpDouble(_kReceiptScale, 1, animation.value),
            child: child,
          ),
        );

        return child;
      },
    );
  }
}
