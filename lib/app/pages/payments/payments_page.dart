import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../constants/hero_tags.dart';
import '../../utils/app_extensions.dart';
import '../../widgets/app_hero_widget.dart';
import '../../widgets/app_numpad.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/card_with_shadow.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gap.dart';
import '../../widgets/rotate_animated_text.dart';

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
  final cardKey = GlobalKey();
  final cvvController = TextEditingController();

  double? cardWidth;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((value) {
      final box = cardKey.currentContext?.findAncestorRenderObjectOfType() as RenderBox?;
      cardWidth = box?.size.width;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: appBarTitle(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colors.border),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  AppHero(
                    transitionOnUserGestures: true,
                    tag: widget.card,
                    child: CardWithShadow(
                      key: cardKey,
                      filepath: widget.card,
                    ),
                  ),
                  const VerticalGap(gap: 12),
                  SizedBox(
                    width: cardWidth,
                    child: cvvField(),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          AppNumPad(
            controller: cvvController,
            maxLength: 3,
          ),
          const VerticalGap(gap: 12),
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
}
