import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_strings.dart';
import '../../../models/passenger_details.dart';
import '../../../utils/app_extensions.dart';
import '../../../widgets/base_widgets.dart';
import '../../../widgets/dotted_line.dart';
import '../../../widgets/gap.dart';
import '../../../widgets/ticket_shape_card.dart';

class TravelReceipt extends StatefulWidget {
  final PassengerDetails passenger;

  const TravelReceipt({
    super.key,
    required this.passenger,
  });

  @override
  State<TravelReceipt> createState() => _TravelReceiptState();
}

class _TravelReceiptState extends BaseState<TravelReceipt> {
  late final passenger = widget.passenger;

  final dateFormat = 'MMM dd';
  final timeFormat = 'hh:dd';

  double get width => screenWidth - 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        travelRoute(),
        const VerticalGap(gap: 18),
        TicketShapeCard(
          height: 300,
          width: width,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    passengerDetails(),
                    const VerticalGap(gap: 10),
                    ticketDetails(),
                  ],
                ),
              ),
              DottedLine(
                dashColor: theme.colors.border,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    AppImages.barcode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget travelRoute() {
    return Container(
      width: screenWidth - 90,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// From
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(passenger.departureDate.format(dateFormat)),
              valueWidget(passenger.departureDate.format(timeFormat)),
              valueWidget(passenger.from, color: theme.colors.tertiaryText),
            ],
          ),

          /// From
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              labelWidget(passenger.arrivalDate.format(dateFormat)),
              valueWidget(passenger.arrivalDate.format(timeFormat)),
              valueWidget(passenger.to, color: theme.colors.tertiaryText),
            ],
          ),
        ],
      ),
    );
  }

  Widget passengerDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Passenger Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(AppStrings.passenger),
              valueWidget(passenger.name),
            ],
          ),

          /// Seat
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(AppStrings.seat),
              valueWidget(passenger.seatNumber, color: theme.colors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget ticketDetails() {
    return Container(
      padding: const EdgeInsets.all(14),
      color: theme.colors.secondaryBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Terminal
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(AppStrings.terminal),
              valueWidget(passenger.terminal),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(AppStrings.gate),
              valueWidget(passenger.gate),
            ],
          ),

          /// Bus Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget(AppStrings.busNumber),
              valueWidget(passenger.busNumber),
            ],
          ),
        ],
      ),
    );
  }

  Widget labelWidget(String text) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colors.tertiaryText,
      ),
    );
  }

  Widget valueWidget(String text, {Color? color}) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: color ?? theme.colors.primaryText,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
