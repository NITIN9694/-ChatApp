



import 'package:bazar/Auth/auth_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  final Map<String ,dynamic>usermap;
  final String chatroomid;
  Chatscreen({this.usermap,this.chatroomid});
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  TextEditingController _message= TextEditingController();
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  Size size;
           bool _isme =true;
  Future _send()async{
    FirebaseAuth _auth = FirebaseAuth.instance;
  if(_message.text.isNotEmpty){
    Map<String ,dynamic>message={
      "sendBy":_auth.currentUser.displayName,
      "message":_message.text,
      "time":FieldValue.serverTimestamp()
    
    };
      await  FirebaseFirestore.instance.collection("chatroom").doc(widget.chatroomid).collection("chat").add(
        message
   );
  }else{
    print("Enter Message");
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.usermap["username"].toString()),
      actions: [
        IconButton(icon: Icon(Icons.logout),
        onPressed: (){
        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthScreen()));
        },
        )
      ],
      
      ),
      body:  Scaffold(
          body: Container(child: Column(
            children: <Widget>[
             Expanded(child: 
             StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("chatroom").doc(widget.chatroomid).collection("chat").orderBy("time",descending: false).snapshots(),
             // ignore: missing_return
             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                Map<String,dynamic>map=snapshot.data.docs[index].data();
                return messageTile( map);
                 
                
              
              });
          }else{
            return Container();
          }
             },
             ) ,),
             Stack(children: [
             Container(
           alignment: Alignment.bottomCenter,
                    child: Container(child: Row(
             children: [
               Expanded(child: TextFormField(
                 key: ValueKey("chat"),
                 controller: _message,
                 decoration: InputDecoration(
                   hintText: "Type a message..",
                   border: InputBorder.none
                 ),
               )),
               IconButton(
                  icon: Icon(Icons.send),
                   onPressed: (){
                     _send();
                   }  
                 )
             ],
           ),),
         )
       ],)
            ],
          ),),
      ));
  }
  Widget messageTile(Map<String,dynamic>map){
    return Container(
      alignment: map["sendBy"]==FirebaseAuth.instance.currentUser.displayName?Alignment.centerRight:Alignment.centerLeft,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
         topLeft: Radius.circular(20),
         topRight:  Radius.circular(20),
         bottomLeft:  map["sendBy"]==FirebaseAuth.instance.currentUser.displayName?Radius.circular(20):Radius.circular(0),
         bottomRight:   map["sendBy"]==FirebaseAuth.instance.currentUser.displayName?Radius.circular(00):Radius.circular(20),
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
      child: Text(map["message"],style: TextStyle(color: Colors.white),),
    ),
    );
  }
}
  
  