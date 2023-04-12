import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';

class SharedPreferenceService {
  static void putData(SettingsModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', model.uid!);
    await prefs.setStringList('contact_numbers', model.contactNumbers!);
    await prefs.setStringList('triggers', model.triggers!);
    await prefs.setStringList('actions', model.actions!);
  }

  static Future<SettingsModel> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? uid = prefs.getString("uid");
    final List<String>? contactNumbers = prefs.getStringList('contact_numbers');
    final List<String>? triggers = prefs.getStringList('triggers');
    final List<String>? actions = prefs.getStringList('actions');

    return SettingsModel(
      uid: uid,
      contactNumbers: contactNumbers,
      triggers: triggers,
      actions: actions,
    );
  }
}
