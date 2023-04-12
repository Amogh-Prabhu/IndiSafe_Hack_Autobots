// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kavach/utils/kavach_theme.dart';

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
  User currentUser = FirebaseAuth.instance.currentUser!;

  late SettingsModel model;

  setData() async {
    var data = await SharedPreferenceService.getData();
    setState(() {
      model = data;
    });
    if (model.triggers != null) {
      screamCounter = model.triggers!.contains('scream');
      shakeCounter = model.triggers!.contains('shake');
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: 60,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                currentUser.email!,
                style:
                    KavachTheme.subtitleText(size: 20, weight: FontWeight.w400),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
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
                            screamCounter = value;
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: KavachTheme.darkPink,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  if (screamCounter) {
                    if (!model.triggers!.contains('scream')) {
                      model.triggers!.add('scream');
                    }
                  } else {
                    model.triggers!.remove('scream');
                  }
                  if (shakeCounter) {
                    if (!model.triggers!.contains('shake')) {
                      model.triggers!.add('shake');
                    }
                  } else {
                    model.triggers!.remove('shake');
                  }
                  SharedPreferenceService.putData(model);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
