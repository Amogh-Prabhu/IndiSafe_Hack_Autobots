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
  Icon iconData;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: KavachTheme.lightGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: iconData,
        title: Text(
          title,
          style: KavachTheme.titleText(
              size: width / 22,
              weight: FontWeight.normal,
              color: KavachTheme.nearlyGrey),
        ),
        subtitle: Text(
          subtitle,
          style: KavachTheme.subtitleText(
              size: width / 29,
              weight: FontWeight.normal,
              color: KavachTheme.nearlyGrey),
        ),
        trailing: IconButton(
            onPressed: () {
              callback();
            },
            icon: const Icon(Icons.call)),
      ),
    );
  }
}
