// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            'details',
            style: TextStyle(color: Colors.brown.shade100),
          ),
        ),
        backgroundColor: Colors.brown.shade100,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("posts")
                // .where("${docss["message"]}", isGreaterThanOrEqualTo: 1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return new ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> docss =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  print("$docss");
                  // return getExpenseItems(snapshot);
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.brown.shade200,
                      title: Text(docss['message']),
                      // title: Text(docss['title$index.message']),
                    ),
                  );
                },
              );
            }));
  }

  // getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return snapshot.data!.docs
  //       .map((doc) => Padding(
  //             padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height * 0.1,
  //               child: new Card(
  //                 color: Colors.brown.shade200,
  //                 // onTap: () {
  //                 //   Navigator.push(context,
  //                 //       MaterialPageRoute(builder: (context) => DetailPage()));
  //                 // },
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(top: 10, left: 10),
  //                   child: new Text(doc["message"]),
  //                 ),
  //               ),
  //             ),
  //           ))
  //       .toList();
  // }
}
