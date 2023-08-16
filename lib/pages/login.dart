import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraud_detector/pages/home1.dart';
import 'package:fraud_detector/pages/signUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _email, _password;
  checkAuthentication() async {
    _auth.authStateChanges().listen((event) {
      if (_auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home1()));
      }
    });
  }

  signout() async {
    _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
  }

  Login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('error'),
            content: Text(errormessage),
            actions: [
              MaterialButton(
                color: Colors.blue,
                onPressed: () {},
                child: Text('ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    // input field for email
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email), labelText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                      onSaved: (value) => _email = value!,
                    ),
                    // input field for password
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                      onSaved: (value) => _password = value!,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: Login,
                      child: Text('Login'),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('dont have an account?  '),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        }),
                        child: const Text('Register'),
                      ),
                    ]),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
