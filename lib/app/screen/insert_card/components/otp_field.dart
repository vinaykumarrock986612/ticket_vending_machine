import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../widgets/base_widgets.dart';
import '../../../widgets/gap.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends BaseState<OtpField> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.waitingForOTP,
          style: theme.textTheme.titleMedium,
        ),
        const VerticalGap(gap: 12),
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final t = controller.value * 4;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: otpCard(isHighlighted: t >= i && t < i + 1),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget otpCard({
    bool isHighlighted = false,
  }) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isHighlighted ? 1 : 0.5),
        border: Border.all(
          color: const Color(0xff5FA040),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
