import 'package:background_sms/background_sms.dart';

class SmsService {
  static String draftMessage(
      {String? videoURL,
      String? audioURL,
      String? imageURL,
      String? liveLocation}) {
    StringBuffer message =
        StringBuffer("It seems that your friend is in danger.");
    if (liveLocation != null) {
      message.write("This is her live location: $liveLocation");
    }
    if (videoURL != null) {
      message.write("Video link: $videoURL");
    }
    if (audioURL != null) {
      message.write("Audio link: $audioURL");
    }
    if (imageURL != null) {
      message.write("Image link: $imageURL");
    }
    return message.toString();
  }

  static Future<void> sendMessage(String message, List<String> numbers) async {
    for (String num in numbers) {
      var x =
          await BackgroundSms.sendMessage(phoneNumber: num, message: message);
      print(x);
    }
  }
}
