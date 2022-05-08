import 'package:flutter/material.dart';
import 'package:infostitch/constant.dart';

class TownHall extends StatefulWidget {
  @override
  _TownHallState createState() => _TownHallState();
}

class _TownHallState extends State<TownHall> {
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
         bell(scH, scW),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
            child: heading('Townhall'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
            child: divider,
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.18,right: scW*0.18,top: scH*0.08),
            child: Image.asset('images/townhall_image.png'),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: scH*0.08),
              child: Text('Something great is in works!',
                style: TextStyle(fontSize: scW*0.045,color: grey1,fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Center(
            child: Text('Coming soon!',
              style: TextStyle(fontSize: scW*0.045,color: grey1,fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
