import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamdrt/Screens/Authenticate/Welcome.dart';
import 'package:teamdrt/Screens/Authenticate/Widgets/Sign%20In.dart';
import 'package:teamdrt/Screens/Authenticate/Widgets/otpEnter.dart';
import 'package:teamdrt/config/Page_Enum.dart';

// ignore: camel_case_types
class presetScreen extends StatefulWidget {
  @override
  _presetScreenState createState() => _presetScreenState();
}

// ignore: camel_case_types
class _presetScreenState extends State<presetScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<LOGIN_PAGE> whichPage = ValueNotifier<LOGIN_PAGE>(LOGIN_PAGE.WELCOME);

  _presetScreenState();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/top_left.png',
              width: size.width - 50,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/bottom_left.png',
              width: size.width - 50,
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<LOGIN_PAGE>(
                valueListenable: whichPage,
                builder: (context, value, child) {
                  return SizedBox.expand(
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 900),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: value == LOGIN_PAGE.WELCOME
                          ? welcomeScreen(
                              key: const ValueKey('Welcome'),
                              onClicked: () {
                                whichPage.value = LOGIN_PAGE.SIGN_IN;
                              })
                          : value == LOGIN_PAGE.SIGN_IN || value == LOGIN_PAGE.SIGN_UP
                              ? SignIn(
                                  key: const ValueKey('SignIn'),
                                  onRegisterClicked: () {
                                    whichPage.value = LOGIN_PAGE.SIGN_UP;
                                  },
                                  onOTp: () {
                                    whichPage.value = LOGIN_PAGE.OTP;
                                  },
                                )
                              :OTPScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("\u00a9 teamDrt 2021")),
          ),
        ],
      ),
    );
  }
}
