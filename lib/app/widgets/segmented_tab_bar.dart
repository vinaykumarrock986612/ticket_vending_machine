import 'package:flutter/material.dart';

import '../utils/app_extensions.dart';

class SegmentedTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<String> tabNames;
  final int selectedIndex;
  final void Function(int index)? onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final bool scrollable;

  const SegmentedTabBar({
    super.key,
    this.tabController,
    required this.tabNames,
    required this.selectedIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.padding,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tabBar = Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.cardBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: Theme(
        data: theme.copyWith(useMaterial3: false),
        child: TabBar(
          onTap: onTap,
          isScrollable: scrollable,
          controller: tabController,
          indicatorColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: theme.colors.background,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: const Offset(0.5, 0.5),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          tabs: [
            ...tabNames.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final tab = entry.value;

                final selectedStyle = theme.textTheme.titleMedium?.copyWith(
                  color: selectedColor ?? theme.colors.primary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                );

                final unselectedStyle = theme.textTheme.titleMedium?.copyWith(
                  color: theme.colors.tertiaryText,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                );

                return Tab(
                  height: 38,
                  child: Text(
                    tab,
                    textAlign: TextAlign.center,
                    style: index == selectedIndex ? selectedStyle : unselectedStyle,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: tabBar,
    );
  }
}
