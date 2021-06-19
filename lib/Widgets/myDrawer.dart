import 'dart:io';

import 'package:bazar/Auth/auth_screen.dart';
import 'package:bazar/Screen/Profile.dart';
import 'package:bazar/Screen/looby.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatefulWidget {


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var pic = FirebaseAuth.instance.currentUser.photoURL;
  // File _image;
  // final picker = ImagePicker();

  // Future getImage() async {
  //   PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  // Future _uplode()async{
  //    UserCredential authresult;
  //    User user = authresult.user;
  //     user.updateProfile(photoURL: getImage.toString());
  //     await  FirebaseFirestore.instance.collection("user").doc(authresult.user.uid).set(
  //       {
  //         "imageurl":_image.toString()
        
  //       }
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueAccent,
            child: Image.network(FirebaseAuth.instance.currentUser.photoURL,fit: BoxFit.fill,)
            ),
            Row(
              children: [
                Text("Update Profiel"),
                IconButton(icon:Icon(Icons.upload),
      onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Profile()));
      
      },
      ),
              ],
            ), 
            Row(
              children: [
                Text("Logout"),
                IconButton(icon:Icon(Icons.logout),
      onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthScreen()));
        FirebaseAuth.instance.signOut();
      },
      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}