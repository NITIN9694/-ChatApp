import 'package:bazar/Screen/chatscreen.dart';
import 'package:bazar/Screen/looby.dart';
import 'package:bazar/message/chat.dart';
import 'package:flutter/material.dart';

class Authform extends StatefulWidget {
  Authform(
    this.submit,
    this.isloding,
  );
  bool isloding;
  final void Function(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  )submit;
  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey=GlobalKey<FormState>();
var _islogin =true;
  var _userEmail="";
   var _username="";
    var _userpass="";
  void _trySubmit(){
      widget.isloding ?Navigator.push(context, MaterialPageRoute(builder: (ctx)=>lobby(
       
      ))):CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  );
    FocusScope.of(context).unfocus();
    final valied =_formkey.currentState.validate();
    if(valied){
      _formkey.currentState.save();
      widget.submit(
        _userEmail.trim(),
        _userpass.trim(),
        _username.trim(),
        _islogin,
        context,
              );
    }
  }
  @override
  Widget build(BuildContext context) {
    return 
       Center(
        child: Card(
           margin: EdgeInsets.all(20),
           child: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(20),
           child: Form(
             key: _formkey,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                TextFormField(
                  key: ValueKey("email"),
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter valid email";
                    }
                    return null;
                  },
                 keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration(
                   labelText: "Email Addresh"
                 ),
                 onSaved: (value){
                   _userEmail =value;
                 },
                ),
                if(!_islogin)
                   TextFormField(
                     key: ValueKey("name"),
                  onSaved: (value){
                   _username =value;
                 },
                  validator: (value){
                    if(value.isEmpty ){
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "User Name"),
                ),
                
                
                TextFormField(
                  key: ValueKey("pass"),
                  onSaved: (value){
                 _userpass = value;
                  },
                  validator: (value){
                    if(value.isEmpty ||value.length<7){
                      return "Please Must be at least 7 charcters";
                    }
                    return  null;
                    
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 20,
                ),
               
              
                RaisedButton(onPressed: (){
                  _trySubmit();
           
                },
                child: Text(_islogin?"Login":"SingUp"),
                ),
               
                FlatButton(onPressed: (){
                  setState(() {
                    _islogin =! _islogin;
                  });
                }, child: Text(_islogin?"Creat new account ":"I alredy have an account"))
               ],
             ),
           ),
           )
           ),
        ) ,
      ); 
    
  }
}