library dotted_line;

import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({
    super.key,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.center,
    this.lineLength = double.infinity,
    this.lineThickness = 2.0,
    this.dashLength = 4.0,
    this.dashColor = Colors.black,
    this.dashGapLength = 4.0,
    this.dashRadius = 1.0,
  });

  final Axis direction;

  final WrapAlignment alignment;

  final double lineLength;

  final double lineThickness;

  final double dashLength;

  final Color dashColor;

  final double dashRadius;

  final double dashGapLength;

  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == Axis.horizontal;

    return SizedBox(
      width: isHorizontal ? lineLength : lineThickness,
      height: isHorizontal ? lineThickness : lineLength,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final lineLength = _getLineLength(constraints, isHorizontal);
          final dashAndDashGapCount = _calculateDashAndDashGapCount(lineLength);
          final dashCount = dashAndDashGapCount[0];
          final dashGapCount = dashAndDashGapCount[1];

          return Wrap(
            direction: direction,
            alignment: alignment,
            children: List.generate(dashCount + dashGapCount, (index) {
              if (index % 2 == 0) {
                final dash = _buildDash(isHorizontal, dashColor);
                return dash;
              } else {
                const dashGapColor = Colors.transparent;
                final dashGap = _buildDashGap(isHorizontal, dashGapColor);
                return dashGap;
              }
            }).toList(growable: false),
          );
        },
      ),
    );
  }

  double _getLineLength(BoxConstraints constraints, bool isHorizontal) {
    return lineLength == double.infinity
        ? isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight
        : lineLength;
  }

  List<int> _calculateDashAndDashGapCount(double lineLength) {
    final dashAndDashGapLength = dashLength + dashGapLength;
    int dashCount = lineLength ~/ dashAndDashGapLength;
    final dashGapCount = lineLength ~/ dashAndDashGapLength;
    if (dashLength <= lineLength % dashAndDashGapLength) {
      dashCount += 1;
    }
    return [dashCount, dashGapCount];
  }

  Widget _buildDash(bool isHorizontal, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(dashRadius),
      ),
      width: isHorizontal ? dashLength : lineThickness,
      height: isHorizontal ? lineThickness : dashLength,
    );
  }

  Widget _buildDashGap(bool isHorizontal, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      width: isHorizontal ? dashGapLength : lineThickness,
      height: isHorizontal ? lineThickness : dashGapLength,
    );
  }
}
