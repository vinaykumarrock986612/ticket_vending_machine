import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import 'svg_icon_button.dart';

const kAppBarHeight = 64.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool? alignCenter;
  final Widget? titleWidget;
  final VoidCallback? leadingOnTap;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    this.alignCenter = true,
    this.titleWidget,
    this.backgroundColor,
    this.leadingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: alignCenter,
      elevation: 1,
      titleSpacing: 0,
      leading: SvgIconButton(
        filePath: SvgAssets.backArrow,
        onTap: leadingOnTap ?? Navigator.of(context).pop,
      ),
      title: titleWidget,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kAppBarHeight);
}
