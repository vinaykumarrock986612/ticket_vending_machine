import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_extensions.dart';

const _snapAnimationValue = 0.2;
const _baseScale = 1.0;
const _scaleIncrement = 0.1;

class VerticalCardSwiper extends StatefulWidget {
  final IndexedWidgetBuilder cardBuilder;
  final int cardCount;

  const VerticalCardSwiper({
    super.key,
    required this.cardBuilder,
    required this.cardCount,
  });

  @override
  State<VerticalCardSwiper> createState() => VerticalCardSwiperState();
}

class VerticalCardSwiperState extends State<VerticalCardSwiper> with TickerProviderStateMixin {
  final bodyKey = GlobalKey();

  late int foregroundCardIndex = widget.cardCount - 1;
  late final cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  late final dismissedCardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  Offset position = const Offset(0, 0);
  Offset maxOffset = const Offset(0, 0);

  int get dismissedCardCount => (widget.cardCount - 1) - foregroundCardIndex;

  int get visibleCardCount => widget.cardCount - foregroundCardIndex;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = bodyKey.currentContext?.findRenderObject() as RenderBox?;
      final globalOffset = box?.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.sizeOf(context).height;
      final dy = globalOffset?.dy ?? 0;

      maxOffset = Offset(0, screenHeight - dy);
    });
  }

  @override
  void dispose() {
    cardController.dispose();
    dismissedCardController.dispose();
    super.dispose();
  }

  void onVerticalDragUpdate(DragUpdateDetails tapInfo) {
    final newValue = cardController.value + (tapInfo.primaryDelta! / maxOffset.dy);

    if (newValue < 0 && cardController.value == 0 && dismissedCardCount > 0) {
      handleDismissedCard(tapInfo);
    } else if (dismissedCardController.value > 0) {
      handleDismissedCard(tapInfo);
    } else if (dismissedCardController.value == 0) {
      handleForegroundCard(tapInfo);
    }
  }

  void handleForegroundCard(DragUpdateDetails tapInfo) {
    if (foregroundCardIndex == 0) return;

    final newValue = cardController.value + (tapInfo.primaryDelta! / maxOffset.dy);
    cardController.value = newValue.clamp(0.0, 1.0);
  }

  void handleDismissedCard(DragUpdateDetails tapInfo) {
    final value = dismissedCardController.value + (tapInfo.primaryDelta!.invertSign / maxOffset.dy);
    dismissedCardController.value = value;
  }

  void onVerticalDragEnd(DragEndDetails details) {
    /// Foreground Card Animation
    if (cardController.value > _snapAnimationValue) {
      cardController.animateTo(1, duration: const Duration(milliseconds: 300)).then(
            (value) => completeAnimation(true),
          );
    } else {
      cardController.reverse();
      cardController.animateTo(0, duration: const Duration(milliseconds: 300)).then(
            (value) => completeAnimation(false),
          );
    }

    /// Dismissed Card Animation
    if (dismissedCardController.value > _snapAnimationValue) {
      dismissedCardController.animateTo(1, duration: const Duration(milliseconds: 300)).then(
            (value) => completeDismissedCardAnimation(true),
          );
    } else {
      dismissedCardController.reverse();
      dismissedCardController.animateTo(0, duration: const Duration(milliseconds: 300)).then(
            (value) => completeDismissedCardAnimation(false),
          );
    }
  }

  void completeAnimation(bool completed) {
    if (completed && foregroundCardIndex > 0) {
      foregroundCardIndex--;
    }
    position = const Offset(0, 0);
    cardController.reset();
  }

  void completeDismissedCardAnimation(bool completed) {
    if (completed && dismissedCardCount > 0) {
      foregroundCardIndex++;
    }
    position = const Offset(0, 0);
    dismissedCardController.reset();
  }

  Offset getCardPosition() {
    final t = cardController.value;
    final dy = lerpDouble(0, maxOffset.dy, t) ?? 0;
    return Offset(0, dy);
  }

  Offset getDismissedCardPosition() {
    final animation = CurvedAnimation(parent: dismissedCardController, curve: Curves.linearToEaseOut);
    final t = animation.value;
    final dy = lerpDouble(maxOffset.dy, 0, t) ?? 0;
    return Offset(0, dy);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([cardController, dismissedCardController]),
      builder: (context, child) {
        return Stack(
          key: bodyKey,
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            for (int index = 0; index < widget.cardCount; index++) resizedCard(context, index),
          ],
        );
      },
    );
  }

  double getCardScale(num index) {
    index += dismissedCardCount;
    index += cardController.value + dismissedCardController.value.invertSign;
    return _baseScale + (index * _scaleIncrement);
  }

  Offset getCardOffset(num index) {
    index += dismissedCardCount;
    index += cardController.value + dismissedCardController.value.invertSign;
    return Offset(0.0, index * 45);
  }

  Widget resizedCard(BuildContext context, int index) {
    Widget child = widget.cardBuilder(context, index);

    child = Transform.scale(
      scale: getCardScale(index),
      child: child,
    );

    child = Transform.translate(
      offset: getCardOffset(index),
      child: child,
    );

    if (index == foregroundCardIndex) {
      child = Transform.translate(
        offset: getCardPosition(),
        child: GestureDetector(
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onVerticalDragEnd,
          child: child,
        ),
      );
    }

    if (index == foregroundCardIndex + 1 && index < widget.cardCount) {
      child = Transform.translate(
        offset: getDismissedCardPosition(),
        child: child,
      );
    } else if (index > foregroundCardIndex) {
      child = Transform.translate(
        offset: maxOffset,
        child: child,
      );
    }

    return child;
  }
}
