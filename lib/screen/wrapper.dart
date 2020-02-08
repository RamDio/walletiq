import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletiq/models/user.dart';
import 'package:walletiq/screen/authentication/auth.dart';
import 'package:walletiq/screen/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    
    //return either home or authenticate widget
   if(user==null){
     return Auth();
   }else{
     return Home();
   }

  }
}