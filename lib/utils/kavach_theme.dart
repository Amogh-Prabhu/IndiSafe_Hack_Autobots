import 'package:flutter/material.dart';

class KavachTheme {
  static const Color lightPink = Color(0xffF06CAB);
  static const Color darkPink = Color(0xffDB2B7A);
  static const Color redishPink = Color(0xff530F40);
  static const Color nearlyGrey = Color(0xff5A616B);
  static const Color lightGrey = Color(0xffB8B8B8);
  static const Color pureWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color darkishGrey = Color(0xff161616);

  static TextStyle subtitleText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = darkishGrey,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return TextStyle(
        fontFamily: "NotoSans",
        fontSize: size,
        fontWeight: weight,
        wordSpacing: 1.4,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static TextStyle titleText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = darkishGrey,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return TextStyle(
        fontFamily: "MerriWeather",
        fontSize: size,
        fontWeight: weight,
        wordSpacing: 1.4,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static InputDecoration waInputDecoration(
      {IconData? prefixIcon,
      String? hint,
      Widget? suffixIcon,
      Color? bgColor,
      double fontSize = 20,
      Color? borderColor,
      EdgeInsets? padding}) {
    return InputDecoration(
      contentPadding:
          padding ?? const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      counter: const Offstage(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: lightPink)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor ?? redishPink, width: 2)),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
      ),
      fillColor: bgColor ?? Colors.grey.withOpacity(0.01),
      hintText: hint,
      suffixIcon: suffixIcon,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: redishPink) : null,
      hintStyle: subtitleText(
          size: fontSize, weight: FontWeight.normal, color: Colors.grey),
      filled: true,
    );
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 10,
      FontWeight weight = FontWeight.bold,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        elevation: 10,
        textStyle:
            subtitleText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor)));
  }
}
