import 'package:flutter/material.dart';

import 'app/config/theme.dart';
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
      title: 'Ticket Vending Machine',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: lightTheme(),
      home: const HomePage(),
      builder: builder,
    );
  }

  Widget builder(BuildContext context, Widget? child) {
    return Align(
      child: SizedBox(
        width: 360,
        child: child,
      ),
    );
  }
}
