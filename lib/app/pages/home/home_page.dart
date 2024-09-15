import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/fade_navigation.dart';
import '../../widgets/vertical_card_swiper.dart';
import '../payments/payments_page.dart';

const _kCardRotation = pi / 2;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final verticalSwiperKey = GlobalKey<VerticalCardSwiperState>();

  final cardList = [
    SvgAssets.card1,
    SvgAssets.card2,
    SvgAssets.card3,
    SvgAssets.card4,
  ];

  void onCardTap(String card, int index) {
    if (verticalSwiperKey.currentState?.foregroundCardIndex == index) {
      Navigator.of(context).push(
        FadedPageRoute(
          child: PaymentsPage(
            card: card,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 500,
            child: VerticalCardSwiper(
              key: verticalSwiperKey,
              cardCount: cardList.length,
              cardBuilder: (context, index) {
                final card = cardList.reversed.toList()[index];
                return Hero(
                  tag: card,
                  transitionOnUserGestures: true,
                  flightShuttleBuilder: (
                    flightContext,
                    animation,
                    flightDirection,
                    fromHeroContext,
                    toHeroContext,
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
                  },
                  child: Transform.rotate(
                    angle: -_kCardRotation,
                    child: GestureDetector(
                      onTap: () => onCardTap(card, index),
                      child: CardWithShadow(
                        filepath: card,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
