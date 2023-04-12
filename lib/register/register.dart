// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        foregroundColor: KavachTheme.darkishGrey,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create an account",
                  style: KavachTheme.titleText(
                      size: width / 12,
                      isShadow: true,
                      weight: FontWeight.w600,
                      color: KavachTheme.redishPink),
                ),
                Text(
                  "Sign up now, Please enter your details! ",
                  style: KavachTheme.subtitleText(
                    size: width / 25,
                    isShadow: true,
                    weight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
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
                          hint: "Enter your email",
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
                        color: KavachTheme.nearlyGrey,
                      ),
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
                                color: KavachTheme.nearlyGrey.withOpacity(0.5)),
                          ),
                          hint: "Enter your password",
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
              width: width,
              child: ElevatedButton(
                onPressed: () {},
                style: KavachTheme.buttonStyle(
                  backColor: KavachTheme.redishPink,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      17.0,
                    ),
                    child: Text(
                      "REGISTER",
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
      )),
    );
  }
}
