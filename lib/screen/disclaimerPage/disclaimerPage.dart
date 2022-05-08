// import 'package:flutter/material.dart';
// import 'package:infostitch/constant.dart';
//
// class DisclaimerPage extends StatefulWidget {
//   int index;
//   DisclaimerPage(this.index);
//   @override
//   _DisclaimerPageState createState() => _DisclaimerPageState(index);
// }
//
// class _DisclaimerPageState extends State<DisclaimerPage> {
//   int index;
//   _DisclaimerPageState(this.index);
//   @override
//   Widget build(BuildContext context) {
//     final scH = MediaQuery.of(context).size.height;
//     final scW = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         physics: ScrollPhysics(),
//         shrinkWrap: true,
//         children: [
//           cross(scH, scW),
//           Padding(
//             padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
//             child: heading('Disclaimer'),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
//             child: divider,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
//             child: Text('We are working hard to help the society grow!',
//               style: TextStyle(fontSize: scW*0.04,color: grey1,height: 1.5,fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02,right: scW*0.05),
//             child: Text('We shall not entertain any complaints on user/ contributors uploads',
//               style: TextStyle(fontSize: scW*0.04,color: grey1,height: 1.5,fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
