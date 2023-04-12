// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/record/audio/audio_service.dart';
import 'package:kavach/record/audio/audios.dart';
import 'package:kavach/record/widgets/history_widget.dart';
import 'package:kavach/utils/kavach_theme.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.darkPink),
        ),
        actions: [
          Icon(
            CupertinoIcons.bell,
            color: KavachTheme.nearlyGrey,
            size: width / 16,
          ),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.menu,
            color: KavachTheme.nearlyGrey,
            size: width / 14,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Record",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text(
                    "Anonymously record your surroundings without notifying others.",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
            ),
          ),

          Column(children: [
            HistoryWidget(
                iconData: Icons.audiotrack,
                subtitle: "Tap to see history",
                title: "Audio Recording"),
            HistoryWidget(
                iconData: Icons.video_collection,
                subtitle: "Tap to see history",
                title: "Video Recording"),
          ])

          // ElevatedButton(
          //   onPressed: () async {
          //     String? url =
          //         await AudioService().captureForTime(Duration(seconds: 1));
          //   },
          //   child: Icon(Icons.mic),
          //   style: KavachTheme.buttonStyle(
          //     backColor: KavachTheme.darkPink,
          //   ),
          // ),
          // const SizedBox(height: 100),
          // Center(
          //     child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.of(context)
          //               .push(MaterialPageRoute(builder: (_) => Audios()));
          //         },
          //         child: Container(
          //           alignment: Alignment.center,
          //           height: width / 7,
          //           width: width / 1.2,
          //           decoration: BoxDecoration(
          //               color: Colors.cyan[200],
          //               borderRadius: BorderRadius.circular(30)),
          //           child: Text(
          //             "Audios",
          //             style: KavachTheme.titleText(
          //               size: 40,
          //               weight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: width / 7,
          //         width: width / 1.2,
          //         decoration: BoxDecoration(
          //             color: Colors.red[200],
          //             borderRadius: BorderRadius.circular(30)),
          //         child: Text(
          //           "Videos",
          //           style: KavachTheme.titleText(
          //             size: 40,
          //             weight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: width / 7,
          //         width: width / 1.2,
          //         decoration: BoxDecoration(
          //             color: Colors.green[200],
          //             borderRadius: BorderRadius.circular(30)),
          //         child: Text(
          //           "Images",
          //           style: KavachTheme.titleText(
          //             size: 40,
          //             weight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )),
        ],
      ),
    );
  }
}
