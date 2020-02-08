import 'package:flutter/material.dart';
import 'package:walletiq/loading/loading.dart';
import 'package:walletiq/services/services.dart';
import 'package:walletiq/shared/constants.dart';

class Signup extends StatefulWidget {
  final Function toggleView;
  Signup({this.toggleView});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthServices _auth= AuthServices();
  final _formKey=GlobalKey<FormState>();
  bool loading = false;

  //text field state
String email='';
String password='';
String password2='';
String error='';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue[500],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/peso.jpg'),
            fit: BoxFit.cover )
        ),
        padding: EdgeInsets.symmetric(vertical: 70.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=>val.isEmpty?'Enter Email':null,
                onChanged: (val){
                   setState(()=>email=val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val)=>val.length<8?'Password must be 8 characters long':null,
                onChanged: (val){
                   setState(()=>password=val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Re-Type Password'),
                obscureText: true,
                validator: (val) {
                      if(password2!=password){
                        return 'password does not match';
                      }
                },
                onChanged: (val){
                   setState(()=>password2=val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                    // print(email);
                    // print(password);
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result==null){
                            setState(() {
                              error='please supply a valid email';
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
                ),     
            ],
            
          )),
        
      ),
      bottomNavigationBar: new FlatButton(
        child: new Text("Have an Account? Sign In",
        style: TextStyle(fontSize: 20.0),),
        onPressed: (){
            widget.toggleView();

          },
          ),
    );
  }
}