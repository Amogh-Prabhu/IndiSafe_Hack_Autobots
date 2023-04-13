// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/authentication/service.dart';
import 'package:kavach/login/login.dart';
import 'package:kavach/settings/widgets/profile_menu_widget.dart';
import 'package:kavach/store/firestore/service.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../store/local_storage/service.dart';
import '../store/models/settings_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool screamCounter = false;
  bool shakeCounter = false;
  bool sendSMS = false;
  bool sendlinks = false;
  bool sendLocation = false;
  User currentUser = FirebaseAuth.instance.currentUser!;
  late SettingsModel model;

  setData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    var data = await SharedPreferenceService.getData();
    setState(() {
      model = data;
    });
    screamCounter = model.triggers.contains('scream');
    shakeCounter = model.triggers.contains('shake');
    sendSMS = model.actions.contains("sms");
    sendLocation = model.actions.contains("location");
    sendlinks = model.actions.contains("links");
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  void changeSettings() async {
    if (screamCounter) {
      if (!model.triggers.contains('scream')) {
        model.triggers.add('scream');
      }
    } else {
      model.triggers.remove('scream');
    }
    if (shakeCounter) {
      if (!model.triggers.contains('shake')) {
        model.triggers.add('shake');
      }
    } else {
      model.triggers.remove('shake');
    }

    if (sendSMS) {
      if (!model.actions.contains('sms')) {
        model.actions.add('sms');
      }
    } else {
      model.actions.remove('sms');
    }
    if (sendlinks) {
      if (!model.actions.contains('links')) {
        model.actions.add('links');
      }
    } else {
      model.actions.remove('links');
    }
    if (sendLocation) {
      if (!model.actions.contains('location')) {
        model.actions.add('location');
      }
    } else {
      model.actions.remove('location');
    }
    SharedPreferenceService.putData(model);
    await FirestoreService.addSettings(model: model);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 5, right: 16),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Kavach",
                  style: KavachTheme.titleText(
                      size: width / 10,
                      isShadow: true,
                      weight: FontWeight.w600,
                      color: KavachTheme.darkPink),
                ),
                Text(
                  "Women Safety App",
                  style: KavachTheme.subtitleText(
                      size: width / 25,
                      weight: FontWeight.bold,
                      isShadow: false),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: KavachTheme.lightGrey.withOpacity(0.2)),
                  child: Row(
                    children: [
                      Text(
                        "Triggers",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shake SOS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          activeColor: KavachTheme.redishPink,
                          activeTrackColor: KavachTheme.lightPink,
                          inactiveThumbColor: KavachTheme.darkishGrey,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: shakeCounter,
                          onChanged: (value) {
                            setState(() {
                              shakeCounter = value;
                              changeSettings();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scream SOS",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          activeColor: KavachTheme.redishPink,
                          activeTrackColor: KavachTheme.lightPink,
                          inactiveThumbColor: KavachTheme.darkishGrey,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: screamCounter,
                          onChanged: (value) {
                            setState(() {
                              screamCounter = value;
                              changeSettings();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: KavachTheme.lightGrey.withOpacity(0.2)),
                  child: Text(
                    "Actions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Send SMS',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          activeColor: KavachTheme.redishPink,
                          activeTrackColor: KavachTheme.lightPink,
                          inactiveThumbColor: KavachTheme.darkishGrey,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: sendSMS,
                          onChanged: (value) {
                            setState(() {
                              sendSMS = value;
                              changeSettings();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send Links",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          activeColor: KavachTheme.redishPink,
                          activeTrackColor: KavachTheme.lightPink,
                          inactiveThumbColor: KavachTheme.darkishGrey,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: sendlinks,
                          onChanged: (value) {
                            setState(() {
                              sendlinks = value;
                              changeSettings();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send Location",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          activeColor: KavachTheme.redishPink,
                          activeTrackColor: KavachTheme.lightPink,
                          inactiveThumbColor: KavachTheme.darkishGrey,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: sendLocation,
                          onChanged: (value) {
                            setState(() {
                              sendLocation = value;
                              changeSettings();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 15,
                  thickness: 1.5,
                ),
                ProfileMenuWidget(
                  onTap: () async {
                    Authentication.signOut().then((_) {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: Login(), withNavBar: false);
                    });
                  },
                  size: width,
                  endIcon: true,
                  title: "Logout",
                  titleColor: Colors.redAccent,
                  iconData: CupertinoIcons.power,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
