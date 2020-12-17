

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Service/auth.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Home",
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
                  )
              ),
            ],

          ),
          body: Center(child: Text("Home"))
      ),
    );
  }
}