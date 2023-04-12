// ignore_for_file: avoid_function_literals_in_foreach_calls, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SelfDefence extends StatefulWidget {
  const SelfDefence({super.key});

  @override
  State<SelfDefence> createState() => _SelfDefenceState();
}

class _SelfDefenceState extends State<SelfDefence> {
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
      YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url)!);
      _controllers.add(_controller);
    });

    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  Widget buildController(int no) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: YoutubePlayer(
          controller: _controllers[no],
          actionsPadding: const EdgeInsets.all(20),
          showVideoProgressIndicator: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
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
                buildController(2),
                buildController(3),
                buildController(4),
                buildController(5),
                buildController(6),
                buildController(7),
                buildController(8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
