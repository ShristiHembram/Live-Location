import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livelocation2/Pages/Setup/signIn.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                onPressed: signUp,
                child: Text('Sign In'),
              )
            ],
          ),
        )
    );
  }


  Future<void> signUp() async{
    final formState = _formKey.currentState;
    final _auth = FirebaseAuth.instance;
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try{
        Fireba user= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        _auth.sendPasswordResetEmail(email:_email);
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage()));
      }catch(e){
        print(e);
      }
    }
  }
}
