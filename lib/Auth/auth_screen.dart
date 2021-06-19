import 'dart:math';

import 'package:bazar/Widgets/authwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 
 final _auth =FirebaseAuth.instance;
 bool isloding = false;
  Future _submit(
    String email,
    String password,
    String username,
    
    bool islogin,
    BuildContext ctx,
  )async{
    try{
  if(islogin){
   setState(() {
     isloding = true;
   });
   
   UserCredential  authresult =await _auth.signInWithEmailAndPassword(email: email, password: password);
   User user= authresult.user;
   return user;
  }else{
  setState(() {
    isloding =true;
  });
    UserCredential authresult =await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
     User user = authresult.user;
      user.updateProfile(displayName: username);
      await  FirebaseFirestore.instance.collection("user").doc(authresult.user.uid).set(
        {
          "username":username,
          "email":email,
        
        }
      );
      return user;
  }

  }on PlatformException catch(e){
    setState(() {
      isloding = false;
    });
  var  messsage = "An Error occured , Please check your credetuals";
  if(e.message != null){
    messsage = e.message;
  }
  Scaffold.of(ctx).showSnackBar(SnackBar(
    backgroundColor: Colors.white,
    content: Text(messsage,style: TextStyle(color: Colors.red),)));
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.blueAccent,
    body: Authform(_submit,isloding)
    );
  }
}