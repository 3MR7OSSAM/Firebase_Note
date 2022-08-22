import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'GridviewNores.dart';
class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);
  TextEditingController _title = new TextEditingController();
  TextEditingController _content = new TextEditingController();

  @override
  String? NoteContent ;
  String? NoteTitle;

  final firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff200021),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff200021),
          leading: BackButton(
            onPressed: () {
              firestore.collection('notes').add({
                'title': NoteTitle,
                'content':NoteContent ,
              });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GridViewScreen()));
            },
            color: Colors.white, // <-- SEE HERE
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 16),
              child: TextField(
                  controller: _title,
                  onChanged: (value){
                    NoteTitle = value.toString();
                    print(NoteTitle);
                  },
                  cursorColor: Colors.white54,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 25),
                  )),

            ),

            Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                  controller: _content,
                  onChanged: (value){
                    NoteContent = value.toString();
                    print(NoteContent);
                  },
                  cursorColor: Colors.white54, //<-- SEE HERE
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "Note",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),

    );
  }
}
