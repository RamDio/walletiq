import 'package:flutter/material.dart';
import 'package:walletiq/screen/home/detailpage/addbudget.dart';
import 'package:walletiq/screen/home/detailpage/budpage.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/main_drawer.dart';
import 'package:walletiq/screen/home/model/budmodel.dart';
// import 'package:walletiq/services/services.dart';

class Budget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "BUDGET",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
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
                    title: Text(
                      "PHP " + budmodel.budget,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddBudget(budmodel: budmodel),
                              )),
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteBudget(context, budmodel.id),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BudPage(
                                  budmodel: budmodel,
                                ))),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddBudget()));
        },
      ),
    );
  }

  void _deleteBudget(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteBudget(id);
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
              content: Text("Are you sure you want to delete your Budget?"),
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
