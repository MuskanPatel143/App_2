// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, non_constant_identifier_names, unnecessary_new

import 'package:app2/addata.dart';
import 'package:app2/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  // Future getPosts() async {
  //   final firestore = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await firestore.collection('posts').get();
  //   return qn.docs;
  // }

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'data',
          style: TextStyle(color: Colors.brown.shade100),
        ),
      ),
      backgroundColor: Colors.brown.shade100,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection("posts")
              // .where("message", isGreaterThanOrEqualTo: 1)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("There is no expense");
            return new ListView(children: getExpenseItems(snapshot));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: Icon(
          Icons.add,
          color: Colors.brown.shade100,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: new ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                tileColor: Colors.brown.shade200,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage()));
                },
                title: new Text(doc["title"]),
              ),
            ))
        .toList();
  }
  // StreamBuilder<QuerySnapshot>(
  //   stream: firestore.collection('posts').snapshots(),
  //   builder: (context, snapshot) {
  //     if (!snapshot.hasData) {
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     } else {
  //       return Stack(children: [
  //         ListView.builder(itemBuilder: (Context, index) {
  //           Map<String, dynamic> docss =
  //               snapshot.data!.docs[index].data() as Map<String, dynamic>;
  //           // children: snapshot.data!.docs.map((doc) {
  //           return Card(
  //             child: ListTile(
  //               title: docss['title'] == "" ? "untitled" : docss['title'],
  //             ),
  //           );
  //           // ignore: dead_code
  //           Container(
  //             child: FloatingActionButton(
  //               onPressed: () {
  //                 setState(() {
  //                   titleController.text = "";
  //                   msgController.text = '';
  //                 });
  //               },
  //               child: Icon(Icons.add),
  //             ),
  //           );
  //         })
  //       ]);
  //     }
  //   },
  // )
  // Container(
  //   child: FutureBuilder(
  //     future: getPosts(),
  //     builder: (_, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: Text('loading.....'),
  //         );
  //       } else {
  //         return ListView.builder(
  //             itemCount: snapshot.data!.length,
  //             itemBuilder: (_, index) {
  //               return ListTile(
  //                 title: Text(snapshot.data![index].data['title']),
  //               );
  //             });
  //       }
  //     },
  //   ),
  // )
  //     Center(
  //   child: Padding(
  //     padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
  //     child: ListView(
  //       children: [
  //         ListTile(
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => DetailPage()));
  //           },
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30)),
  //           tileColor: Colors.brown,
  //           title: Text(
  //             'data....................',
  //             style: TextStyle(color: Colors.brown.shade100),
  //           ),
  //         )
  //       ],
  //     ),
  //   ),
  // ),
  // floatingActionButton: FloatingActionButton(
  //   backgroundColor: Colors.brown,
  //   child: Icon(
  //     Icons.add,
  //     color: Colors.brown.shade100,
  //   ),
  //   onPressed: () {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => AddData()));
  //   },
  // ),

}
