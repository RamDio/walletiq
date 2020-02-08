import 'package:flutter/material.dart';
import 'package:walletiq/models/user.dart';
import 'package:walletiq/screen/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:walletiq/services/services.dart';
// import 'package:splashscreen/splashscreen.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthServices().user,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
