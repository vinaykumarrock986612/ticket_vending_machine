import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../widgets/app_button.dart';
import '../../widgets/base_widgets.dart';
import '../../widgets/fade_navigation.dart';
import '../../widgets/gap.dart';
import '../home/home_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends BaseState<InitialScreen> {
  final buttonKey = GlobalKey<AppButtonState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((value) {
      buttonKey.currentState?.show();
    });
  }

  void onStartTap() {
    Navigator.push(
      context,
      FadedPageRoute(
        gestureEnabled: false,
        child: const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const VerticalGap(gap: 25),
            AppButton(
              key: buttonKey,
              label: AppStrings.start,
              width: 200,
              onTap: onStartTap,
            ),
          ],
        ),
      ),
    );
  }
}
