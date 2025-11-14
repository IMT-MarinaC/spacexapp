import 'package:shared_preferences/shared_preferences.dart';

class RocketDetailOnboardingService {
  static const key = 'rocket_detail_onboarding_done';

  static Future<bool> isDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }
}
