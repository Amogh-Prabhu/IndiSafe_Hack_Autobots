import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kavach/record/audio/audio_service.dart';
import 'package:kavach/store/storage/service.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({super.key});

  @override
  State<AudioRecordPage> createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  bool _isRecording = false;
  late AudioService audioService;
  @override
  void initState() {
    audioService = AudioService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            _isRecording = true;
            await audioService.start();
            setState(() {});
            Future.delayed(const Duration(seconds: 5)).then((_) async {
              _isRecording = false;
              String? path = await audioService.stop();
              if (path != null) {
                String url = await StorageService.uploadFile(
                  file: File(path),
                  audio: true,
                );
              }
              setState(() {});
            });
          },
          child: !_isRecording
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
