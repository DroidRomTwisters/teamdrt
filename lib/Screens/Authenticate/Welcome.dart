import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/config/pallete.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({
    Key key,
    @required this.onClicked,
  }) : super(key: key);

  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to",
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w300,
            fontSize: 48,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 75),
          child: SizedBox(
            height: size.height / 4,
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
        ),
        Text(
          "teamDrt",
          style: const TextStyle(
            color: Palette.darkBlue,
            fontWeight: FontWeight.normal,
            fontSize: 50,
          ),
        ),
        Text(
          "Let's Grow Together",
          style: const TextStyle(
            color: Colors.black54,
            fontStyle: FontStyle.italic,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: FloatingActionButton(
            elevation: 8.0,
            onPressed: () => {onClicked?.call()},
            child: Icon(Icons.arrow_forward_rounded),
            backgroundColor: Palette.darkBlue,
          ),
        ),
      ],
    );
  }
}
