// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/register/register.dart';
import 'package:kavach/app/app.dart';
import 'package:kavach/authentication/service.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: KavachTheme.subtitleText(
                size: width / 27,
                isShadow: true,
                weight: FontWeight.w500,
                color: KavachTheme.nearlyGrey,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: RegisterScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.scale,
                );
              },
              child: Text(
                "Sign-Up",
                style: KavachTheme.subtitleText(
                  size: width / 27,
                  isShadow: true,
                  weight: FontWeight.bold,
                  color: KavachTheme.lightPink,
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: KavachTheme.darkishGrey,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Kavach",
                  style: KavachTheme.titleText(
                    size: width / 8,
                    isShadow: true,
                    weight: FontWeight.w600,
                    color: KavachTheme.darkPink,
                  ),
                ),
                Text(
                  "Women Safety App",
                  style: KavachTheme.subtitleText(
                      size: width / 23,
                      weight: FontWeight.bold,
                      isShadow: false),
                ),
                SizedBox(
                  height: width / 9,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            autofocus: true,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value.trim())) {
                                return "Email is not valid";
                              }
                              return null;
                            },
                            cursorColor: KavachTheme.lightPink,
                            style: KavachTheme.subtitleText(
                                size: width / 24,
                                weight: FontWeight.normal,
                                color: KavachTheme.nearlyGrey),
                            decoration: KavachTheme.waInputDecoration(
                                hint: "Email",
                                fontSize: width / 24,
                                prefixIcon: CupertinoIcons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              }
                              return null;
                            },
                            obscureText: obscureText,
                            cursorColor: KavachTheme.lightPink,
                            style: KavachTheme.subtitleText(
                                size: width / 24,
                                weight: FontWeight.normal,
                                color: KavachTheme.nearlyGrey),
                            decoration: KavachTheme.waInputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: KavachTheme.nearlyGrey
                                          .withOpacity(0.5)),
                                ),
                                hint: "Password",
                                fontSize: width / 24,
                                prefixIcon: Icons.fingerprint),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await Authentication.singnInWithEmail(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context)) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return const App();
                        }));
                      }
                    },
                    style: KavachTheme.buttonStyle(
                        backColor: KavachTheme.redishPink),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "LOGIN",
                          style: KavachTheme.subtitleText(
                              size: width / 24,
                              weight: FontWeight.bold,
                              color: KavachTheme.pureWhite),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
