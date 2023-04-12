import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> uploadFile({
    required File file,
    bool audio = false,
    bool video = false,
    bool image = false,
  }) async {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final String uid = auth.currentUser!.uid;
    String uid = "Test";

    final Reference rootRef = FirebaseStorage.instance.ref();
    if (image) {
      final Reference imagesRef = rootRef.child("UserFiles/$uid/images");
      imagesRef.putFile(file);
      return imagesRef.getDownloadURL();
    } else if (video) {
      final Reference videoRef = rootRef.child("UserFiles/$uid/videos");
      videoRef.putFile(file);
      return videoRef.getDownloadURL();
    } else {
      final Reference audioRef = rootRef.child("UserFiles/$uid/audios");
      audioRef.putFile(file);
      return audioRef.getDownloadURL();
    }
  }

  static Future<List<String>> getFiles({
    required bool audio,
    required bool video,
    required bool image,
  }) async {
    final Reference rootRef = FirebaseStorage.instance.ref();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;

    if (image) {
      final Reference imagesRef = rootRef.child("UserFiles/$uid/videos");
      return _getListFromReference(imagesRef);
    } else if (video) {
      final Reference videoRef = rootRef.child("UserFiles/$uid/videos");
      return _getListFromReference(videoRef);
    } else {
      final Reference audioRef = rootRef.child("UserFiles/$uid/videos");
      return _getListFromReference(audioRef);
    }
  }

  static Future<List<String>> _getListFromReference(Reference reference) async {
    ListResult listResult = await reference.list();
    List<String> list = [];
    for (Reference ref in listResult.items) {
      list.add(await ref.getDownloadURL());
    }
    return list;
  }
}
