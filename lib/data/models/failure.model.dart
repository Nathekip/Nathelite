class Failure {
  const Failure({
    required this.time,
    this.altitude,
    required this.reason,
  });

  final int time;
  final int? altitude;
  final String reason;

  static Failure mock()=>Failure(
    time: 301,
    altitude: 289,
    reason: "harmonic oscillation leading to premature engine shutdown",
  );
}