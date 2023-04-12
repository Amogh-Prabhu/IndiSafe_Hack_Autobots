// ignore_for_file: unnecessary_new, unused_field, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.darkishGrey,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Kavach",
                style: KavachTheme.titleText(
                    size: width / 11,
                    weight: FontWeight.bold,
                    color: KavachTheme.pureWhite),
              ),
              SizedBox(
                height: width / 4,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: width / 2.3,
                  width: width / 2.3,
                  decoration: BoxDecoration(
                      color: KavachTheme.pureWhite,
                      border: Border.all(color: Colors.greenAccent, width: 5),
                      borderRadius: BorderRadius.circular(width / 4.6)),
                  child: Text(
                    _start.toString(),
                    style: KavachTheme.titleText(
                        size: width / 5,
                        weight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "As the timer goes down, your trusted contacts will be notified about your emergency situations.",
                textAlign: TextAlign.center,
                style: KavachTheme.subtitleText(
                    size: width / 26,
                    weight: FontWeight.normal,
                    color: KavachTheme.pureWhite),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _timer.cancel();
                    });
                  },
                  style: KavachTheme.buttonStyle(backColor: Colors.redAccent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      "Cancel",
                      style: KavachTheme.subtitleText(
                          size: width / 20,
                          color: KavachTheme.pureWhite,
                          weight: FontWeight.normal),
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
