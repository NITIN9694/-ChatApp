

import 'package:bazar/Auth/auth_screen.dart';
import 'package:bazar/Screen/chatscreen.dart';
import 'package:bazar/Widgets/myDrawer.dart';
import 'package:bazar/message/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class lobby extends StatefulWidget {

  @override
  _lobbyState createState() => _lobbyState();
}

class _lobbyState extends State<lobby> {
  String name;
  final TextEditingController _serach= TextEditingController();
  bool isloding =false;
  Map<String,dynamic> usermap;
  String chatRoomid(String user1 ,String user2){
    if(user1[0].toLowerCase().codeUnits[0]>user2.toLowerCase().codeUnits[0]){
      return "$user1$user2";
    }else{
      return "$user2$user1";
    }
  }
  void onSeach()async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isloding =true;
    });
    await _firestore.collection("user").where("username",isEqualTo: _serach.text).get().then((value) {
      setState(() {
        usermap = value.docs[0].data();
        isloding =false;
      });
      print(usermap);
    });
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      drawer:MyDrawer(),
    
      body: Stack (children: [isloding?Container(child: Center(child: CircularProgressIndicator(color: Colors.red ,),),): Container(
        decoration: BoxDecoration(
        color: Colors.white
        ),
        child: Column(
         children: [
          
          Padding(
            padding: const EdgeInsets.only(top:38.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(
                     onPressed:(){
                       Scaffold(drawer: Drawer(),);
                     },
             icon: Icon(Icons.menu,color: Colors.blueAccent,),
           ),
                  Expanded(
                    child: TextFormField(
                       style: TextStyle(color: Colors. blueAccent),
                      controller: _serach,
                      decoration: InputDecoration(
                       helperStyle: TextStyle(color: Colors.blueAccent,
                        ),
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                      ), 
                        hintText: "Search",
                        fillColor: Colors.blueAccent
                        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                        ),
                    ),
                  ),
                   IconButton(icon: Icon(Icons.search,color: Colors.blueAccent,),
                    onPressed: (){
                      onSeach();
                    },
                    ),
                   ],
              ),
            ),
          ),
Expanded(
  child:   Padding(
  
    padding: const EdgeInsets.only(top:28.0),
  
    child:   Container(
    height: MediaQuery.of(context).size.height*0.8,
   decoration: BoxDecoration(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(40),
    topLeft: Radius.circular(40)
  ),
    color: Colors.blueAccent),
  child:
    usermap !=null? Container(
      height: 80,
      child: Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        
decoration: BoxDecoration(

),
   child:Row(
 crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  ClipRRect(
      borderRadius: BorderRadius.circular(60),
   child:  Image.network(usermap["imageurl"]
 ,height: 50,
 width: 100,  
   )),
      Column( crossAxisAlignment: CrossAxisAlignment.start,
  children: [ Text(usermap["username"],style: TextStyle(fontSize: 20,
  color: Colors.white,
      fontWeight: FontWeight.bold),),
  Text(usermap["email"],style: TextStyle(
      color: Colors.white,
      fontSize: 10, ),), ],
  ),
  IconButton(icon: Icon(Icons.message),
  onPressed: (){
      String roomid = chatRoomid(FirebaseAuth.instance.currentUser.displayName, usermap["username"] );
   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Chatscreen(chatroomid: roomid, usermap: usermap,
      )));
   }, ) ],),
   ), ),
    ):Container(),
  
),
  
  ),
) ], 
        ),
      ),
      ]));
  }
 
}