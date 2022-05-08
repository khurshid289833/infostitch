import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/myHomePage/myHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  int index = 1;

  SharedPreferences _sharedPreferences;
  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('checkForOnBoard', true);
  }

  @override
  void initState() {
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    Widget getData = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: index==1?scW*0.1:index==2?scW*0.08:scW*0.2, right: scW*0.08,top: scH*0.03),
          height: 265,
          child: Image.asset(index==1?'images/launch_image_1.png':index==2?'images/launch_image_2.png':'images/launch_image_3.png'),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: scH*0.04),
            child: Text(index==1?'Find':index==2?'Explore':'Stay Updated',
              style: TextStyle(color: Colors.white,fontSize: scW*0.08,fontWeight: FontWeight.bold,fontFamily: 'assets/Nunito-SemiBold.ttf'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: scH*0.02),
            child: Text(index==1?'Health Care Resources':index==2?'Hospitals Near You':'On Vaccination Centers',
              style: TextStyle(color: Colors.white,fontSize: scW*0.04,fontFamily: 'assets/Nunito-SemiBold.ttf'),
            ),
          ),
        ),
        Row(
          children: [
            if(index==2||index==3)
              Container(
                margin: EdgeInsets.only(left: scW*0.08,top: scH*0.06),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index==2? index=1:index=2;
                    });
                  },
                  child: Image.asset('images/back_arrow.png',height: 53),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: scH*0.06,left: index==1?162:80),
              height: scH*0.008,
              width: index==1?scW*0.06:scW*0.017,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index==1?[Color.fromRGBO(187, 134, 252, 1), Color.fromRGBO(1, 172, 195, 1)]:[Colors.white,Colors.white]
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: scW*0.02,top: scH*0.06),
              height: scH*0.008,
              width: index==2?scW*0.06:scW*0.017,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: index==2?[Color.fromRGBO(187, 134, 252, 1), Color.fromRGBO(1, 172, 195, 1)]:[Colors.white,Colors.white]
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: scW*0.02,top: scH*0.06),
              height: scH*0.008,
              width: index==3?scW*0.06:scW*0.017,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index==3?[Color.fromRGBO(187, 134, 252, 1), Color.fromRGBO(1, 172, 195, 1)]:[Colors.white,Colors.white]
                ),
              ),
            ),
            if(index==1||index==2)
              Container(
                margin: EdgeInsets.only(left: scW*0.2,top: scH*0.06),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index==1? index=2:index=3;
                    });
                  },
                  child: Image.asset('images/front_arrow.png',height: 53),
                ),
              ),
          ],
        ),
        if(index==3)
          Container(
            height: 45,
            width: scW,
            margin: EdgeInsets.only(left: scW*0.33,right: scW*0.33,top: scH*0.02,bottom: scH*0.02),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              color: purpleColor,
              elevation: 10,
              onPressed: (){
                Get.offAll(MyHomePage());
              },
              child: Text('LET\'S GO',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     margin: EdgeInsets.only(top: index==3?scH*0.07:scH*0.15),
        //     height: scH*0.006,
        //     width: scW*0.35,
        //     decoration: BoxDecoration(
        //       color: grey1,
        //       borderRadius: BorderRadius.circular(25),
        //     ),
        //   ),
        // ),
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: scH,
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.only(top: scH*0.06,bottom: scH*0.04),
              child: Image.asset('images/logo_pulse.png',height: 40),
            ),
            Container(
              child: getData,
            ),
          ],
        ),
      ),
    );
  }
}
