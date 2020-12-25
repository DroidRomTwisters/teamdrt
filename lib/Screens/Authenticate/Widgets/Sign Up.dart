import 'package:flutter/material.dart';
import 'package:teamdrt/config/pallete.dart';

import 'decoration_functions.dart';
import 'sign_in_up_bar.dart';
import 'title.dart';

class Register extends StatelessWidget {
  const Register({Key key, this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: LoginTitle(
                    title: 'Create\nAccount',
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                            style: const TextStyle(
                              fontSize: 18,
                              color: Palette.darkBlue,
                            ),
                            decoration: registerInputDecoration(hintText: 'Email')
                          //decoration: signInInputDecoration(hintText: 'Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                            style: const TextStyle(
                              fontSize: 18,
                              color: Palette.darkBlue,
                            ),
                            decoration: registerInputDecoration(hintText: 'Password')
                        ),
                      ),
                      SignUpBar(
                        label: 'Sign up',
                        isLoading: true,
                        onPressed: () {
                          //context.registerWithEmailAndPassword();
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          splashColor: Palette.darkBlue,
                          onTap: () {
                            onSignInPressed?.call();
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Palette.darkBlue,
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
