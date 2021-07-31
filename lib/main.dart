import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sign_up/registration.dart';
import 'package:sign_up/sign_up_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.green, //or set color with: Color(0xFF0000FF)
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin:EdgeInsets.all(20) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child: Image.asset("assets/images/logo.png"),
            ),

            Container(
              child: SignUpView(),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                text: new TextSpan(
                    children: [
                          new TextSpan(
                          text: 'Dont have an account? ',
                          style: new TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "FuturaMedium"),
                        ),

                        new TextSpan(
                          text: 'Sign Up',
                          style: new TextStyle(color: Colors.green,fontSize: 15,decoration: TextDecoration.underline,fontFamily: "FuturaHeavy"),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(PageTransition(curve:Curves.decelerate,type: PageTransitionType.rightToLeft,
                                  child: Registration() ) );
                            },
                        ),
                   ]
                )
             )
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child:Image.asset("assets/images/google_logo.png",
                          width: 30, height: 30,
                      ) ,
                    )
                  ),

                  SizedBox(width:10),

                  Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child:Image.asset("assets/images/facebook_logo.png",
                            width: 30, height: 30,
                        ) ,
                      )
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
