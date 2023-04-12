import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kavach/store/storage/service.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/kavach_theme.dart';

class Audios extends StatelessWidget {
  const Audios({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: StorageService.getFiles(audio: true),
        builder: (context, snapshot) {
          List<Reference>? files = snapshot.data;
          return (files != null)
              ? ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          launchUrlString(await files[index].getDownloadURL());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 10,
                          width: size.width / 1.2,
                          decoration: BoxDecoration(
                              color: Colors.cyan[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            files[index].name,
                            style: KavachTheme.titleText(
                              size: 30,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
