// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:app2/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  late Map<String, dynamic> dataTOAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(("posts"));
  addData() {
    dataTOAdd = {
      "title": titleController.text,
      "message": msgController.text,
    };
    collectionReference.add(dataTOAdd).whenComplete(() => print('DATA ADDED'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.brown,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.brown.shade300, width: 3),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        color: Colors.brown.shade300,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              color: Colors.brown,
              child: TextField(
                controller: msgController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.brown.shade300, width: 3),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Message',
                    labelStyle: TextStyle(
                        color: Colors.brown.shade300,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: Icon(
          Icons.add,
          color: Colors.brown.shade100,
        ),
        onPressed: () {
          addData();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListPage()));
        },
      ),
    );
  }
}
