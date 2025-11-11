import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nathelite/data/models/launch.model.dart';
import 'package:nathelite/data/models/rocket.model.dart';

class LaunchService {
  static const String baseUrl = "https://api.spacexdata.com/v4";

  static Future<List<Launch>> getLaunches() async {
    final res = await http.get(Uri.parse('$baseUrl/launches'));
    if (res.statusCode != 200) {
      throw Exception('Failed to get launch data ${res.statusCode}');
    }
    final List<dynamic> launchesJson = json.decode(res.body);
    final launches = await Future.wait(
        launchesJson.map((json) => Launch.fromJsonAsync(json))
      );
    return launches;
  }

  static Future<Rocket> getRocketById(String id) async {
    final res = await http.get(Uri.parse('$baseUrl/rockets/$id'));
    if (res.statusCode != 200) {
      throw new Exception("Failed to get rocket data");
    }
    final Map<String, dynamic> rocketJson = json.decode(res.body);
    return Rocket.fromJson(rocketJson);
  }
}