// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavach/track/layout/friends.dart';
import 'package:kavach/track/service/location_service.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Track extends StatefulWidget {
  Track({super.key, required this.position});
  Position position;
  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationService service = LocationService();
  late CameraPosition _currentPosition;

  @override
  void initState() {
    _currentPosition = CameraPosition(
      target: LatLng(widget.position.latitude, widget.position.longitude),
      zoom: 18,
    );
    super.initState();
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
        title: Row(
          children: [
            Image.asset(
              "assets/images/image.jpg",
              height: width / 12,
              width: width / 12,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Kavach",
              style: KavachTheme.titleText(
                  size: width / 13,
                  weight: FontWeight.w600,
                  color: KavachTheme.darkPink),
            ),
          ],
        ),
        actions: [
          Icon(
            CupertinoIcons.bell,
            color: KavachTheme.nearlyGrey,
            size: width / 16,
          ),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.menu,
            color: KavachTheme.nearlyGrey,
            size: width / 14,
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
                          onPressed: () {},
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
