import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kavach/store/storage/service.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/kavach_theme.dart';

class Audios extends StatefulWidget {
  const Audios({super.key});

  @override
  State<Audios> createState() => _AudiosState();
}

class _AudiosState extends State<Audios> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: KavachTheme.darkishGrey,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Records",
              style: KavachTheme.titleText(
                  size: width / 18, weight: FontWeight.w600),
            ),
            Text(
              "History of the recorded events",
              style: KavachTheme.subtitleText(
                  size: width / 30, weight: FontWeight.normal),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: StorageService.getFiles(audio: true),
        builder: (context, snapshot) {
          List<Reference>? files = snapshot.data;
          return (files != null)
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 40),
                  itemCount: files.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () async {
                        launchUrlString(await files[index].getDownloadURL());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: width / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: KavachTheme.lightGrey.withOpacity(0.5))),
                        child: Row(
                          children: [
                            Icon(
                              Icons.audio_file_outlined,
                              size: width / 8,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recorded on",
                                  style: KavachTheme.titleText(
                                      size: width / 22,
                                      weight: FontWeight.bold),
                                ),
                                Text(
                                  files[index].name,
                                  style: KavachTheme.subtitleText(
                                      size: width / 30,
                                      weight: FontWeight.normal),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: width / 15,
                        width: width / 15,
                        child: const CircularProgressIndicator(
                            strokeWidth: 3, color: KavachTheme.darkPink),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text("Rolling In",
                            style: KavachTheme.titleText(
                                size: width / 18,
                                color: KavachTheme.nearlyGrey,
                                weight: FontWeight.bold)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("Fetching Location Details!",
                            style: KavachTheme.titleText(
                                size: width / 25,
                                color: KavachTheme.nearlyGrey.withOpacity(0.8),
                                weight: FontWeight.w500)),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
