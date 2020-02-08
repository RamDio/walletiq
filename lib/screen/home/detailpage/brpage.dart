import 'package:flutter/material.dart';
import 'package:walletiq/screen/home/model/brmodel.dart';

class BrPage extends StatelessWidget {
  final BrModel brmodel;


  const BrPage({Key key, @required this.brmodel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Reminder Details"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          
          child: Center(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(brmodel.brname, style: Theme.of(context)
                .textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                )
                ,) ,
                const SizedBox(height: 20.0),
                  
                Text("PHP: "+brmodel.bramount, style: TextStyle(fontSize: 20.0),), 
                Text("Date: "+brmodel.brdate, style: TextStyle(fontSize: 20.0),),
                Text("Type of Expense: "+brmodel.brtype, style: TextStyle(fontSize: 20.0),),
                
              ],),
          ),
        ),
      
    );
  }
}

