// ignore_for_file: prefer_const_constructors, must_be_immutable, unnecessary_null_comparison, avoid_print, avoid_unnecessary_containers

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavach/helpline/layout/selfdefence.dart';
import 'package:kavach/store/local_storage/service.dart';
import 'package:kavach/store/models/settings_model.dart';
import 'package:kavach/news/news.dart';
import 'package:kavach/track/layout/friends.dart';
import 'package:kavach/track/service/location_service.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Track extends StatefulWidget {
  Track({super.key, required this.position});
  Position? position;
  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationService service = LocationService();
  late CameraPosition _currentPosition;
  User currentUser = FirebaseAuth.instance.currentUser!;
  late SettingsModel model;
  List<String> contactNumbers = [];
  List<bool> selectors = [];

  Future<void> getData() async {
    var data = await SharedPreferenceService.getData();
    setState(() {
      model = data;
      for (int i = 0; i < model.contactNumbers.length; i++) {
        selectors.add(false);
      }
    });
  }

  @override
  void initState() {
    if (widget.position != null) {
      _currentPosition = CameraPosition(
        target: LatLng(widget.position!.latitude, widget.position!.longitude),
        zoom: 18,
      );
    } else {
      _currentPosition = CameraPosition(
        target: LatLng(0, 0),
        zoom: 18,
      );
    }

    super.initState();
  }

  void bringBottomSheet(double width) async {
    getData();
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: KavachTheme.pureWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: width * 1.6,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Container(
                    width: width / 4,
                    margin: EdgeInsets.only(bottom: 20),
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Text(
                    "Select friends & share your live location",
                    style: KavachTheme.subtitleText(
                        size: width / 24, weight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tap to select",
                    style: KavachTheme.subtitleText(
                        size: width / 24,
                        weight: FontWeight.bold,
                        color: KavachTheme.lightGrey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CupertinoSearchTextField(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "All Contacts",
                      style: KavachTheme.subtitleText(
                          size: width / 26,
                          weight: FontWeight.bold,
                          color: KavachTheme.lightGrey),
                    ),
                  ),
                  SizedBox(
                    height: width,
                    child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: KavachTheme.lightGrey,
                          );
                        },
                        itemCount: model.contactNumbers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "+91",
                                      style: KavachTheme.titleText(
                                          size: width / 24,
                                          weight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      model.contactNumbers[index],
                                      style: KavachTheme.subtitleText(
                                          size: width / 24,
                                          weight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Checkbox(
                                  side:
                                      BorderSide(color: KavachTheme.lightGrey),
                                  value: selectors[index],
                                  onChanged: (x) {
                                    setState(() {
                                      selectors[index] = !selectors[index];
                                    });
                                  },
                                ), //Checkbox
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: KavachTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Kavach",
          style: KavachTheme.titleText(
              size: width / 13,
              weight: FontWeight.w600,
              color: KavachTheme.darkPink),
        ),
        actions: [
          IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: SelfDefence(),
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            },
            icon: Icon(
              Icons.shield_outlined,
              color: KavachTheme.nearlyGrey,
              size: width / 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: News(),
                  pageTransitionAnimation: PageTransitionAnimation.scale);
            },
            icon: Icon(
              Icons.newspaper,
              color: KavachTheme.nearlyGrey,
              size: width / 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Track Me",
                  style: KavachTheme.titleText(
                      size: width / 18,
                      weight: FontWeight.normal,
                      color: KavachTheme.nearlyGrey),
                ),
                Text("Share live location with your friends",
                    style: KavachTheme.subtitleText(
                        size: width / 28,
                        weight: FontWeight.normal,
                        color: KavachTheme.nearlyGrey.withOpacity(0.7)))
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: _currentPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                    bottom: width / 6,
                    child: SizedBox(
                      width: width / 2.5,
                      height: width / 9,
                      child: ElevatedButton(
                          style: KavachTheme.buttonStyle(
                              backColor: KavachTheme.lightPink),
                          onPressed: () async {
                            bringBottomSheet(width);
                          },
                          child: Text(
                            "Track Me",
                            style: KavachTheme.titleText(
                                size: width / 22,
                                weight: FontWeight.bold,
                                color: KavachTheme.pureWhite),
                          )),
                    )),
                Positioned(
                    top: width / 40,
                    child: Container(
                      width: width,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: KavachTheme.pureWhite),
                      child: Row(children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add friends",
                                style: KavachTheme.subtitleText(
                                  size: width / 25,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Add a friend to use SOS and Track me",
                                style: KavachTheme.subtitleText(
                                    size: width / 30,
                                    weight: FontWeight.w400,
                                    color: KavachTheme.nearlyGrey),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 3.5,
                          child: ElevatedButton(
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: Friends(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino);
                              },
                              style: KavachTheme.buttonStyle(
                                  backColor: KavachTheme.redishPink),
                              child: Text(
                                "Add Friends",
                                style: KavachTheme.subtitleText(
                                    size: width / 30,
                                    weight: FontWeight.bold,
                                    color: KavachTheme.pureWhite),
                              )),
                        )
                      ]),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
