import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:livelocation2/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  late String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input!.isEmpty){
                  return 'Please type your email';
                }
              },
              onSaved: (input) => _email = input!,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input){
                if(input!.length < 6){
                  return 'Password should be at least 6 characters';
                }
              },
              onSaved: (input) => _password = input!,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            )
          ],
        ),
      )
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    final _auth = FirebaseAuth.instance;
    if(formState!.validate()){
      formState.save();
      try{
        final user= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>Home(user: user)));
      }catch(e){
        print(e);
      }
    }
  }
}