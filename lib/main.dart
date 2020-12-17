
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Wrapper/wrapper.dart';
import 'Service/auth.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
var colors=Colors.blueGrey;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User2>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
      ),
    );
  }
}

class _Check extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _checkState();
}

class _checkState extends State<_Check>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Login",),
        ),
        body:Text("hello"),
      ),
    );
  }
}


