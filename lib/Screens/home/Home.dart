import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamdrt/Service/auth.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const Home(),
      );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String user = "";

  _getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user = preferences.getString("user");
    });
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return Container(
      child: Scaffold(
          //backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              "Home",
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      AuthService().signOut();
                    },
                    child: Icon(
                      Icons.logout,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: Center(child: Text("Hello Mr. "))),
    );
  }
}
