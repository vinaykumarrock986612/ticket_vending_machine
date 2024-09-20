import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/hero_tags.dart';
import '../../../utils/app_extensions.dart';
import '../../../widgets/app_hero_widget.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/gap.dart';

class TicketFareCard extends StatelessWidget {
  final String from;
  final String to;
  final String passenger;
  final String amount;

  const TicketFareCard({
    super.key,
    required this.from,
    required this.to,
    required this.passenger,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Travel Route, Passenger
          Expanded(child: passengerDetails(context)),

          /// Ticket Fare
          ticketAmount(context),
        ],
      ),
    );
  }

  Widget passengerDetails(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        iconWithLabel(
          svgIconPath: SvgAssets.bus,
          labelWidget: Row(
            children: [
              Text(
                from,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(SvgAssets.rightArrow),
              ),
              Text(
                to,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const VerticalGap(gap: 8),
        iconWithLabel(
          svgIconPath: SvgAssets.person,
          labelWidget: Text(
            passenger,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colors.tertiaryText,
            ),
          ),
        ),
      ],
    );
  }

  Widget ticketAmount(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHero(
          tag: HeroTags.payableAmount,
          child: Text(
            AppStrings.payableAmount,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const VerticalGap(gap: 8),
        AppHero(
          tag: HeroTags.amount,
          flightShuttleBuilder: fareAmountShuttleBuilder,
          child: Text(
            amount,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget iconWithLabel({
    required String svgIconPath,
    required Widget labelWidget,
  }) {
    return Row(
      children: [
        SvgPicture.asset(svgIconPath),
        const HorizontalGap(gap: 8),
        labelWidget,
      ],
    );
  }

  Widget fareAmountShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final theme = Theme.of(flightContext);

    animation = CurvedAnimation(
      parent: animation,
      curve: Curves.linearToEaseOut,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Text(
          amount,
          maxLines: 1,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: lerpDouble(24, 18, animation.value),
          ),
        );
      },
    );
  }
}
