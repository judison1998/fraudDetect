import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraud_detector/pages/home1.dart';
import 'package:fraud_detector/pages/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _email, _password, _name;
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) async {
      if (_auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home1()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
  }

  signup() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await FirebaseAuth.instance.currentUser!
              .updateProfile(displayName: _name);
        }
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
                    // input field for name
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                          labelText: 'user name'),
                      validator: (value) =>
                          value!.isEmpty ? 'user name can not be empty' : null,
                      onSaved: (value) => _name = value!,
                    ),
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
                      onPressed: signup,
                      child: Text('Register'),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('already have an account?  '),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        onPressed: (() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }),
                        child: const Text('login'),
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
