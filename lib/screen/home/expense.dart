import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:walletiq/screen/home/detailpage/addexpense.dart';
import 'package:walletiq/screen/home/detailpage/exppage.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/main_drawer.dart';
import 'package:walletiq/screen/home/model/expmodel.dart';

class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "EXPENSES",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0, //remove drop shadow
      ),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: FirestoreService().getExpModel(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ExpModel>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.separated(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              ExpModel expmodel = snapshot.data[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.moneyBillWave,
                    color: Colors.green,
                  ),
                  title: Text(expmodel.expname),
                  subtitle: Text(expmodel.exptype),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // IconButton(
                      //   color: Colors.black,
                      //   icon: Icon(Icons.edit),
                      //   onPressed: ()=>Navigator.push(context,
                      //    MaterialPageRoute(
                      //      builder: (_) =>AddExpense(expmodel: expmodel),
                      //    )),
                      //   ),
                      // IconButton(
                      //   color: Colors.red,
                      //   icon: Icon(Icons.delete),
                      //   onPressed: ()=>_deleteExpense(context, expmodel.id),
                      //   ),
                      Text("PHP " + expmodel.expamount,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ExpPage(
                                expmodel: expmodel,
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
              context, MaterialPageRoute(builder: (_) => AddExpense()));
        },
      ),
    );
  }
//   void _deleteExpense(BuildContext context,String id)async{
//     if(await _showConfirmationDialog(context)){
//     try{
//       await FirestoreService().deleteExpense(id);
//     }catch(e){
//       print(e);
//     }
//   }
// }
//   Future <bool> _showConfirmationDialog(BuildContext context) async{
//     return showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder:(context)=>AlertDialog(
//         content: Text("Are you sure you want to delete this?"),
//         actions: <Widget>[
//           FlatButton(
//             textColor: Colors.red,
//             child: Text("Delete"),
//             onPressed: ()=> Navigator.pop(context,true),
//           ),
//           FlatButton(
//             textColor: Colors.black,
//             child: Text("Cancel"),
//             onPressed: ()=> Navigator.pop(context,false),
//           ),
//         ],
//       )

//     );
//   }
}
