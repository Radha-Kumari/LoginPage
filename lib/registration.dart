import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  GlobalKey<FormState> _registrationKey=new GlobalKey();

  TextEditingController _fullNameController=new TextEditingController();
  TextEditingController _userNameController=new TextEditingController();
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _phoneController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  TextEditingController _confirmPswdController=new TextEditingController();

  FocusNode _focusFullName=new FocusNode();
  FocusNode _focusUserName=new FocusNode();
  FocusNode _focusEmail=new FocusNode();
  FocusNode _focusPhone=new FocusNode();
  FocusNode _focusPassword=new FocusNode();
  FocusNode _focusConfirmPswd=new FocusNode();

  bool _agreeChecked=false;
  bool progress=false;
  bool obscure=true;
  bool cpObscure=true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _userNameController.dispose();
    _passwordController.dispose();
    _focusFullName.dispose();
    _focusUserName.dispose();
    _focusEmail=new FocusNode();
    _focusPhone.dispose();
    _focusPassword.dispose();
    _focusConfirmPswd.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _confirmPswdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:EdgeInsets.all(20) ,
        child: Form(
          autovalidate: false,
          key: _registrationKey,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                child: Image.asset("assets/images/logo.png"),
              ),

              Expanded(
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      Container(
                        child:TextFormField(
                          keyboardType:TextInputType.text,
                          maxLines: 1,
                          onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusFullName);  });},
                          style:TextStyle(fontFamily: "FuturaMedium"),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,color:_focusFullName.hasFocus ? Colors.black87 : Colors.black54),
                            labelText: "Full name",
                            labelStyle: TextStyle(color:_focusFullName.hasFocus ? Colors.black87: Colors.black54),
                            enabledBorder:UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                          focusNode: _focusFullName,
                          validator: validateFullNameField,
                          controller: _fullNameController
                        ),
                      ),

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
                          controller: _userNameController,
                        ),
                      ),

                      Container(
                        child:TextFormField(
                          keyboardType:TextInputType.text,
                          maxLines: 1,
                          onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusEmail);  });},
                          style:TextStyle(fontFamily: "FuturaMedium"),
                          decoration: InputDecoration(
                            labelText: "Email ID",
                            prefixIcon: Icon(Icons.email_outlined,color:_focusEmail.hasFocus ? Colors.black87 : Colors.black54),
                            labelStyle: TextStyle(color:_focusEmail.hasFocus ? Colors.black87 : Colors.black54),
                            enabledBorder:UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                          focusNode: _focusEmail,
                          validator: validateEmailField,
                          controller: _emailController,
                        ),
                      ),

                      Container(
                        child:TextFormField(
                          keyboardType:TextInputType.number,
                          maxLines: 1,
                          onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusPhone);  });},
                          style:TextStyle(fontFamily: "FuturaMedium"),
                          decoration: InputDecoration(
                            labelText: "+91 | Phone no",
                            labelStyle: TextStyle(color:_focusPhone.hasFocus ? Colors.black87 : Colors.black54),
                            enabledBorder:UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                          focusNode: _focusPhone,
                           validator: validatePhoneField,
                          controller: _phoneController,
                        ),
                      ),


                      Container(
                        child:TextFormField(
                          keyboardType:TextInputType.text,
                          maxLines: 1,
                          onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusPassword);  });},
                          style:TextStyle(fontFamily: "FuturaMedium"),
                          obscureText: obscure,
                          decoration: InputDecoration(
                            suffix: InkWell(
                                onTap:(){ setState(() { obscure=!obscure; });  } ,
                                child:Container(
                                  child:Icon(!obscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                                      color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                                )
                            ),
                            prefixIcon: Icon(Icons.lock_outline,color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                            labelText: "Password",
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

                      Container(
                        child:TextFormField(
                          keyboardType:TextInputType.text,
                          maxLines: 1,
                          onTap: (){  setState(() {  FocusScope.of(context).requestFocus(_focusConfirmPswd);  });},
                          style:TextStyle(fontFamily: "FuturaMedium"),
                          obscureText: cpObscure,
                          decoration: InputDecoration(
                            labelText: " Confirm password",
                            suffix: InkWell(
                                onTap:(){ setState(() { cpObscure=!cpObscure; });  } ,
                                child:Container(
                                  child:Icon(!cpObscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,color:_focusConfirmPswd.hasFocus ? Colors.black87 : Colors.black54),
                                )
                            ),
                            prefixIcon: Icon(Icons.lock_outline,color:_focusPassword.hasFocus ? Colors.black87 : Colors.black54),
                            labelStyle: TextStyle(color:_focusConfirmPswd.hasFocus ? Colors.black87 : Colors.black54),
                            enabledBorder:UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                          focusNode: _focusConfirmPswd,
                          validator: validateConfirmPasswordField,
                          controller: _confirmPswdController,
                        ),
                      ),

                      Container(
                          child:Row(
                            children: <Widget>[

                              Container(
                                child:Checkbox(
                                  value: _agreeChecked,
                                  activeColor:Colors.green ,
                                  onChanged: (bool selected) {
                                    setState((){  _agreeChecked = selected;  });
                                  },
                                ),
                              ),

                              Flexible(
                                child:Container(
                                  child:new RichText(
                                    text: new TextSpan(
                                      children: [
                                        new TextSpan(
                                          text: 'I agree ',
                                          style: new TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "FuturaMedium"),
                                        ),
                                        new TextSpan(
                                          text: 'Terms',
                                          style: new TextStyle(color: Colors.green,fontSize: 15,decoration: TextDecoration.underline,fontFamily: "FuturaHeavy"),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {  },
                                        ),
                                        new TextSpan(
                                          text:' & ',
                                          style: new TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "FuturaMedium"),
                                        ),
                                        new TextSpan(
                                            text: 'Conditions',
                                            style:new TextStyle(color: Colors.green,fontSize: 15,decoration: TextDecoration.underline,fontFamily: "FuturaHeavy"),
                                            recognizer: new TapGestureRecognizer()
                                              ..onTap = () {  }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          )
                      ),

                      InkWell(
                        onTap: (){

                          FocusScope.of(context).requestFocus(new FocusNode());

                          setState(() {
                            progress=true;
                            if(_registrationKey.currentState.validate()) userRegistration();
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
                            child:AutoSizeText("Sign Up",minFontSize: 16,maxFontSize: 20,
                                style: TextStyle(fontFamily:"FuturaHeavy",color: Colors.white))
                        ),
                      ),


                    ],
                  ),
                ),
              ),


            ],
          ) ,
        ),
      ),
    );
  }

  userRegistration()async{

    try{

      var param=json.encode({
        "email": "${_emailController.text}",
        "password":"${_passwordController.text}",
        "full_name": "${_fullNameController.text}",
        "country_code": "+91",
        "contact_number":"${_phoneController.text}",
        "country_code_name": "IN",
        "user_device_id": "postman",
        "fcm_token": "123456",
        "username": "${_userNameController.text}",
        "user_type": "counter",
        "login_type": "Email",
      });

      print("param...$param");

      var url="https://smartparking.xceltec.in/public/api/register";

      final response=await http.Client().post(url,body: param);

      print("Registration response... ${response.body}");

      var data=json.decode(response.body);


      setState(() {

        progress=false;

        Navigator.of(context,rootNavigator: true).pop();

        if(data["code"]==200 && data["data"]!=null)
          Flushbar(
            message: 'You have register successfully.',
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

      Navigator.of(context,rootNavigator: true).pop();

      Flushbar(
        message: 'Something went wrong !!',
        duration: Duration(seconds: 3),
      )..show(context);

    }
  }//func


  String validateFullNameField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusFullName);
      return 'Field Required';
    }
    return null;
  }

  String validateUseNameField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusUserName);
      return 'Field Required';
    }
    return null;
  }


  String validateEmailField(String value) {
    String pattern = r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusEmail);
      return 'Field Required';
    } else if (value.length != 0 && !regExp.hasMatch(value.trim())) {
      FocusScope.of(context).requestFocus(_focusEmail);
      return 'Please enter valid email';
    }
    return null;
  }

  String validatePhoneField(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusPhone);
      return 'Field Required';
    }
    else if (value.length!=10) {
      FocusScope.of(context).requestFocus(_focusPhone);
      return "Please enter valid number.";
    }
    else if (value.length!=0 && !regExp.hasMatch(value)) {
      FocusScope.of(context).requestFocus(_focusPhone);
      return "Field must be number.";
    }
    return null;
  }

  String validatePasswordField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_focusPassword);
      return 'Field Required';
    }
    return null;
  }

  String validateConfirmPasswordField(String value) {
    if ("${_passwordController.text}"!="$value") {
      FocusScope.of(context).requestFocus(_focusConfirmPswd);
      return 'Password and Confirm password should be same.';
    }
    return null;
  }


}
