import 'package:flutter/material.dart';
import 'package:walletiq/screen/authentication/signin.dart';
import 'package:walletiq/screen/authentication/signup.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
      bool showLogIn=true;
      void toggleView(){
        setState(()=>showLogIn=!showLogIn); 
      }


  @override
  Widget build(BuildContext context) {
    if(showLogIn){
      return SignIn(toggleView: toggleView);
    }else{
      return Signup(toggleView: toggleView);
    }
  }
}