import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../models/passenger_details.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/fade_navigation.dart';
import '../../widgets/gap.dart';
import '../../widgets/segmented_tab_bar.dart';
import '../../widgets/vertical_card_swiper.dart';
import '../payments/payments_page.dart';
import 'components/ticket_fare_card.dart';

const _kCardRotation = pi / 2;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> with TickerProviderStateMixin {
  final verticalSwiperKey = GlobalKey<VerticalCardSwiperState>();
  late final tabController = TabController(length: 3, vsync: this, initialIndex: selectedTabIndex);
  late final cardSlideController = AnimationController(vsync: this);
  int selectedTabIndex = 1;

  final cardList = [
    SvgAssets.card1,
    SvgAssets.card2,
    SvgAssets.card3,
    SvgAssets.card4,
  ];

  final tabNames = [
    AppStrings.upi,
    AppStrings.card,
    AppStrings.netBanking,
  ];

  final passenger = const PassengerDetails(
    from: "HBX",
    to: "BLR",
    passenger: "1 Adult",
    amount: "\$ 580",
  );

  @override
  void dispose() {
    cardSlideController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void onCardTap(String card, int index) {
    if (verticalSwiperKey.currentState?.foregroundCardIndex == index) {
      Navigator.of(context).push(
        FadedPageRoute(
          child: PaymentsPage(
            card: card,
            passenger: passenger,
          ),
        ),
      );
    }
  }

  void onTabChange(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        alignCenter: false,
        titleWidget: appBarTitle(),
      ),
      body: Column(
        children: [
          TicketFareCard(
            passenger: passenger,
          ),
          const VerticalGap(gap: 25),
          SegmentedTabBar(
            tabController: tabController,
            tabNames: tabNames,
            selectedIndex: selectedTabIndex,
            onTap: onTabChange,
          ),
          const VerticalGap(gap: 10),
          Expanded(
            child: VerticalCardSwiper(
              key: verticalSwiperKey,
              cardCount: cardList.length,
              cardBuilder: (context, index) {
                final card = cardList[index];

                return AppHero(
                  tag: card,
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

  Widget appBarTitle() {
    return Text(
      AppStrings.payments,
      style: theme.textTheme.titleMedium,
    );
  }
}
