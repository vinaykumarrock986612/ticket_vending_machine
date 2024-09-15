import 'package:flutter/material.dart';

import '../../widgets/card_with_shadow.dart';

class PaymentsPage extends StatefulWidget {
  final String card;

  const PaymentsPage({
    super.key,
    required this.card,
  });

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
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
}
