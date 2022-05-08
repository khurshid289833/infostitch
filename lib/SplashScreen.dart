import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/launchScreen.dart';
import 'package:infostitch/screen/myHomePage/myHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences _sharedPreferences;
  bool check;
  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    check = _sharedPreferences.getBool('checkForOnBoard');
    setState(() {});
  }

  @override
  void initState() {
    createSharedPref();
    Timer(Duration(seconds: 2), () => Get.offAll(()=>
    check==true? MyHomePage() : LaunchScreen()
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: EdgeInsets.only(left: scW*0.08,right: scW*0.08),
        child: Image(
          image: AssetImage('images/splash_logo.png'),
          fit: BoxFit.fitWidth,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}