import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class SignUpView extends StatefulWidget {

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  GlobalKey<FormState> _loginKey=new GlobalKey();

  TextEditingController _userNameController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();

  FocusNode _focusUserName=new FocusNode();
  FocusNode _focusPassword=new FocusNode();

  bool progress=false;
  bool obscure=true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _focusPassword.dispose();
    _focusUserName.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
         child: Form(
           autovalidate: false,
           key: _loginKey,
           child: Column(
             children: [

               Container(
                 child:TextFormField(
                   keyboardType:TextInputType.text,
                   maxLines: 1,
                   onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusUserName);  });},
                   style:TextStyle(fontFamily: "FuturaMedium"),
                   decoration: InputDecoration(
                     prefixIcon: Icon(Icons.person,color:_focusUserName.hasFocus ? Colors.black87 : Colors.black54),
                     labelText: "User name",
                     labelStyle: TextStyle(color:_focusUserName.hasFocus ? Colors.black87 : Colors.black54),
                     enabledBorder:UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     ),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.black87),
                     ),
                   ),
                   focusNode: _focusUserName,
                   validator: validateUseNameField,
                   controller: _userNameController
                 ),
               ),

               Container(
                 child:TextFormField(
                   keyboardType:TextInputType.text,
                   maxLines: 1,
                   obscureText: obscure,
                   onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusPassword);  });},
                   style:TextStyle(fontFamily: "FuturaMedium"),
                   decoration: InputDecoration(
                     labelText: "Password",
                     suffix: InkWell(
                       onTap:(){ setState(() { obscure=!obscure; });  } ,
                       child:Container(
                         child:Icon(!obscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                       )
                     ),
                     prefixIcon: Icon(Icons.lock_outline,color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                     labelStyle: TextStyle(color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                     enabledBorder:UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     ),
                     focusedBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.black87),
                     ),
                   ),
                   validator: validatePasswordField,
                   focusNode: _focusPassword,
                   controller: _passwordController,
                 ),
               ),

               progress
               ? Container( margin: EdgeInsets.only(top:20),child: CircularProgressIndicator(),)
               :InkWell(
                 onTap: (){

                   FocusScope.of(context).requestFocus(new FocusNode());

                   setState(() {
                     progress=true;
                     if(_loginKey.currentState.validate()) userLogin();
                     else  progress=false;
                   });
                 },
                 child: Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.only(top:10,bottom: 10),
                   width: MediaQuery.of(context).size.width,
                   margin: EdgeInsets.only(top:20),
                   decoration: BoxDecoration(
                     color: Colors.green,
                       borderRadius:BorderRadius.all(Radius.circular(8),)
                   ),
                   child:AutoSizeText("Log In",minFontSize: 16,maxFontSize: 20,
                           style: TextStyle(fontFamily:"FuturaHeavy",color: Colors.white))
                 ),
               ),

             ],
           ),
         ),
    );
  }

  userLogin()async{

    try{

      var param={
        "password":"${_passwordController.text}",
        "user_device_id": "postman",
        "fcm_token": "123456",
        "username": "${_userNameController.text}",
        "user_type": "user",
      };

      print("param...$param");

      var url="https://smartparking.xceltec.in/public/api/login";

      final response=await http.Client().post(url,body: param);

      print("Login response... ${response.body}");

      var data=json.decode(response.body);

      setState(() {

        progress=false;

        if(data["code"]==200 && data["data"]!=null)
          Flushbar(
            message: 'You have login successfully.',
            duration: Duration(seconds: 3),
          )..show(context);

        else
          Flushbar(
            message: 'Sign up failed !!',
            duration: Duration(seconds: 3),
          )..show(context);
      });

    }catch(e){
      print("Exception occurs:$e");
      setState(() { progress=false; });
      Flushbar(
        message: 'Something went wrong !!',
        duration: Duration(seconds: 3),
      )..show(context);

    }
  }//func

  String validateUseNameField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusUserName);
      return 'Field Required.';
    }
    return null;
  }

  String validatePasswordField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusPassword);
      return 'Field Required.';
    }
    return null;
  }

}
