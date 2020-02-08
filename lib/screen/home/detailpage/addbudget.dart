import 'package:flutter/material.dart';
import 'package:walletiq/loading/loading.dart';
import 'package:walletiq/screen/home/firestoreservice.dart';
import 'package:walletiq/screen/home/model/budmodel.dart';

class AddBudget extends StatefulWidget {
  final BudModel budmodel;

  const AddBudget({Key key, this.budmodel}) : super(key: key);
  @override
  _AddAddBudgetState createState() => _AddAddBudgetState();
}

class _AddAddBudgetState extends State<AddBudget> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController _budgetController;
  FocusNode _budgetNode;

  @override
  void initState() {
    super.initState();
    _budgetController = TextEditingController(
        text: isEditBudget ? widget.budmodel.budget : '');
  }

  get isEditBudget => widget.budmodel != null;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(isEditBudget ? 'Edit Budget' : 'Add Budget'),
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
                  FocusScope.of(context).requestFocus(_budgetNode);
                },
                controller: _budgetController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please Input Your Budget";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Amount", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10.0,
              ),
              
              RaisedButton(
                  color: Colors.orange,
                  child: Text(isEditBudget ? "Update" : "ADD"),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      setState(() => loading = true);
                      try {
                        if (isEditBudget) {
                        BudModel budmodel = BudModel(
                        budget: _budgetController.text,
                        id: widget.budmodel.id,
                      );
                          await FirestoreService().updateBudget(budmodel);
                        } else {
                          BudModel budmodel = BudModel(
                        budget: _budgetController.text,
                      );
                          await FirestoreService().addBudget(budmodel);
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
