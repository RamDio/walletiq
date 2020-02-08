import 'package:flutter/material.dart';
import 'package:walletiq/loading/loading.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/model/brmodel.dart';
// import 'package:walletiq/screen/home/model/expmodel.dart';

class AddBillReminder extends StatefulWidget {
  final BrModel brmodel;

  const AddBillReminder({Key key, this.brmodel}) : super(key: key);
  @override
  _AddBillReminderState createState() => _AddBillReminderState();
}

class _AddBillReminderState extends State<AddBillReminder> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _brnameController;
  TextEditingController _bramountController;
  TextEditingController _brdateController;
  TextEditingController _brtypeController;
  FocusNode _bramountNode;
  FocusNode _brdateNode;
  FocusNode _brtypeNode;
  @override
  void initState() {
    super.initState();
    _brnameController = TextEditingController(
        text: isEditBillReminder ? widget.brmodel.brname : '');
    _bramountController = TextEditingController(
        text: isEditBillReminder ? widget.brmodel.bramount : '');
    _brdateController = TextEditingController(
        text: isEditBillReminder ? widget.brmodel.brdate : '');
    _brtypeController = TextEditingController(
        text: isEditBillReminder ? widget.brmodel.brtype : '');
    _bramountNode = FocusNode();
    _brdateNode = FocusNode();
    _brtypeNode = FocusNode();
  }

  get isEditBillReminder => widget.brmodel != null;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(isEditBillReminder ? 'Edit Reminder' : 'Add Reminder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_bramountNode);
                },
                controller: _brnameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please Input the Name";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                focusNode: _bramountNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_brdateNode);
                },
                controller: _bramountController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Input amount please";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Amount", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                focusNode: _brdateNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_brtypeNode);
                },
                controller: _brdateController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Input date";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Date", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                focusNode: _brtypeNode,
                controller: _brtypeController,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Input type";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Type", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                  color: Colors.orange,
                  child: Text(isEditBillReminder ? "Update" : "ADD"),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      setState(() => loading = true);

                      try {
                        if (isEditBillReminder) {
                        BrModel brmodel = BrModel(
                        brname: _brnameController.text,
                        bramount: _bramountController.text,
                        brdate: _brdateController.text,
                        brtype: _brtypeController.text,
                        id: widget.brmodel.id,
                      );
                          await FirestoreService().updateBillReminder(brmodel);
                        } else {
                          BrModel brmodel = BrModel(
                        brname: _brnameController.text,
                        bramount: _bramountController.text,
                        brdate: _brdateController.text,
                        brtype: _brtypeController.text,
                      );
                          await FirestoreService().addBillReminder(brmodel);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
