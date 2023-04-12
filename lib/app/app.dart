// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: KavachTheme.pureWhite,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeIn,
        ),
        decoration: NavBarDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        screens: [Scaffold(), Scaffold(),Scaffold()],
        items: [
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.house, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Home",
              textStyle: KavachTheme.subtitleText(
                  size: size / 30, weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.house, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Home",
              textStyle: KavachTheme.subtitleText(
                  size: size / 30, weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.house, size: size / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: KavachTheme.redishPink,
              title: "Home",
              textStyle: KavachTheme.subtitleText(
                  size: size / 30, weight: FontWeight.w600)),
        ],
        controller: _controller,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style10,
      ),
    );
  }
}
