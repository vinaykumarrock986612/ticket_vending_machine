import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../constants/hero_tags.dart';
import '../../models/passenger_details.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/app_numpad.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/fade_navigation.dart';
import '../../widgets/gap.dart';
import '../../widgets/rotate_animated_text.dart';
import '../insert_card/insert_card_screen.dart';

const _kCardRotation = pi / 2;

class PaymentScreen extends StatefulWidget {
  final String card;
  final PassengerDetails passenger;

  const PaymentScreen({
    super.key,
    required this.card,
    required this.passenger,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BaseState<PaymentScreen> {
  final cardKey = GlobalKey();
  final buttonKey = GlobalKey<AppButtonState>();
  final cvvController = TextEditingController();

  double? cardWidth;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = cardKey.currentContext?.findAncestorRenderObjectOfType() as RenderBox?;
      cardWidth = box?.size.width ?? 322;
      setState(() {});
    });

    cvvController.addListener(showPaymentButton);
  }

  void showPaymentButton() {
    if (cvvController.text.length > 2) {
      buttonKey.currentState?.show();
    }
  }

  void onCompleteTap() async {
    await Navigator.push(
      context,
      FadedPageRoute(
        gestureEnabled: false,
        duration: const Duration(milliseconds: 1000),
        child: InsertCardScreen(
          card: widget.card,
          passenger: widget.passenger,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: appBarTitle(),
      ),
      body: Column(
        children: [
          BorderedContainer(
            child: Column(
              children: [
                /// Card
                AppHero(
                  tag: widget.card,
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: CardWithShadow(
                    key: cardKey,
                    filepath: widget.card,
                  ),
                ),
                const VerticalGap(gap: 12),

                /// CVV Field
                SizedBox(
                  width: cardWidth,
                  child: cvvField(),
                ),

                const VerticalGap(gap: 12),

                /// Make Payment Button
                AppButton(
                  key: buttonKey,
                  width: cardWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  label: AppStrings.completePayment,
                  onTap: onCompleteTap,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalGap(gap: 22),
                  AppNumPad(
                    controller: cvvController,
                    maxLength: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarTitle() {
    return Row(
      children: [
        AppHero(
          tag: HeroTags.payableAmount,
          child: Text(
            AppStrings.payableAmount,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const HorizontalGap(gap: 8),
        AppHero(
          tag: HeroTags.amount,
          child: Text(
            widget.passenger.amount,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget cvvField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.enterCvvNumber,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: cvvController,
              builder: (context, child) {
                return RotateAnimatedText(
                  text: cvvController.text,
                );
              },
            ),
          ),
        ],
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
    Widget child = fromHeroContext.widget;
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeOutBack,
      parent: animation,
    );

    if (flightDirection == HeroFlightDirection.pop) {
      child = toHeroContext.widget;
      curvedAnimation.curve = Curves.easeOut;
    }

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: Tween(
            begin: 0.0,
            end: _kCardRotation,
          ).animate(curvedAnimation).value,
          child: child,
        );
      },
    );
  }
}
