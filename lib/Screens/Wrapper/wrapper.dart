import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:teamdrt/Screens/Present/Present%20Screen.dart';
import 'package:teamdrt/Screens/home/Home.dart';
import 'package:teamdrt/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User2>(context);
    if (user == null) {
      return presetScreen();
    }else {
      return Home();
    }
  }
}