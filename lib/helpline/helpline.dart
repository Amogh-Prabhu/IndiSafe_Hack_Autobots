// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kavach/helpline/widgets/help_card.dart';
import 'package:kavach/news/news.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'layout/selfdefence.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  List<String> num = [
    "100",
    "101",
    "102",
    "103",
    "108",
    "112",
    "182",
    "1073",
    "1098"
  ];
  List<String> details = [
    "Police",
    "Fire Service",
    "Pregnancy Medic",
    "Mahila Helpline Mumbai",
    "Ambulance",
    "National Helpline",
    "Railway Protection",
    "Road Accident",
    "Women Helpline"
  ];
  List<IconData> i = [
    Icons.local_police,
    Icons.fire_truck,
    Icons.child_care,
    Icons.woman,
    Icons.local_hospital,
    Icons.map,
    Icons.train,
    Icons.car_crash,
    Icons.woman_2,
  ];

  _callNumber(String n) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(n);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
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
          IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: SelfDefence(),
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            },
            icon: Icon(
              Icons.shield_outlined,
              color: KavachTheme.nearlyGrey,
              size: width / 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: News(),
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            },
            icon: Icon(
              Icons.newspaper,
              color: KavachTheme.nearlyGrey,
              size: width / 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
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
                  "Call for Help",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text("In case of an emergency call the helpline",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 40),
                itemCount: details.length,
                itemBuilder: (BuildContext context, int index) {
                  return HelpCard(
                      iconData: i[index],
                      callback: () async {
                        await _callNumber(num[index]);
                      },
                      subtitle: details[index],
                      title: num[index]);
                }),
          ),
        ],
      ),
    );
  }
}
