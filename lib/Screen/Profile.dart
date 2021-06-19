
import 'dart:io';

import 'package:bazar/Screen/looby.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {



  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isphoto= false;
File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pt = await picker.getImage(source: ImageSource.gallery);
  
    setState(() {
      _image =File(pt.path);
    });
  }
  Future _uplode()async{
    setState(() {
      isphoto =true;
    });
  
   var ok =  FirebaseAuth.instance.currentUser;
    
    
      


      var task =       
    FirebaseStorage.instance
          .ref()
          .child("imagesend")
          .child("${ok.uid}.jpg").putFile(_image);
      var dowloadedUrl = await (await task).ref.getDownloadURL();
      
    await  FirebaseFirestore.instance.collection("user").doc(ok.uid).update(
        {
          "imageurl":dowloadedUrl,
        
        } 
      );
        ok.updateProfile(photoURL:dowloadedUrl);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
        color: Colors.blueAccent
        ),
        child: Stack(
          
          children:[ 
           
            Center(child: GestureDetector(
            onTap: getImage,
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.6,
               decoration: BoxDecoration(
                 color:  Colors.white,
                borderRadius: BorderRadius.circular(400),
                border: Border.all(
                  color: Colors.black38
                )
              ),
          child:
              Center(
                child: isphoto ?Image.file(_image,fit: BoxFit.fill,):
                 Icon(Icons.person_add),
                ),
             
          
            ),
          ),),
          Padding(
            padding: const EdgeInsets.only(bottom:28.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child:  GestureDetector(
                onTap: (){
                  _uplode();
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>lobby()));
                },
                child: Container(
                    height: 40,
                    width: 85,
                   decoration:BoxDecoration(
                    boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1), //(x,y)
                      blurRadius: 2,
                    ),
                  ],
                          borderRadius: BorderRadius.circular(20),
                          color:Colors.white
                        ),
                        child: Center(child: Text("Uplode",style: TextStyle(fontWeight: FontWeight.bold),)),
                  
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top:38.0,right: 20),
              child: GestureDetector(
                onTap: (){
                    
                },
                child: Container(
                  height: 30,
                  width: 70,
                  
                  child: Center(child: Icon(Icons.arrow_forward_ios,color: Colors.white,),),
                    
                  ),
                  ),
              ),
            
          ),
          ]),
      ),
    );
  }
}