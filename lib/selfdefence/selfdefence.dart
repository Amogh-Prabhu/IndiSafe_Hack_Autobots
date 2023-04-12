// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SelfDefence extends StatefulWidget {
  const SelfDefence({super.key});

  @override
  State<SelfDefence> createState() => _SelfDefenceState();
}

class _SelfDefenceState extends State<SelfDefence> {
  late YoutubePlayerController _controller;
  final List<YoutubePlayerController> _controllers = [];
  List<String> urls = [
    'https://youtu.be/T7aNSRoDCmg',
    'https://youtu.be/KVpxP3ZZtAc',
    'https://youtu.be/VIu9sCogmrs',
    'https://youtu.be/bR476k1hPNk',
    'https://youtu.be/Gx3_x6RH1J4',
    'https://youtu.be/bLB85VwjkY0',
    'https://youtu.be/kPdnSPjuucE',
    'https://youtu.be/Ww1DeUSC94o',
    'https://youtu.be/-V4vEyhWDZ0'
  ];
  @override
  void initState() {
    urls.forEach((url) {
      _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url)!);
      _controllers.add(_controller);
    });

    super.initState();
  }

  Widget buildController(int no) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: YoutubePlayer(
        controller: _controllers[no],
        actionsPadding: const EdgeInsets.all(20),
        showVideoProgressIndicator: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.lightPink),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Self Defense Techniques",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text("Self Help is the best help, learn to protect yourself",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildController(0),
                buildController(1),
                const SizedBox(height: 10.0),
                buildController(2),
                const SizedBox(height: 10.0),
                buildController(3),
                const SizedBox(height: 10.0),
                buildController(4),
                const SizedBox(height: 10.0),
                buildController(5),
                const SizedBox(height: 10.0),
                buildController(6),
                const SizedBox(height: 10.0),
                buildController(7),
                const SizedBox(height: 10.0),
                buildController(8),
                const SizedBox(height: 10.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
