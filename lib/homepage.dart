// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:app2/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: TextButton(
            child: Text('LOGOUT'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ),
      ),
    );
  }
}
