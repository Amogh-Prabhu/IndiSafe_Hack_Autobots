class SettingsModel {
  String uid;
  List<String> contactNumbers;
  List<String> triggers;
  List<String> actions;

  SettingsModel({
    required this.uid,
    required this.contactNumbers,
    required this.triggers,
    required this.actions,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      uid: json['uid'],
      contactNumbers: json['contact_numbers'],
      triggers: json['triggers'],
      actions: json['actions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "contact_numbers": contactNumbers,
      "triggers": triggers,
      "actions": actions,
    };
  }
}
