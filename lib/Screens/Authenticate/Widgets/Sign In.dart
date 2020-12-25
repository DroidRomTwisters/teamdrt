import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamdrt/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'decoration_functions.dart';
import 'sign_in_up_bar.dart';
import 'package:teamdrt/Service/auth.dart';
import 'package:teamdrt/config/pallete.dart';
import 'title.dart';
import 'package:auth_buttons/auth_buttons.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key key,
    @required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  _State createState() => _State(onRegisterClicked);


}

class _State extends State<SignIn> {

  final VoidCallback onRegisterClicked;

  bool isSigningIn = false;

  _State(this.onRegisterClicked);
  void changeLoadState(bool isloading) {
    setState(() {
      isSigningIn=isloading;
    });
  }

  @override
  Widget build(BuildContext context) {

    String email;
    String password;
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LoginTitle(
                    title: 'Welcome\nBack',
                  ),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (String email1) {
                            email = email1;
                          },
                          decoration: signInInputDecoration(hintText: 'Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (String password1) {
                            password = password1;
                          },
                          decoration: signInInputDecoration(
                              hintText: 'Password'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: ButtonTheme(
                          height: 48,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)
                          ),
                          child: RaisedButton(
                            color: Palette.darkBlue,
                            elevation: 8.0,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),

                            ),
                            //isLoading: isSigningIn,
                            onPressed: () async {
                              if (email.isNotEmpty && password.isNotEmpty) {
                                await AuthService().signInWithEmail(email, password, context);
                                //changeLoadState(true);
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Divider(
                                    color: Palette.darkBlue,
                                  ),
                                )
                            ),
                            Text("OR"),

                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Divider(
                                    color: Palette.darkBlue,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoogleAuthButton(
                            onPressed: () {},
                            darkMode: false,
                            style: AuthButtonStyle.icon,
                            borderRadius: 50,
                            buttonBorderColor: Colors.transparent,
                          ),
                          FacebookAuthButton(
                            onPressed: () {},
                            darkMode: false,
                            style: AuthButtonStyle.icon,
                            borderRadius: 50,
                            buttonBorderColor: Colors.transparent,
                          ),
                          GitHubAuthButton(
                            onPressed: () {},
                            darkMode: false,
                            style: AuthButtonStyle.icon,
                            borderRadius: 50,
                            buttonBorderColor: Colors.transparent,
                          ),
                          TwitterAuthButton(
                            onPressed: () {},
                            darkMode: false,
                            style: AuthButtonStyle.icon,
                            borderRadius: 50,
                            buttonBorderColor: Colors.transparent,
                          ),


                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            onRegisterClicked?.call();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account? \t',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Palette.darkBlue,
                                  ),
                                ),
                                const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    color: Palette.darkBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  )
              )
            ],
          ),
        )

    );
  }
}

class _RoundContinueButton extends StatelessWidget {
  const _RoundContinueButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      splashColor: Palette.darkOrange,
      padding: const EdgeInsets.all(16.0),
      shape: const CircleBorder(

      ),
      child: const Icon(
        FontAwesomeIcons.google,
        color: Colors.redAccent,
        size: 24.0,
      ),
    );
  }
}