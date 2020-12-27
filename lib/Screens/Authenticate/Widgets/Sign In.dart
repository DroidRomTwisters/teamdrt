import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Service/auth.dart';
import 'package:teamdrt/config/pallete.dart';

import 'decoration_functions.dart';
import 'title.dart';

class SignIn extends StatefulWidget {
  const SignIn(
      {Key key, @required this.onRegisterClicked, @required this.onOTp})
      : super(key: key);

  final VoidCallback onOTp;
  final VoidCallback onRegisterClicked;

  _State createState() => _State(onRegisterClicked, onOTp);
}

class _State extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final VoidCallback onRegisterClicked;
  final VoidCallback onOTp;

  bool isSigningIn = false;

  _State(this.onRegisterClicked, this.onOTp);

  void changeLoadState(bool isloading) {
    setState(() {
      isSigningIn = isloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    String phone;
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.white,
            onTap: () {
              AuthService().signInAnon();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "skip",
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: Palette.darkBlue,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LoginTitle(
                title: 'Welcome to\nteamDrt',
              ),
            ),
          ),
          Expanded(
              flex: 8,

              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        onChanged: (String phone1) {
                          phone = phone1;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: signInInputDecoration(hintText: 'Phone',icon: Icon(Icons.phone)),
                        validator: (phone){
                          final RegExp regex = new RegExp(r'\d\d\d\d\d\d\d\d\d\d');
                          return regex.hasMatch(phone) && phone.length==10?null:"Please Enter a Valid Phone Number";
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ButtonTheme(
                        height: 36,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            RaisedButton(
                              color: Palette.darkBlue,
                              elevation: 8.0,
                              child: Text(
                                "Send OTP",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),

                              //isLoading: isSigningIn,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await AuthService()
                                      .signInWithPhoneNumber(phone);
                                  onOTp?.call();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Divider(
                              color: Palette.darkBlue,
                            ),
                          )),
                          Text("OR"),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Divider(
                              color: Palette.darkBlue,
                            ),
                          )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoogleAuthButton(
                          onPressed: () {
                            AuthService().signInWithGoogle();
                          },
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          borderRadius: 50,
                          buttonBorderColor: Colors.transparent,
                        ),
                        FacebookAuthButton(
                          onPressed: () {
                            AuthService().signInWithFacebook();
                          },
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          borderRadius: 50,
                          buttonBorderColor: Colors.transparent,
                        ),
                        GitHubAuthButton(
                          onPressed: () {
                            AuthService().signInWithGitHub(context);
                          },
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          borderRadius: 50,
                          buttonBorderColor: Colors.transparent,
                        ),
                        TwitterAuthButton(
                          onPressed: () {
                            AuthService().signInWithTwitter();
                          },
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          borderRadius: 50,
                          buttonBorderColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
