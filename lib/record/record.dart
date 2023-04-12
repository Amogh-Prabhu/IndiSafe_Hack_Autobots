import 'package:flutter/material.dart';
import 'package:kavach/record/audio/audio_service.dart';
import 'package:kavach/record/audio/audios.dart';
import 'package:kavach/utils/kavach_theme.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              String? url =
                  await AudioService().captureForTime(Duration(seconds: 1));
            },
            child: Icon(Icons.mic),
            style: KavachTheme.buttonStyle(
              backColor: KavachTheme.darkPink,
            ),
          ),
          SizedBox(height: 100),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Audios()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 7,
                    width: size.width / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.cyan[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Audios",
                      style: KavachTheme.titleText(
                        size: 40,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 7,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Videos",
                    style: KavachTheme.titleText(
                      size: 40,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 7,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Images",
                    style: KavachTheme.titleText(
                      size: 40,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
