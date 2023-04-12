import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: KavachTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: KavachTheme.darkishGrey,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.darkPink),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add Friend",
                      style: KavachTheme.subtitleText(
                          size: width / 20,
                          weight: FontWeight.bold,
                          color: KavachTheme.nearlyGrey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Icon(
                      CupertinoIcons.person_3,
                      size: width / 2.4,
                      color: KavachTheme.lightPink,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: width / 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Make this person my SOS contact",
                              style: KavachTheme.subtitleText(
                                  size: width / 28,
                                  weight: FontWeight.normal,
                                  color: KavachTheme.nearlyGrey),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: KavachTheme.nearlyGrey.withOpacity(0.2),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.person_2,
                                      size: width / 14,
                                      color: KavachTheme.lightPink,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Who is a friend?",
                                      style: KavachTheme.subtitleText(
                                          size: width / 30,
                                          weight: FontWeight.bold,
                                          color: KavachTheme.darkPink),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Friend is someone who receives your live location when you use thr Track Me feature.",
                                  style: KavachTheme.subtitleText(
                                      size: width / 30,
                                      weight: FontWeight.normal,
                                      color: KavachTheme.nearlyGrey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sos_outlined,
                                      size: width / 14,
                                      color: KavachTheme.lightPink,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Who is a friend?",
                                      style: KavachTheme.subtitleText(
                                          size: width / 30,
                                          weight: FontWeight.bold,
                                          color: KavachTheme.darkPink),
                                    ),
                                  ],
                                ),
                                Text(
                                  "An SOS contact receives your SOS alerts during an emergency",
                                  style: KavachTheme.subtitleText(
                                      size: width / 30,
                                      weight: FontWeight.normal,
                                      color: KavachTheme.nearlyGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
