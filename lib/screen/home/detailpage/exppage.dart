import 'package:flutter/material.dart';
import 'package:walletiq/screen/home/detailpage/addexpense.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/model/expmodel.dart';

class ExpPage extends StatelessWidget {
  final ExpModel expmodel;

  const ExpPage({Key key, @required this.expmodel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              expmodel.expname,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              "PHP: " + expmodel.expamount,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Date:  " + expmodel.expdate,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Type of Expense: " + expmodel.exptype,
              style: TextStyle(fontSize: 20.0),
            ),
            Center(
              child: Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddExpense(expmodel: expmodel),
                        )),
                  ),
                  // RaisedButton
                  // (
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Text("Edit"),
                  //   color: Colors.blue,
                  //   onPressed: ()=>Navigator.push(context,
                  //          MaterialPageRoute(
                  //            builder: (_) =>AddExpense(expmodel: expmodel),

                  //          )),
                  // ),
                  //  RaisedButton
                  // (
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Text("Delete"),
                  //   color: Colors.red,

                  //   onPressed: ()=>_deleteExpense(context, expmodel.id),
                  // ),
                  IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteExpense(context, expmodel.id),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteExpense(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteExpense(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete this?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
