import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.size,
      required this.title,
      required this.onTap,
      this.endIcon = true,
      required this.titleColor,
      required this.iconData});

  final double size;
  final String title;
  final IconData iconData;
  final Color titleColor;
  final bool endIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 20,
      leading: Container(
        width: size / 8,
        height: size / 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 16),
            color: KavachTheme.pureWhite,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(0.1, 0.4),
                  spreadRadius: 0.3,
                  blurRadius: 2)
            ]),
        child: Center(
            child: Icon(
          iconData,
          color: KavachTheme.lightPink,
        )),
      ),
      trailing: endIcon
          ? Container(
              width: size / 11,
              height: size / 11,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 22),
                  color: KavachTheme.darkishGrey.withOpacity(0.7)),
              child: const Center(
                  child: Icon(
                CupertinoIcons.forward,
                color: KavachTheme.pureWhite,
              )),
            )
          : null,
      title: Text(title,
          style: KavachTheme.subtitleText(
              size: size / 24, weight: FontWeight.w600, color: titleColor)),
    );
  }
}
