import 'package:flutter/material.dart';

import 'base_widgets.dart';

class FixedCrossAxisCountBuilder extends StatefulWidget {
  final int crossAxisCount;
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final double spacing;

  const FixedCrossAxisCountBuilder({
    super.key,
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = 0.0,
  });

  @override
  State<FixedCrossAxisCountBuilder> createState() => _FixedCrossAxisCountBuilderState();
}

class _FixedCrossAxisCountBuilderState extends BaseState<FixedCrossAxisCountBuilder> {
  @override
  Widget build(BuildContext context) {
    final rowCount = (widget.itemCount / widget.crossAxisCount).ceil();
    int k = 0;
    return Column(
      children: [
        for (int i = 0; i < rowCount; i++)
          Padding(
            padding: EdgeInsets.only(bottom: widget.spacing),
            child: Row(
              children: [
                for (int j = 0; j < widget.crossAxisCount && k < widget.itemCount; {j++, k++})
                  Expanded(
                    child: widget.itemBuilder.call(context, k) ?? const SizedBox(),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
