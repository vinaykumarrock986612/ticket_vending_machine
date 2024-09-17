import 'package:flutter/material.dart';

import 'app/config/theme.dart';
import 'app/constants/app_strings.dart';
import 'app/pages/home/home_page.dart';
import 'app/utils/app_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: lightTheme(),
      home: const HomePage(),
      builder: builder,
    );
  }

  Widget builder(BuildContext context, Widget? child) {
    final size = MediaQuery.sizeOf(context);
    if (size.width < 360) return child ?? const SizedBox();

    return Align(
      child: Container(
        width: 360,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(),
          ],
        ),
        child: child,
      ),
    );
  }
}