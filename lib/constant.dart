import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'screen/notification/notification.dart';


String imageURL = "http://eqsxerusrangoon.com/cowin/public/";
const bgColor = Color.fromRGBO(18, 18, 18, 0.75);
const secondColor = Color.fromRGBO(47, 47, 47, 1);
const  grey1 = Color.fromRGBO(255, 255, 255, 0.87);
const  grey2 = Color.fromRGBO(255, 255, 255, 0.6);
const  purpleColor = Color.fromRGBO(187, 134, 252, 1);
const  purpleBackground = Color.fromRGBO(58, 53, 63, 1);

Widget cross(height,width) =>  Align(
  alignment: Alignment.topRight,
  child: Padding(
    padding: EdgeInsets.only(right: width*0.07,top: height*0.03),
    child: InkWell(
      onTap: (){
        Get.back();
      },
      child: Image.asset('images/cross.png',height: 17),
    ),
  ),
);

Widget heading(String text) => Text(text,
  style: TextStyle(fontSize: 24,color: Colors.white,fontFamily: 'assets/Nunito-SemiBold.ttf'),
);

final divider = Divider(
color: Color.fromRGBO(255, 255, 255, 0.3),
thickness: 1,
);

final arrowPurple =  Icon(Icons.arrow_forward_ios_sharp,color: purpleColor,size: 25);

Widget bell(height,width) =>  Align(
  alignment: Alignment.topRight,
  child: Padding(
    padding: EdgeInsets.only(right: width*0.07,top: height*0.03),
    child: InkWell(
        onTap: (){
          Get.to(Notifications());
        },
        child: Image.asset('images/bell.png',height: 23),
    ),
  ),
);


