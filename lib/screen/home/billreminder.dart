import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletiq/screen/home/detailpage/addbillreminder.dart';
import 'package:walletiq/screen/home/detailpage/brpage.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/main_drawer.dart';
import 'package:walletiq/screen/home/model/brmodel.dart';

class BillReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "BILL REMINDER",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: FirestoreService().getBrModel(),
        builder: (BuildContext context, AsyncSnapshot<List<BrModel>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.separated(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              BrModel brmodel = snapshot.data[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.calendarAlt, color: Colors.red,),
                  title: Text(brmodel.brname),
                  subtitle: Text(brmodel.brdate),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddBillReminder(brmodel: brmodel),
                            )),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteBillReminder(context, brmodel.id),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BrPage(
                                brmodel: brmodel,
                              ))),
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
              context, MaterialPageRoute(builder: (_) => AddBillReminder()));
        },
      ),
    );
  }

  void _deleteBillReminder(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteBillReminder(id);
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
              content: Text("Do You want to cancel this reminder?"),
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
