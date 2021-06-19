import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Chat extends StatefulWidget {


  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection("chat").doc(FirebaseAuth.instance.currentUser.email).collection("message");  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: collectionReference.snapshots(),
      builder: (BuildContext ctx,  AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
           return Center(child: CircularProgressIndicator(),);
         }{
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        final docum = snapshot.data.docs;
       return ListView.builder(
         itemCount:docum.length,
         itemBuilder: (context,index){
           var getdata =snapshot.data.docs[index];
           return  Text(docum[index]["message"],);
         });
         }

      }
    );
}
}