

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  get user => null;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  _updateUser (String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user );
  }


  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(left: 24.0,right: 24.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _updateUser("admin");
                          final snackBar = SnackBar(
                            content: Text('Yet to be Implemented'),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () {

                              },
                            ),
                          );
                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 15.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _updateUser("client");
                          final snackBar = SnackBar(
                            content: Text('Yet to be Implemented'),
                            action: SnackBarAction(
                              label: 'Okay',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 15.0,bottom: 80.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
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
