

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Screens/Authenticate/Login_Signup.dart';
import 'package:teamdrt/Screens/home/Home.dart';
import 'package:teamdrt/Service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  get user => null;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog circularProgressIndicator;

  _updateUser (String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user );
  }

@override
  void dispose() {
    // TODO: implement dispose
  if(circularProgressIndicator.isShowing()) {
    circularProgressIndicator.hide();
  }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    circularProgressIndicator=new ProgressDialog(context);

    circularProgressIndicator.style(
      message: "Logging In..",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(

        ),
      ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login",
          ),
          ),
          body:buildColumn(),
      ),
    );
  }

  Center buildColumn() {

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Text(
                        "Who Are You?",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black26,
                        fontFamily: 'Product Sans'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0,right: 48.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _updateUser("admin");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Signup()));
                        },
                        color: Colors.greenAccent,
                        child: Text("Admin",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Product Sans",
                            fontSize: 18.0,
                          ),
                        ),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0,right: 48.0,top: 15.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _updateUser("client");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text("Client",style: TextStyle(
                        color: Colors.white,
                          fontSize: 18.0,
                        ),

                        ),
                        color: Colors.redAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0,right: 48.0,top: 15.0,bottom: 80.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          circularProgressIndicator.show();
                          _updateUser("anonymous");
                          AuthService().signInAnon();
                        },
                        child: Text("Visitor",style: TextStyle(
                        color: Colors.white,
                          fontSize: 18.0,)
                        ),
                        color: Colors.amber,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0)
                        ),
                      ),
                    ),
                  )
                ],
              ),
    );
  }
}
