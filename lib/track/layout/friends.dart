// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable, unused_import, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/store/firestore/service.dart';
import 'package:kavach/store/local_storage/service.dart';
import 'package:kavach/store/models/settings_model.dart';
import 'package:kavach/utils/kavach_theme.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  User currentUser = FirebaseAuth.instance.currentUser!;
  late SettingsModel model;
  List<String> contactNumbers = [];

  Future<void> changeSettings({required String phone}) async {
    model.contactNumbers.add(phone);
    SharedPreferenceService.putData(model);
    await FirestoreService.addSettings(model: model);
  }

  void setData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    SettingsModel data = await SharedPreferenceService.getData();
    setState(() {
      model = data;
    });
    print(model.toJson());
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: KavachTheme.pureWhite,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              if (_formKey.currentState!.validate()) {
                changeSettings(phone: _emailController.text).then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pop(context);
                });
              }
            },
            style: KavachTheme.buttonStyle(backColor: KavachTheme.redishPink),
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: SizedBox(
                      height: width / 15,
                      width: width / 15,
                      child: const CircularProgressIndicator(
                          strokeWidth: 3, color: KavachTheme.pureWhite),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Add Friend",
                      style: KavachTheme.subtitleText(
                          size: width / 23,
                          weight: FontWeight.normal,
                          color: KavachTheme.pureWhite),
                    ),
                  )),
      ),
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
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          width: width,
                          child: TextFormField(
                            autofocus: true,
                            controller: _emailController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please phone number";
                              } else if (value.length != 10) {
                                return "Phone number must be of 10 digit";
                              }
                              return null;
                            },
                            cursorColor: KavachTheme.lightPink,
                            style: KavachTheme.subtitleText(
                                size: width / 24,
                                weight: FontWeight.normal,
                                color: KavachTheme.nearlyGrey),
                            decoration: KavachTheme.waInputDecoration(
                                hint: "Phone number",
                                fontSize: width / 24,
                                prefixIcon: CupertinoIcons.person),
                          ),
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
                                  "Friend is someone who receives your live location when you use the Track Me feature.",
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
                                      "Who is an SOS contact?",
                                      style: KavachTheme.subtitleText(
                                          size: width / 30,
                                          weight: FontWeight.bold,
                                          color: KavachTheme.darkPink),
                                    ),
                                  ],
                                ),
                                Text(
                                  "An SOS contact receives your SOS alerts during an emergency.",
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
