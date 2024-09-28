import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../constants/hero_tags.dart';
import '../../models/passenger_details.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/gap.dart';
import '../../widgets/gradient_shadow_box.dart';
import '../initial_screen/initial_screen.dart';
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
  bool showRestartButton = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      setState(() {
        showRestartButton = true;
      });
    });
  }

  void onRestartTap() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const InitialScreen(),
      ),
      (route) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xff1D2948),
        floatingActionButton: showRestartButton
            ? FloatingActionButton.extended(
                onPressed: onRestartTap,
                label: headerText(AppStrings.restart),
              )
            : null,
        body: GradientShadowBox(
          intensity: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgAssets.bookingDone,
              ),
              const VerticalGap(gap: 8),
              headerText(AppStrings.bookingDone),
              const VerticalGap(gap: 25),
              Center(
                child: AppHero(
                  tag: HeroTags.receipt,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: TravelReceipt(
                    passenger: widget.passenger,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerText(String label) {
    return Text(
      label,
      style: theme.textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
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
