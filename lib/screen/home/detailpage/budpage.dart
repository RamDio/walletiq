import 'package:flutter/material.dart';
import 'package:walletiq/screen/home/model/budmodel.dart';

class BudPage extends StatelessWidget {
  final BudModel budmodel;


  const BudPage({Key key, @required this.budmodel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Budget"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("PHP  "+budmodel.budget, style: Theme.of(context)
              .textTheme.title.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 50.0
              )
              ,) ,
              const SizedBox(height: 50.0),
            ],),
        ),
      
    );
  }
}

