import 'package:flutter/material.dart';
import 'package:walletiq/loading/loading.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/model/expmodel.dart';

class AddExpense extends StatefulWidget {
  final ExpModel expmodel;

  const AddExpense({Key key, this.expmodel}) : super(key: key);
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _expnameController;
  TextEditingController _expamountController;
  TextEditingController _expdateController;
  TextEditingController _exptypeController;
  FocusNode _expamountNode;
  FocusNode _expdateNode;
  FocusNode _exptypeNode;
  @override
  void initState() {
    super.initState();
    _expnameController = TextEditingController(
        text: isEditExpense ? widget.expmodel.expname : '');
    _expamountController = TextEditingController(
        text: isEditExpense ? widget.expmodel.expamount : '');
    _expdateController = TextEditingController(
        text: isEditExpense ? widget.expmodel.expdate : '');
    _exptypeController = TextEditingController(
        text: isEditExpense ? widget.expmodel.exptype : '');
    _expamountNode = FocusNode();
    _expdateNode = FocusNode();
    _exptypeNode = FocusNode();
  }

  get isEditExpense => widget.expmodel != null;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(isEditExpense ? 'Edit Expenses' : 'Add Expenses'),
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
                        FocusScope.of(context).requestFocus(_expamountNode);
                      },
                      controller: _expnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Name your Expenses";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Name", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      focusNode: _expamountNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_expdateNode);
                      },
                      controller: _expamountController,
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
                      focusNode: _expdateNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_exptypeNode);
                      },
                      controller: _expdateController,
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
                      focusNode: _exptypeNode,
                      controller: _exptypeController,
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
                        child: Text(isEditExpense ? "Update" : "ADD"),
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            setState(() => loading = true);

                            try {
                              if (isEditExpense) {
                                ExpModel expmodel = ExpModel(
                                  expname: _expnameController.text,
                                  expamount: _expamountController.text,
                                  expdate: _expdateController.text,
                                  exptype: _exptypeController.text,
                                  id: widget.expmodel.id,
                                );
                                await FirestoreService()
                                    .updateExpense(expmodel);
                              } else {
                                ExpModel expmodel = ExpModel(
                                  expname: _expnameController.text,
                                  expamount: _expamountController.text,
                                  expdate: _expdateController.text,
                                  exptype: _exptypeController.text,
                                );
                                await FirestoreService().addExpense(expmodel);
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
