import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_extensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const AppTextField({
    super.key,
    this.controller,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: theme.colors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.transparent,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        textAlign: TextAlign.center,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 17,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          counter: const SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
