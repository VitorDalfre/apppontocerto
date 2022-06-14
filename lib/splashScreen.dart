import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pontocerto/login/loginUI.dart';
import 'package:pontocerto/tools.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

var laranja = Color(0xFFEE8626);
var laranjado = Color(0xFFF07610);

var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.blue, statusBarColor: Colors.transparent);

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goLogin();
  }

  void goLogin() async {
    await Tools().loadDatabase();
    Future.delayed(Duration(milliseconds: 2000), () async {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: LoginUI(),
              duration: Duration(seconds: 1)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: Scaffold(
        //body: Image.asset("assets/image/intro-bg.jpg",fit: BoxFit.fill,),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              Icons.text_snippet,
              color: Colors.white,
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedOpacity(
                          duration: Duration(seconds: 2),
                          opacity: 1,
                          child: Icon(
                            Icons.text_snippet,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
