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
}