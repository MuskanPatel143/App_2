// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:app2/homepage.dart';
import 'package:app2/registrationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool a = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.brown,
        //   title: Text(
        //     'App2',
        //     style: TextStyle(color: Colors.brown.shade100),
        //   ),
        // ),
        body: Container(
      color: Colors.brown.shade100,
      child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'LogIn',
                      style: TextStyle(
                          color: Colors.brown.shade400,
                          fontWeight: FontWeight.w500,
                          fontSize: 40),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Colors.brown.shade300),
                    controller: nameController,
                    validator: (value) {
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value!)) {
                        return 'Please enter vaild Email ';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.brown,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.brown.shade300),
                    obscureText: !a,
                    controller: passwordController,
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.brown,
                      ),
                      suffixIcon: IconButton(
                        icon: a
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.brown,
                                size: 20,
                              )
                            : Icon(
                                Icons.remove_red_eye,
                                color: Colors.brown,
                                size: 20,
                              ),
                        onPressed: () {
                          setState(() {
                            a = !a;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.brown.shade400,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.7,
                    // padding: EdgeInsets.symmetric(horizontal: 50),
                    child: RaisedButton(
                      textColor: Colors.brown.shade100,
                      color: Colors.brown.shade400,
                      child: Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                          try {
                            UserCredential luserCredential =
                                await firebaseAuth.signInWithEmailAndPassword(
                                    email: nameController.text,
                                    password: passwordController.text);

                            print(
                                "login user uid is : ${luserCredential.user?.uid}");

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => HomePage()),
                                (route) => false);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              duration: Duration(milliseconds: 1500),
                            ));
                            print(e);
                          }
                        }
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      'Does not have account?',
                      style: TextStyle(color: Colors.brown),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 20, color: Colors.brown.shade400),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationPage()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            ),
          )),
    ));
  }
}
