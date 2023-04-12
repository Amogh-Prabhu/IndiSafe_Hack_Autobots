import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

class AudioService {
  final _audioRecorder = Record();
  RecordState recordState = RecordState.stop;

  Future<void> start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> stop() async {
    final path = await _audioRecorder.stop();
    return path;
  }

  Future<void> pause() async {
    await _audioRecorder.pause();
  }

  Future<void> resume() async {
    await _audioRecorder.resume();
  }
}
