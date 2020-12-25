import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Screens/Authenticate/Widgets/Sign%20In.dart';
import 'package:flutter/foundation.dart';
import 'package:teamdrt/Screens/Authenticate/Widgets/Sign%20Up.dart';
import 'Widgets/background_painter.dart';
import 'package:animations/animations.dart';

// ignore: camel_case_types
class Login_Signup extends StatefulWidget {
  @override
  _Login_SignupState createState() => _Login_SignupState();
}


// ignore: camel_case_types
class _Login_SignupState extends State<Login_Signup> with SingleTickerProviderStateMixin{
AnimationController _controller;

ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

@override
  void initState() {

  _controller=AnimationController(vsync: this,duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(animation: _controller.view),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return SizedBox.expand(
                      child: PageTransitionSwitcher(
                        reverse: !value,
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: value
                            ? SignIn(
                          key: const ValueKey('SignIn'),
                          onRegisterClicked: () {
                            //context.resetSignInForm();
                            showSignInPage.value = false;
                            _controller.forward();
                          },
                        )
                            : Register(
                          key: const ValueKey('Register'),
                          onSignInPressed: () {
                            //context.resetSignInForm();
                            showSignInPage.value = true;
                            _controller.reverse();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}
