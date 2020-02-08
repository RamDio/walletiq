
import 'package:flutter/material.dart';
import 'package:walletiq/loading/loading.dart';
import 'package:walletiq/services/services.dart';
import 'package:walletiq/shared/constants.dart';

class SignIn extends StatefulWidget {
final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
final AuthServices _auth= AuthServices();
final _formKey=GlobalKey<FormState>();
bool loading = false;

//text field state
String email='';
String password='';

String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false ,
      backgroundColor: Colors.blue[500],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/peso.jpg'),
            fit: BoxFit.cover )
        ),
        padding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:Column(
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
              'Please Log In',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)

                 ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=>val.isEmpty?'Enter Email':null,
                onChanged: (val){
                   setState(()=>email=val);
                }
              ),
              SizedBox(height: 18.0),
              TextFormField(
                
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val)=>val.length<8?'Password must be 8 characters long':null,
                onChanged: (val){
                   setState(()=>password=val);
                }
              ),
              SizedBox(height: 18.0),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result==null){
                            setState(() {
                              error='credentials dont match';
                              loading=false;
                              });
                      }
                    }
                }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize:14.0),
                )
            ],
          ))
        
      ),
      bottomNavigationBar: new FlatButton(
        child: new Text("No Account? Sign Up",
        style: TextStyle(fontSize: 20.0)),
        onPressed: (){
            widget.toggleView();

          },
          ),
    );
  }
}