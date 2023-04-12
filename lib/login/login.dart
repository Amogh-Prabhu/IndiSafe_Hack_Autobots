import 'package:flutter/material.dart';
import 'package:kavach/login/layout/login_screen.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          width: width / 2.4,
          height: width / 6,
          child: ElevatedButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const LoginScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            },
            style: KavachTheme.buttonStyle(
              backColor: KavachTheme.redishPink,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Get Started",
                  style: KavachTheme.subtitleText(
                      size: width / 21,
                      weight: FontWeight.bold,
                      color: KavachTheme.pureWhite),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: width / 1.1,
            width: width,
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: KavachTheme.redishPink,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(width / 2.6),
                    bottomLeft: Radius.circular(width / 2.6))),
            child: Lottie.asset("assets/gifs/flowers.json",
                height: width / 4, width: width / 4),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Kavach",
                  style: KavachTheme.titleText(
                      size: width / 8,
                      isShadow: true,
                      weight: FontWeight.w600,
                      color: KavachTheme.darkPink),
                ),
                Text(
                  "Women Safety App",
                  style: KavachTheme.subtitleText(
                      size: width / 23,
                      weight: FontWeight.bold,
                      isShadow: false),
                ),
                SizedBox(
                  height: width / 2.5,
                ),
                Text(
                  "Sign-Up/Login-In using email-address",
                  style: KavachTheme.titleText(
                    size: width / 23,
                    weight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
