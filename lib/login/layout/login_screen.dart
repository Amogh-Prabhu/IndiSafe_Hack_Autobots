// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 12,
              isShadow: true,
              weight: FontWeight.w900,
              color: KavachTheme.darkPink),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Sign In",
                    style: KavachTheme.subtitleText(
                        size: width / 22,
                        weight: FontWeight.w900,
                        color: KavachTheme.darkishGrey.withOpacity(0.6)),
                  ),
                ),
                Form(
                  key: _formKey,
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
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: width / 2.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: KavachTheme.buttonStyle(
                      backColor: KavachTheme.redishPink,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Submit",
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
            ),
          ),
        ),
      ),
    );
  }
}
