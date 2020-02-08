import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletiq/screen/home/billreminder.dart';
import 'package:walletiq/screen/home/budget.dart';
import 'package:walletiq/screen/home/expense.dart';
import 'package:walletiq/screen/home/home.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/diomar.png'),
              ),
              // color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.home),
            title: Text("DASHBOARD",
                style: TextStyle(
                  fontSize: 18,
                )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => Home()));
            },
          ),
          new Divider(
            color: Colors.black,
            indent: 100.0,
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.moneyBill,
              color: Colors.green,
            ),
            title: Text("BUDGET",
                style: TextStyle(
                  fontSize: 18,
                )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Budget()));
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.coins,
              color: Colors.red,
            ),
            title: Text("EXPENSE",
                style: TextStyle(
                  fontSize: 18,
                )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Expense()));
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.clock, color: Colors.blue),
            title: Text("BILL REMINDER",
                style: TextStyle(
                  fontSize: 18,
                )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BillReminder()));
            },
          ),
        ],
      ),
    );
  }
}
