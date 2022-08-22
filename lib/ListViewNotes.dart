import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'GridviewNores.dart';
import 'AddNote.dart';

class ListViewScreen extends StatelessWidget {
  ListViewScreen({Key? key}) : super(key: key);

  @override
  final firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xff200021),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xff200021),
            title: Text('My Notes'),
            actions: [
              IconButton(
                icon: Icon(Icons.grid_view_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GridViewScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.list_alt_rounded),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListViewScreen()));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddNote()));
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.create_rounded,
              color: Color(0xff200021),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('notes').snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['title'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextButton(onPressed: (){
                                          firestore.runTransaction((Transaction myTransaction) async {
                                            await myTransaction.delete(
                                                snapshot.data!.docs[index].reference);
                                          }
                                          );},
                                          child: Icon(Icons.delete_outlined , color: Colors.black,),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['content'],
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                        );
                      })
                  : snapshot.hasError
                      ? Text('Error is Happened')
                      : CircularProgressIndicator();
            },
          ),
        ));
  }
}
