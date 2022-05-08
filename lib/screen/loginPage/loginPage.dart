import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/otpPage/otpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController phoneController = TextEditingController();
  String ph;

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: scH*0.08),
            child: Image.asset('images/logo_pulse.png',height: 45),
          ),
          Padding(
            padding: EdgeInsets.only(top: scH*0.1),
            child: Center(
              child: Text('Let\'s get Started' ,
                style: TextStyle(fontSize: scW*0.06,color: grey1,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: scH*0.012),
            child: Center(
              child: Text('Login to continue',
                style: TextStyle(fontSize: scW*0.035,color: grey2,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: scW*0.06, right: scW*0.06, top: scH*0.08),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(),
              maxLength: 10,
              controller: phoneController,
              style: TextStyle(color: grey1),
              cursorColor: grey1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call,color: Color.fromRGBO(151, 151, 151, 1),size: scH*0.026,),
                contentPadding: EdgeInsets.symmetric(vertical: 16),
                hintText: 'Enter Mobile Number',
                hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4),fontSize: scW*0.035,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                fillColor: secondColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: secondColor),
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: scW,
            margin: EdgeInsets.only(left: scW*0.35,right: scW*0.35,top: scH*0.03,bottom: scH*0.04),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              color: purpleColor,
              elevation: 10,
              onPressed: (){
                ph = phoneController.text.trim();
                if(ph.length==10){
                  Get.to(OTPPage(ph));
                }else{
                  return
                    Fluttertoast.showToast(
                        msg: "Enter Proper Phone Number",
                        fontSize: 16,
                        backgroundColor: bgColor,
                        textColor: grey1,
                        toastLength: Toast.LENGTH_LONG);
                }
              },
              child: Text('GET OTP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
