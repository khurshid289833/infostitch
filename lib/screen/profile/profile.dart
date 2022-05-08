import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/accountPage/accountPage.dart';
import 'package:infostitch/screen/loginPage/loginPage.dart';
import 'package:infostitch/screen/manageSaved/manageSaved.dart';
import 'package:infostitch/screen/notification/notification.dart';
import 'package:infostitch/screen/settingPage/settingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  SharedPreferences _sharedPreferences;
  String image;
  String name;
  String email;
  String token="";

  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");
    image = _sharedPreferences.getString("profile_picture");
    name = _sharedPreferences.getString("name");
    email = _sharedPreferences.getString("email");
    setState(() {});
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
    Widget rowProfile(heading,subHeading) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: scH*0.005,left: scW*0.08),
              child: Text(heading,
                style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: scH*0.006,left: scW*0.08),
              child: Text(subHeading,
                style: TextStyle(fontSize: scW*0.035,color: grey2,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: scW*0.08,top: scH*0.01),
          child: arrowPurple,
        ),
      ],
    );
    return Scaffold(
      backgroundColor: bgColor,
      body: token!=null?
      ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: scW*0.07,top: scH*0.03),
              child: InkWell(
                  onTap: (){
                    Get.to(SettingPage()).then((value) => {initState()});
                  },
                  child: Image.asset('images/icon_settings.png',height: 23)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
            child: heading('Profile'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05,top: scH*0.005),
            child: divider,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(top: scH*0.004),
          //       child: Text('Contributor ',
          //         style: TextStyle(fontSize: scW*0.03,color: purpleColor,fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(left: scW*0.003,right: scW*0.05,top: scH*0.003),
          //       child: Image.asset("images/bookmark_color.png",height: scH*0.02),
          //     )
          //   ],
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: grey1,
                  backgroundImage: image!=null?NetworkImage('$imageURL${image}'):AssetImage('images/profile_pic.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.04,top: scH*0.02),
                    child: Text(name!=null?name:'',
                      style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.04,top: scH*0.01),
                    child: Text(email!=null?email:'',
                      style: TextStyle(fontSize: scW*0.035,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: scH*0.0,right: scW*0.05),
              child: Text('User Account',
                style: TextStyle(color: grey2,fontSize: scW*0.035,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05,top: scH*0.005,bottom: scH*0.035),
            child: divider,
          ),
          InkWell(
            onTap: (){
              Get.to(AccountPage());
            },
            child: rowProfile('Account', 'Manage your account'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.08,right: scW*0.05,top: scH*0.008),
            child: divider,
          ),
          InkWell(
            onTap: (){
              Get.to(Notifications());
            },
            child: rowProfile('Notifications', 'Manage your notifications'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.08,right: scW*0.05,top: scH*0.008),
            child: divider,
          ),
          // InkWell(
          //   onTap: (){},
          //   child: rowProfile('Activity', 'Manage your activity'),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: scW*0.08,right: scW*0.05,top: scH*0.008),
          //   child: divider,
          // ),
          InkWell(
            onTap: (){
              Get.to(ManageSaved());
            },
            child: rowProfile('Saved', 'Manage your saved items here'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.08,right: scW*0.05,top: scH*0.008),
            child: divider,
          ),
        ],
      ):
      ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: scH*0.2),
            child: Image.asset('images/sad_logout.png',height: scH*0.12),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: scH*0.04),
              child: Text('Oops! You are logged out',
                style: TextStyle(fontSize: scW*0.04,color: grey1,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: scH*0.015),
              child: Text('Please Login first to see your profile',
                style: TextStyle(fontSize: scW*0.04,color: grey2,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Container(
            height: 45,
            width: scW,
            margin: EdgeInsets.only(left: scW*0.33,right: scW*0.33,top: scH*0.06,bottom: scH*0.04),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              color: purpleColor,
              elevation: 10,
              onPressed: (){
                Get.to(LoginPage());
              },
              child: Text('LOGIN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
