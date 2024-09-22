class PassengerDetails {
  final String from;
  final String to;
  final String name;
  final String amount;
  final String passengerCount;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String seatNumber;
  final String terminal;
  final String gate;
  final String busNumber;

  const PassengerDetails({
    required this.from,
    required this.to,
    required this.name,
    required this.amount,
    required this.passengerCount,
    required this.departureDate,
    required this.arrivalDate,
    required this.seatNumber,
    required this.terminal,
    required this.gate,
    required this.busNumber,
  });
}
