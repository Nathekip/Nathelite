import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nathelite/data/models/launch.model.dart';
import 'package:nathelite/data/models/rocket.model.dart';

class LaunchService {
  static const String baseUrl = "https://api.spacexdata.com/v4";
  static const String _likesKey = 'launch_likes';
  static const String _onboardingKey = 'onboarding_completed';


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
      throw Exception("Failed to get rocket data");
    }
    final Map<String, dynamic> rocketJson = json.decode(res.body);
    return Rocket.fromJson(rocketJson);
  }

  static Future<Set<String>> getLikedLaunches() async {
    final prefs = await SharedPreferences.getInstance();
    final likes = prefs.getStringList(_likesKey) ?? [];
    return likes.toSet();
  }

  static Future<bool> isLiked(String launchName) async {
    final likes = await getLikedLaunches();
    return likes.contains(launchName);
  }

  static Future<void> addLike(String launchName) async {
    final prefs = await SharedPreferences.getInstance();
    final likes = await getLikedLaunches();
    likes.add(launchName);
    await prefs.setStringList(_likesKey, likes.toList());
  }

  static Future<void> removeLike(String launchName) async {
    final prefs = await SharedPreferences.getInstance();
    final likes = await getLikedLaunches();
    likes.remove(launchName);
    await prefs.setStringList(_likesKey, likes.toList());
  }

  static Future<bool> toggleLike(String launchName) async {
    final isCurrentlyLiked = await isLiked(launchName);
    if (isCurrentlyLiked) {
      await removeLike(launchName);
      return false;
    } else {
      await addLike(launchName);
      return true;
    }
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}