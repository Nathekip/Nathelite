class Failure {
  const Failure({
    required this.time,
    this.altitude,
    required this.reason,
  });

  final int time;
  final int? altitude;
  final String reason;
}