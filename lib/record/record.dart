// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/record/audio/audio_service.dart';
import 'package:kavach/record/audio/audios.dart';
import 'package:kavach/record/widgets/history_widget.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  RecorderController controller = RecorderController();
  bool _stop = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(width / 6),
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              _stop = !_stop;
            });
            await controller.record();
            AudioService()
                .captureForTime(Duration(seconds: 5))
                .then((value) async {
              if (value != null) {
                await controller.stop();
                setState(() {
                  _stop = !_stop;
                });
              }
            });
          },
          style: KavachTheme.buttonStyle(
              backColor: !_stop ? KavachTheme.redishPink : Colors.red),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              _stop ? "Stop Recording" : "Record Audio",
              style: KavachTheme.subtitleText(
                  size: width / 25,
                  weight: FontWeight.bold,
                  color: KavachTheme.pureWhite),
            ),
          ),
        ),
      ),
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
                callback: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: Audios());
                },
                iconData: Icons.audiotrack,
                subtitle: "Tap to see history",
                title: "Audio Recording"),
            HistoryWidget(
                callback: () {},
                iconData: Icons.video_collection,
                subtitle: "Tap to see history",
                title: "Video Recording"),
          ]),
          AudioWaveforms(
            margin: EdgeInsets.only(top: 30),
            waveStyle: WaveStyle(
                waveColor: KavachTheme.lightPink,
                middleLineColor: KavachTheme.lightPink,
                middleLineThickness: 0),
            size: Size(MediaQuery.of(context).size.width, width / 3),
            recorderController: controller,
            enableGesture: true,
          ),
        ],
      ),
    );
  }
}
