// ignore_for_file: prefer_const_constructors

import 'package:app2/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  late String Email, Password, Username;
  late String DOB;
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  FirebaseAuth firebaseAuth1 = FirebaseAuth.instance;
  bool a = true;
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown.shade100,
          elevation: 0,
          foregroundColor: Colors.brown,
        ),
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          'Registration Form',
                          style: TextStyle(
                              color: Colors.brown.shade400,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        onSaved: (savedvalue) => user.Email = savedvalue!,
                        style: TextStyle(color: Colors.brown.shade300),
                        controller: nameController1,
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
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        onSaved: (savedvalue) => user.Password = savedvalue!,
                        style: TextStyle(color: Colors.brown.shade300),
                        obscureText: !a,
                        controller: passwordController1,
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
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        onSaved: (savedvalue) => user.Username = savedvalue!,
                        style: TextStyle(color: Colors.brown.shade300),
                        controller: nameController2,
                        validator: (value) {
                          if (!RegExp(
                                  "^(?=[a-zA-Z0-9._]{8,20})(?!.*[_.]{2})[^_.].*[^_.]")
                              .hasMatch(value!)) {
                            return 'Please enter name ';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.brown,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        onSaved: (savedvalue) => user.DOB = savedvalue!,
                        style: TextStyle(color: Colors.brown.shade300),
                        controller: dateCtl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date of birth ';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.perm_contact_calendar_rounded,
                            color: Colors.brown,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'DOB',
                        ),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          FocusScope.of(context).requestFocus(new FocusNode());

                          date = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100)))!;

                          dateCtl.text =
                              ('${date.day}/${date.month}/${date.year}');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RaisedButton(
                            textColor: Colors.brown.shade100,
                            color: Colors.brown.shade400,
                            child: Text('Submit'),
                            onLongPress: () {
                              Navigator.pop(context);
                            },
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //       content: Text('Processing Data')),
                                // );
                                try {
                                  // ignore: unused_local_variable
                                  UserCredential ruserCredential =
                                      await firebaseAuth1
                                          .createUserWithEmailAndPassword(
                                    email: nameController1.text,
                                    password: passwordController1.text,
                                  );
                                  // print("user UID = " + ruserCredential.user!.uid);

                                  // setState(() {
                                  //   progressbar = false;
                                  // });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Succesfully Registered"),
                                    duration: Duration(milliseconds: 1500),
                                  ));
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => LoginPage()),
                                      (route) => false);
                                } catch (e) {
                                  final snackbar =
                                      SnackBar(content: Text(e.toString()));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  // setState(() {
                                  //   progressbar = false;
                                  // });
                                }

                                _formKey.currentState!.save();
                                print(user.DOB);
                              }

                              // print(passwordController1.text);
                              // print(nameController2.text);
                              // print(dateCtl.text);
                            },
                          )),
                    ),
                  ],
                ),
              )),
        ));
  }
}
