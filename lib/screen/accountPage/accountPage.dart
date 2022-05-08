import 'package:flutter/material.dart';
import 'package:infostitch/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  SharedPreferences _sharedPreferences;
  String picture;
  String name;
  String email;
  String phone;
  bool streamCheck = false;

  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    picture = _sharedPreferences.getString("profile_picture");
    name = _sharedPreferences.getString("name");
    email = _sharedPreferences.getString("email");
    phone = _sharedPreferences.getString("phone");
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
    Widget row(icon,heading,subHeading,altHeading) => Row(
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
              Text(subHeading??altHeading,
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
            child: heading('Account Details'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
            child: divider,
          ),
          Padding(
            padding: EdgeInsets.only(top: scH*0.03,bottom: scH*0.05),
            child:  CircleAvatar(
              radius: 45,
              backgroundColor: grey1,
              child: CircleAvatar(
                  radius: 44,
                  backgroundColor: grey1,
                  backgroundImage: picture!=null?NetworkImage("$imageURL${picture}"):AssetImage("images/profile_pic.png"),
              ),
            ),
          ),
          row(Icon(Icons.person,color: grey1,size: 30), "Name", name, "Name not available"),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.05),
            child: divider,
          ),
          row(Icon(Icons.email,color: grey1,size: 30), "Email", email, "Email not available"),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.05),
            child: divider,
          ),
          row(Icon(Icons.phone_android,color: grey1,size: 30), "Phone", phone, "Phone not available"),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.05),
            child: divider,
          ),
        ],
      ),
    );
  }
}
