class SettingsModel {
  int uid;
  List<num> contactNumbers;
  List<String> triggers;
  List<String> actions;
  List<String> imageUrls;
  List<String> videoUrls;
  List<String> audioUrls;

  SettingsModel({
    required this.uid,
    required this.contactNumbers,
    required this.triggers,
    required this.actions,
    required this.imageUrls,
    required this.videoUrls,
    required this.audioUrls,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      uid: json['uid'],
      contactNumbers: json['contactNumbers'],
      triggers: json['triggers'],
      actions: json['actions'],
      imageUrls: json['imageUrls'],
      videoUrls: json['videoUrls'],
      audioUrls: json['audioUrls'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "contact_numbers": contactNumbers,
      "triggers": triggers,
      "actions": actions,
      "image_urls": imageUrls,
      "video_urls": videoUrls,
      "audio_urld": audioUrls,
    };
  }
}
