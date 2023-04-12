import 'package:flutter/material.dart';
import 'package:kavach/login/layout/login_screen.dart';
import 'package:kavach/utils/kavach_theme.dart';
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Kavach",
                    style: KavachTheme.titleText(
                        size: width / 12,
                        isShadow: true,
                        weight: FontWeight.w900,
                        color: KavachTheme.darkPink),
                  ),
                  Text(
                    "Personal app",
                    style: KavachTheme.subtitleText(
                        size: width / 20,
                        weight: FontWeight.bold,
                        isShadow: true),
                  )
                ],
              ),
            ),
            SizedBox(
              height: width / 5,
            ),
            Column(
              children: [
                Text(
                  "Sign Up/Log in with email address",
                  style: KavachTheme.subtitleText(
                      size: width / 25,
                      weight: FontWeight.bold,
                      color: KavachTheme.darkishGrey.withOpacity(0.7)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width / 2.5,
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const LoginScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.scale);
                    },
                    style: KavachTheme.buttonStyle(
                      backColor: KavachTheme.redishPink,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Let's Go!",
                          style: KavachTheme.subtitleText(
                              size: width / 25,
                              weight: FontWeight.bold,
                              color: KavachTheme.pureWhite),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
