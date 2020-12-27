import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:teamdrt/Screens/Authenticate/Widgets/title.dart';
import 'package:teamdrt/Service/auth.dart';

class OTPScreen extends StatelessWidget {
  final String verificationId;

  const OTPScreen({Key key, @required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 150.0),
      child: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: LoginTitle(
            title: 'Enter OTP',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 75.0),
          child: OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 30,
            style: TextStyle(fontSize: 16),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              AuthService().SigInwithSmsCode(pin);
            },
            onChanged: (pin) {

            },
          ),
        ),

      ]),
    );
  }
}
