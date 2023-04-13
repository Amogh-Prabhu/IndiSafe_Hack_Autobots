// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

class HelpCard extends StatelessWidget {
  HelpCard(
      {super.key,
      required this.callback,
      required this.iconData,
      required this.subtitle,
      required this.title});
  String title;
  String subtitle;
  IconData iconData;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: KavachTheme.lightGrey.withOpacity(1)),
          color: KavachTheme.lightPink.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          iconData,
          size: width / 9,
          color: KavachTheme.lightPink,
        ),
        title: Text(
          title,
          style: KavachTheme.titleText(
              size: width / 19,
              weight: FontWeight.normal,
              color: KavachTheme.nearlyGrey),
        ),
        subtitle: Text(
          subtitle,
          style: KavachTheme.subtitleText(
              size: width / 27,
              weight: FontWeight.normal,
              color: KavachTheme.nearlyGrey),
        ),
        trailing: IconButton(
            color: KavachTheme.redishPink,
            style: KavachTheme.buttonStyle(backColor: KavachTheme.pureWhite),
            onPressed: () {
              callback();
            },
            icon: const Icon(Icons.call)),
      ),
    );
  }
}
