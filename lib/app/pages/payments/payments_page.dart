import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../constants/hero_tags.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gap.dart';

class PaymentsPage extends StatefulWidget {
  final String card;
  final String from;
  final String to;
  final String passenger;
  final String amount;

  const PaymentsPage({
    super.key,
    required this.card,
    required this.from,
    required this.to,
    required this.passenger,
    required this.amount,
  });

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends BaseState<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: appBarTitle(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppHero(
              transitionOnUserGestures: true,
              tag: widget.card,
              child: CardWithShadow(
                filepath: widget.card,
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
            widget.amount,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
