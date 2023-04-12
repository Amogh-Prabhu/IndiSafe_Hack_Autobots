import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class StorageService {
  static Future<String?> uploadFile({
    required File file,
    bool audio = false,
    bool video = false,
    bool image = false,
  }) async {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final String uid = auth.currentUser!.uid;
    String uid = "Test";
    String date = DateFormat("d-m-y k:m:s").format(DateTime.now());

    final Reference rootRef = FirebaseStorage.instance.ref();
    try {
      if (image) {
        final Reference imagesRef =
            rootRef.child("UserFiles/$uid/images/$date");
        await imagesRef.putFile(file);
        return await imagesRef.getDownloadURL();
      } else if (video) {
        final Reference videoRef = rootRef.child("UserFiles/$uid/videos/$date");
        await videoRef.putFile(file);
        return await videoRef.getDownloadURL();
      } else {
        final Reference audioRef = rootRef.child("UserFiles/$uid/audios/$date");
        await audioRef.putFile(file);
        return await audioRef.getDownloadURL();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Reference>> getFiles({
    bool audio = false,
    bool video = false,
    bool image = false,
  }) async {
    final Reference rootRef = FirebaseStorage.instance.ref();
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final String uid = auth.currentUser!.uid;
    String uid = "Test";

    if (image) {
      final Reference imagesRef = rootRef.child("UserFiles/$uid/images");
      return _getListFromReference(imagesRef);
    } else if (video) {
      final Reference videoRef = rootRef.child("UserFiles/$uid/videos");
      return _getListFromReference(videoRef);
    } else {
      final Reference audioRef = rootRef.child("UserFiles/$uid/audios/");
      return _getListFromReference(audioRef);
    }
  }

  static Future<List<Reference>> _getListFromReference(
      Reference reference) async {
    ListResult listResult = await reference.list();
    return listResult.items;
  }
}
