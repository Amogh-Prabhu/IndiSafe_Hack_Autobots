// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, unused_field, unnecessary_null_comparison, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/helpline/helpline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kavach/record/sms/sms_service.dart';
import 'package:kavach/store/local_storage/service.dart';
import 'package:kavach/store/models/settings_model.dart';
import 'package:kavach/settings/settings.dart';
import 'package:kavach/sos/sos.dart';
import 'package:kavach/track/service/location_service.dart';
import 'package:kavach/record/record.dart';
import 'package:kavach/track/track.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shake/shake.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  bool _isLoading = false;
  late Map<String, dynamic> address;
  LocationService service = LocationService();
  late Position position;
  late SettingsModel model;

  @override
  void initState() {
    getCurrentPosition();
    getlocalData();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        String message =
            SmsService.draftMessage(liveLocation: address.toString());
        SmsService.sendMessage(message, model.contactNumbers);
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    super.initState();
  }

  void getlocalData() {
    setState(() {
      _isLoading = true;
    });

    SharedPreferenceService.getData().then((value) {
      model = value;
    });
    setState(() {
      _isLoading = false;
    });
  }

  void getCurrentPosition() {
    setState(() {
      _isLoading = true;
    });
    LocationService.determinePosition().then((value) {
      if (value != null) {
        position = value;
        LocationService.getLocation(position).then((value) {
          address = value;
        });

        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(
            locationSettings: service.locationSettings),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) &&
              _isLoading) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: KavachTheme.pureWhite,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: width / 15,
                        width: width / 15,
                        child: const CircularProgressIndicator(
                            strokeWidth: 3, color: KavachTheme.darkPink),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text("Rolling In",
                            style: KavachTheme.titleText(
                                size: width / 18,
                                color: KavachTheme.nearlyGrey,
                                weight: FontWeight.bold)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("Fetching Location Details!",
                            style: KavachTheme.titleText(
                                size: width / 25,
                                color: KavachTheme.nearlyGrey.withOpacity(0.8),
                                weight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.data != null) {
            return buildWidget(context, snapshot.data!);
          } else {
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: KavachTheme.pureWhite,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: width / 15,
                        width: width / 15,
                        child: const CircularProgressIndicator(
                            strokeWidth: 3, color: KavachTheme.darkPink),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text("Rolling In",
                            style: KavachTheme.titleText(
                                size: width / 18,
                                color: KavachTheme.nearlyGrey,
                                weight: FontWeight.bold)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("Fetching Location Details!",
                            style: KavachTheme.titleText(
                                size: width / 25,
                                color: KavachTheme.nearlyGrey.withOpacity(0.8),
                                weight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  Widget buildWidget(BuildContext context, Position position) {
    double size = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: PersistentTabView(
        context,
        navBarHeight: size / 6,
        padding: NavBarPadding.only(top: 20),
        backgroundColor: KavachTheme.pureWhite,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeIn,
        ),
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0.1, 0.8),
                spreadRadius: 3,
                blurRadius: 3)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                30,
              ),
              topRight: Radius.circular(30)),
        ),
        screens: [
          Track(
            position: position,
          ),
          Record(),
          SizedBox(),
          Help(),
          SettingsPage(), 
        ],
        items: [
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.location_circle, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: KavachTheme.lightPink,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Track Me",
              textStyle: KavachTheme.subtitleText(
                  size: size / 35, weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.recordingtape, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: KavachTheme.lightPink,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Record",
              textStyle: KavachTheme.subtitleText(
                  size: size / 35, weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(Icons.sos_sharp, size: size / 13),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: Colors.redAccent,
              onPressed: (c) {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: SOS(
                      position: position,
                    ),
                    pageTransitionAnimation: PageTransitionAnimation.scale);
              },
              textStyle: KavachTheme.subtitleText(
                  size: size / 35,
                  weight: FontWeight.bold,
                  color: KavachTheme.lightGrey)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.phone_arrow_up_right, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: KavachTheme.lightPink,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Helpline",
              textStyle: KavachTheme.subtitleText(
                  size: size / 35, weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.settings, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: KavachTheme.lightPink,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Settings",
              textStyle: KavachTheme.subtitleText(
                  size: size / 35, weight: FontWeight.w600)),
        ],
        controller: _controller,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
