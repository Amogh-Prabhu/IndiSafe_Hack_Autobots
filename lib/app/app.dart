// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach/track/track.dart';
import 'package:kavach/utils/kavach_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return buildWidget(context);
    });
  }

  Widget buildWidget(BuildContext context) {
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
        screens: [Track(), Scaffold(), Scaffold(), Scaffold(), Scaffold()],
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
              textStyle: KavachTheme.subtitleText(
                  size: size / 35,
                  weight: FontWeight.bold,
                  color: KavachTheme.lightGrey)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.book_fill, size: size / 17),
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
