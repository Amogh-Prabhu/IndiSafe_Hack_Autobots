import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final Reference rootRef = FirebaseStorage.instance.ref();

  static Future<String> uploadFile({
    required File file,
    required bool audio,
    required bool video,
    required bool image,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;

    if (image) {
      final Reference imagesRef = rootRef.child("UserFile/$uid/images");
      imagesRef.putFile(file);
      return imagesRef.getDownloadURL();
    } else if (video) {
      final Reference videoRef = rootRef.child("UserFile/$uid/videos");
      videoRef.putFile(file);
      return videoRef.getDownloadURL();
    } else {
      final Reference audioRef = rootRef.child("UserFile/$uid/audios");
      audioRef.putFile(file);
      return audioRef.getDownloadURL();
    }
  }

  static Future<List<String>> getFiles({
    required bool audio,
    required bool video,
    required bool image,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;

    if (image) {
      final Reference imagesRef = rootRef.child("UserFile/$uid/videos");
      return _getListFromReference(imagesRef);
    } else if (video) {
      final Reference videoRef = rootRef.child("UserFile/$uid/videos");
      return _getListFromReference(videoRef);
    } else {
      final Reference audioRef = rootRef.child("UserFile/$uid/videos");
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
