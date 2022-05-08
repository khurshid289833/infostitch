import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/myHomePage/myHomePage.dart';
import 'package:infostitch/screen/profile/profileUpdate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SharedPreferences _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    Widget row(icon,heading,subHeading) => Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: scH*0.01,left: scW*0.05),
          child: icon,
        ),
        Padding(
          padding: EdgeInsets.only(top: scH*0.015,left: scW*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                style: TextStyle(color: grey1,fontWeight: FontWeight.bold),
              ),
              Text(subHeading,
                style: TextStyle(color: grey2,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          cross(scH, scW),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.005),
            child: heading('Settings'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05,bottom: scH*0.0),
            child: divider,
          ),
          InkWell(
            onTap: (){
              Get.to(ProfileUpdate());
            },
            child: row(Icon(Icons.edit_outlined,color: grey1,size: 30), "Update", "Update your profile",),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.05),
            child: divider,
          ),
          InkWell(
            onTap: ()async{
              _sharedPreferences = await SharedPreferences.getInstance();
              await _sharedPreferences.remove("access_token");
              await _sharedPreferences.remove("name");
              await _sharedPreferences.remove("phone");
              await _sharedPreferences.remove("email");
              await _sharedPreferences.remove("device_id");
              await _sharedPreferences.remove("profile_picture");
              await _sharedPreferences.remove("user_id");
              Fluttertoast.showToast(
                  msg: "Logout Successfull",
                  fontSize: 16,
                  backgroundColor: bgColor,
                  textColor: grey1,
                  toastLength: Toast.LENGTH_LONG);
              Get.offAll(MyHomePage());
            },
            child: row(Icon(Icons.logout,color: grey1,size: 30), "Logout", "Logout from this device",),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.05),
            child: divider,
          ),
        ],
      ),
    );
  }
}
