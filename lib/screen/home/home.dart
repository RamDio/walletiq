import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletiq/screen/home/detailpage/addbillreminder.dart';
import 'package:walletiq/screen/home/detailpage/addbudget.dart';
import 'package:walletiq/screen/home/detailpage/addexpense.dart';
import 'package:walletiq/screen/home/detailpage/exppage.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/main_drawer.dart';
import 'package:walletiq/screen/home/model/budmodel.dart';
import 'package:walletiq/screen/home/model/expmodel.dart';
import 'package:walletiq/services/services.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "OVERVIEW",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            label: Text('LOGOUT'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ], //remove drop shadow
      ),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: FirestoreService().getBudModel(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BudModel>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.separated(
            padding: EdgeInsets.all(8.0),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              BudModel budmodel = snapshot.data[index];
              return Container(
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "PHP " + budmodel.budget,
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        child: Icon(
          Icons.add,
          size: 22.0,
          color: Colors.black,
        ),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.wallet),
            backgroundColor: Colors.red,
            label: 'Add Budget',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddBudget()));
            },
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.moneyBillWaveAlt),
            backgroundColor: Colors.blue,
            label: 'Add Expenses',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddExpense()));
            },
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.clock),
            backgroundColor: Colors.green,
            label: 'Add Bill Reminder',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddBillReminder()));
            },
          ),
        ],
      ),
    );
  }
}
