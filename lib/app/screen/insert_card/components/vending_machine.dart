import 'package:flutter/material.dart';

import '../../../utils/app_extensions.dart';
import '../../../widgets/base_widgets.dart';
import '../../../widgets/gap.dart';
import 'display_frame.dart';

class VendingMachine extends StatefulWidget {
  const VendingMachine({super.key});

  @override
  State<VendingMachine> createState() => VendingMachineState();
}

class VendingMachineState extends BaseState<VendingMachine> {
  final _cardSlotKey = GlobalKey();
  final _receiptSlotKey = GlobalKey();
  double? cardSlotWidth;
  double? receiptSlotWidth;

  Offset? get cardSlotOffset {
    final box = _cardSlotKey.currentContext?.findRenderObject() as RenderBox?;
    cardSlotWidth = box?.size.width;
    return box?.localToGlobal(Offset.zero);
  }

  Offset? get receiptSlotOffset {
    final box = _receiptSlotKey.currentContext?.findRenderObject() as RenderBox?;
    receiptSlotWidth = box?.size.width;
    return box?.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth - 80;
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 490,
      width: width,
      decoration: BoxDecoration(
        color: theme.colors.machineColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const VerticalGap(gap: 25),
          machineDisplay(),
          const VerticalGap(gap: 25),
          machineControls(),
          const VerticalGap(gap: 25),
          Expanded(child: machineStorage()),
          const VerticalGap(gap: 45),
        ],
      ),
    );
  }

  Widget machineDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: DisplayFrame(
        height: 165,
        child: Container(
          color: theme.colors.greenScreen,
          alignment: Alignment.center,
          child: const Text("Insert Card"),
        ),
      ),
    );
  }

  Widget machineControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chipSlot(),
          const HorizontalGap(gap: 12),
          insertCardSlot(),
          const Spacer(),
          dummySlot(),
          const HorizontalGap(gap: 12),
          dummySlot(),
        ],
      ),
    );
  }

  Widget chipSlot() {
    return Container(
      height: 30,
      width: 20,
      decoration: BoxDecoration(color: const Color(0xff848484), borderRadius: BorderRadius.circular(2)),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(2.5, 8, 2.5, 2.5),
        decoration: BoxDecoration(color: const Color(0xffABABAB), borderRadius: BorderRadius.circular(2)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(2, 6, 2, 2),
          decoration: BoxDecoration(color: const Color(0xffEBBD45), borderRadius: BorderRadius.circular(2)),
        ),
      ),
    );
  }

  Widget insertCardSlot() {
    return SizedBox(
      height: 25,
      width: 70,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.5),
            decoration: BoxDecoration(
              color: const Color(0xff7E7E7E),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            height: 4,
            margin: const EdgeInsets.fromLTRB(13, 12, 13, 0),
            decoration: BoxDecoration(
              color: const Color(0xff444444),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              key: _cardSlotKey,
            ),
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xffC9C9C9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dummySlot() {
    return Container(
      height: 10,
      width: 35,
      decoration: BoxDecoration(
        color: const Color(0xff7E7E7E),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 3.5),
        decoration: BoxDecoration(
          color: const Color(0xff444444),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget machineStorage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: const Color(0xff3D3D3D),
      child: Align(
        alignment: Alignment.topRight,
        child: receiptSlot(),
      ),
    );
  }

  Widget receiptSlot() {
    return SizedBox(
      height: 25,
      width: 70,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.5),
            decoration: BoxDecoration(
              color: const Color(0xff7E7E7E),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            height: 4,
            margin: const EdgeInsets.fromLTRB(13, 12, 13, 0),
            decoration: BoxDecoration(
              color: const Color(0xff444444),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              key: _receiptSlotKey,
            ),
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xffC9C9C9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}