import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/notification/model/notificationModel.dart';
import 'package:infostitch/screen/notification/repository/notificationRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:infostitch/screen/loginPage/loginPage.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {

  NotificationRepository _notificationRepository;
  Future<NotificationModel> _notificationFuture;

  String token;
  SharedPreferences _sharedPreferences;
  Future<void> sharedPreferenceFunction() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");
    if(token==null){
      Get.back();
      Get.to(LoginPage());
    }
    _notificationRepository = NotificationRepository();
    _notificationFuture = _notificationRepository.notificationRepositoryFunction(token);
    setState(() {});
  }

  @override
  void initState() {
    sharedPreferenceFunction();
    super.initState();
  }
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
         cross(scH, scW),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.005),
            child: heading('Notifications'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05,bottom: scH*0.04),
            child: divider,
          ),
          // Row(
          //   children: [
          //     Container(
          //       height: 33,
          //       width: scW*0.2,
          //       margin: EdgeInsets.only(left: scW*0.05,top: scH*0.005,bottom: scH*0.08),
          //       decoration: BoxDecoration(
          //         color: purpleBackground,
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Center(
          //         child: Text('All',
          //           style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          FutureBuilder<NotificationModel>(
            future: _notificationFuture,
            builder: (context,snapshot) {
              if(snapshot.hasData) {
                if(snapshot.data.data.isNotEmpty){
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context,index) =>
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: scW*0.06,top: scH*0.01),
                                    child: Image.asset('images/mark.png',height: 19),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13),
                                        child: Text('Notification',
                                          style: TextStyle(color: grey1,fontSize: scW*0.04,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
                                        child: Text("Date of vaccine : ${snapshot.data.data[index].dateVaccine}",
                                          style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
                                        child: Text("Vaccine Name : ${snapshot.data.data[index].vaccine??''}",
                                          style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
                                        child: Text("Dose : ${snapshot.data.data[index].dose??''}",
                                          style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
                                        child: Text("Age : ${snapshot.data.data[index].age??''}",
                                          style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
                                        child: Row(
                                          children: [
                                            Text("Status : ",
                                              style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                            ),
                                            Text("${snapshot.data.data[index].status}",
                                              style: TextStyle(color: snapshot.data.data[index].status=="opened"?purpleColor:grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: scW*0.23,right: scW*0.05,top: scH*0.01,bottom: scH*0.03),
                              child: divider,
                            ),
                          ],
                        )
                  );
                }else{
                  return Container(
                    height: scH*0.6,
                    child: Center(
                      child: Text("You don't have any notification",
                        style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                      ),
                    ),
                  );
                }
              }else if(snapshot.hasError) {
                print(snapshot.error);
                return Container(
                  height: scH*0.6,
                  child: Center(
                    child: Text("Something went wrong please try again",
                      style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                );
              }else {
                return Container(
                  height: scH*0.6,
                  child: Center(child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        grey1
                    ),
                  ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
