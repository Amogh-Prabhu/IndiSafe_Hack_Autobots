import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_model.dart';

class SharedPreferenceService {
  static void putData(SettingsModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', model.uid);
    await prefs.setStringList('contact_numbers', model.contactNumbers);
    await prefs.setStringList('triggers', model.triggers);
    await prefs.setStringList('actions', model.actions);
    await prefs.setStringList('image_urls', model.imageUrls);
    await prefs.setStringList('video_urls', model.videoUrls);
    await prefs.setStringList('audio_urld', model.audioUrls);
  }

  static Future<SettingsModel> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String uid = prefs.getString("uid")!;
    final List<String> contactNumbers = prefs.getStringList('contact_numbers')!;
    final List<String> triggers = prefs.getStringList('triggers')!;
    final List<String> actions = prefs.getStringList('actions')!;
    final List<String> imageUrls = prefs.getStringList('image_urls')!;
    final List<String> videoUrls = prefs.getStringList('video_urls')!;
    final List<String> audioUrls = prefs.getStringList('audio_urld')!;

    return SettingsModel(
        uid: uid,
        contactNumbers: contactNumbers,
        triggers: triggers,
        actions: actions,
        imageUrls: imageUrls,
        videoUrls: videoUrls,
        audioUrls: audioUrls);
  }
}
