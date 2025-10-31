import 'failure.model.dart';
import 'rocket.model.dart';

class Launch {
  const Launch({
    required this.name,
    required this.details,
    required this.date,
    this.failure,
    required this.patchUrl,
    required this.articleUrl,
    required this.rocket
  });

  final String name;
  final String details;
  final DateTime date;
  final Failure? failure;
  final String patchUrl;
  final String articleUrl;
  final Rocket rocket;

  static Launch mock()=>Launch(
    name: "IWW",
    details: "Engine failure at 33 seconds and loss of vehicle",
    date: DateTime.utc(2006, 03, 25, 10, 30, 00, 12, 00),
    failure: Failure.mock(),
    patchUrl: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png",
    articleUrl: "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
    rocket: Rocket.mock(),
  );
}