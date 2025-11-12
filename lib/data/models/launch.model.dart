import 'failure.model.dart';
import 'rocket.model.dart';
import 'package:nathelite/ui/data/api/launch.service.dart';

class Launch {
  const Launch({
    required this.name,
    required this.details,
    required this.date,
    this.failure,
    required this.patchUrl,
    required this.articleUrl,
    required this.rocket,
    this.isLiked = false,
  });

  final String name;
  final String details;
  final DateTime date;
  final Failure? failure;
  final String patchUrl;
  final String articleUrl;
  final Rocket rocket;
  final bool isLiked;

  Launch copyWith({bool? isLiked}) {
    return Launch(
      name: name,
      details: details,
      date: date,
      failure: failure,
      patchUrl: patchUrl,
      articleUrl: articleUrl,
      rocket: rocket,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  static List<Launch> mocks() => List<Launch>.generate(
    50,
        (int index) => mock(),
  );

  static Launch mock() => Launch(
    name: "IWW",
    details: "Engine failure at 33 seconds and loss of vehicle",
    date: DateTime.utc(2006, 03, 25, 10, 30, 00, 12, 00),
    failure: Failure.mock(),
    patchUrl: "https://images2.imgbox.com/5b/02/QcxHUb5V_o.png",
    articleUrl:
    "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
    rocket: Rocket.mock(),
  );

  factory Launch.fromJson(Map<String, dynamic> json, Rocket rocket) {
    final failuresJson = json['failures'] as List?;
    final failures = (failuresJson != null && failuresJson.isNotEmpty)
        ? failuresJson.map((f) => Failure.fromJson(f)).toList()
        : [];

    return Launch(
      name: json["name"],
      details: json["details"] ?? 'No details',
      date: DateTime.parse(json['date_utc']),
      failure: failures.isNotEmpty ? failures.first : null,
      patchUrl: json['links']['patch']['small'] ?? '',
      articleUrl: json['links']['article'] ?? '',
      rocket: rocket,
    );
  }

  static Future<Launch> fromJsonAsync(Map<String, dynamic> json) async {
    Rocket rocket;

    final rocketId = json["rocket"];
    print('Fetching rocket: ${json["rocket"]}');
    if (rocketId == null || rocketId.isEmpty) {
      rocket = Rocket.mock();
    } else {
      rocket = await LaunchService.getRocketById(rocketId);
    }

    return Launch.fromJson(json, rocket);
  }
}