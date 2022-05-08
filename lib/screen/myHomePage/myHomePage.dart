import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/home.dart';
import 'package:infostitch/screen/districtListing/model/districtListingModel.dart';
import 'package:infostitch/screen/districtListing/repository/districtListingRepository.dart';
import 'package:infostitch/screen/myHomePage/cityListing/model/cityListingModel.dart';
import 'package:infostitch/screen/myHomePage/cityListing/repository/cityListingRepository.dart';
import 'package:infostitch/screen/stateListing/model/stateListingModel.dart';
import 'package:infostitch/screen/stateListing/repository/stateListingRepository.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index;
  TextEditingController pinCodeController;
  String cityName;
  String _dropDownStateValue;
  String _dropDownDistrictValue;
  bool waitForDistrict=true;
  List<String> dropdown1=[];
  List<int> dropdownStateId=[];
  List<String> dropdown2=[];
  List<int> dropdownDistrictId=[];
  int districtId;
  bool textSize;
  bool waitForCityLoad = false;

  Future<StateListingModel> _stateListingFuture;
  StateListingRepository _stateListingRepository;

  Future<DistrictListingModel> _districtListingFuture;
  DistrictListingRepository _districtListingRepository;

  Future<CityListingModel> _cityListingFuture;
  CityListingRepository _cityListingRepository;

  @override
  void initState() {
    index = 0;
    pinCodeController = TextEditingController();
    _stateListingRepository = StateListingRepository();
    _stateListingFuture = _stateListingRepository.StateListingRepositoryFunction();
    _districtListingRepository = DistrictListingRepository();
    _cityListingRepository = CityListingRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    Widget textHeading(text,size) =>  Text(text,
      style: TextStyle(fontSize: size,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
    );
    Widget _returnWidget(){
      return index==0?
      Container(
        height: 170,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.06,top: scH*0.03),//scH*0.05
                      child: textHeading('Enter Pincode', scW*0.04),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: scW*0.06,top: 16),
                          height: 25,
                          width: scW*0.38,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: secondColor
                          ),
                        ),
                        Container(
                          width: scW*0.34,
                          height: 53,
                          margin: EdgeInsets.only(left: scW*0.078),
                          child: PinCodeFields(
                            length: 6,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            controller: pinCodeController,
                            padding: EdgeInsets.only(top: 1),
                            textStyle: TextStyle(color: grey1,fontSize: 11.5),
                            activeBorderColor: Color.fromRGBO(255, 255, 255, 0.2),
                            borderColor: Color.fromRGBO(255, 255, 255, 0.2),
                            onComplete: (value){
                              setState(() {
                                waitForCityLoad=true;
                              });
                              int pin = int.parse(value);
                              _cityListingFuture = _cityListingRepository.cityListingRepositoryFunction(pin);
                              _cityListingFuture.whenComplete(() =>
                                  setState(() {
                                    waitForCityLoad=false;
                                  })
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: scW*0.06,top: scH*0.03),//scH*0.045
                  height: scH*0.12,
                  width: scW*0.002,
                  color: Color.fromRGBO(101, 101, 101, 1),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: scH*0.03,right: scW*0.05,left: scW*0.07),//scH*0.05
                      child: textHeading('City', scW*0.04),
                    ),
                    FutureBuilder<CityListingModel>(
                        future: _cityListingFuture,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            Future.delayed(Duration.zero, () async {
                              setState(() {
                                cityName = snapshot.data.count>0?snapshot.data.data[0].cityName:null;
                                snapshot.data.data[0].cityName.length>9?textSize = true:textSize=false;
                              });
                            });
                            return Container(
                              width: scW*0.4,
                              padding: EdgeInsets.only(top: scH*0.025,right: scW*0.05,left: scW*0.12),
                              child: Text(snapshot.data.count>0?snapshot.data.data[0].cityName:'',
                                style: TextStyle(fontSize: textSize==true?scW*0.03:scW*0.04,color: grey2,letterSpacing: 1.5,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                              ),
                            );
                          }else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Container();
                          }else {
                            return Container();
                          }
                        }
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
              height: scH*0.001,
              color: Color.fromRGBO(101, 101, 101, 1),
            ),
          ],
        ),
      ):
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: scW*0.05,top: scH*0.03),
                      child: textHeading('State', scW*0.04)
                  ),
                  FutureBuilder<StateListingModel>(
                      future: _stateListingFuture,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          dropdown1.clear();
                          for(int i=0;i<snapshot.data.data.length;i++){
                            dropdown1.add(snapshot.data.data[i].name);
                            dropdownStateId.add(int.parse(snapshot.data.data[i].id));
                          }
                          return Container(
                            width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                            color: secondColor,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: dropdown1.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    setState(() {
                                      _dropDownStateValue = value;
                                      int a= dropdown1.indexOf(_dropDownStateValue);
                                      int b= dropdownStateId[a];
                                      print(b);
                                      waitForDistrict = true;
                                      _dropDownDistrictValue=null;
                                      _districtListingFuture = _districtListingRepository.districtListingRepositoryFunction(b);
                                      _districtListingFuture.whenComplete(() =>
                                          setState(() {
                                            waitForDistrict=false;
                                          }
                                          ));
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down_sharp,size: scH*0.038,color: Color.fromRGBO(255, 255, 255, 0.4),),
                                  hint: _dropDownStateValue==null?Text('Select State',
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ):
                                  Text(_dropDownStateValue,
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ),
                                  style: TextStyle(color: Colors.black,fontSize: scW*0.035),
                                ),
                              ),
                            ),
                          );
                        }else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Container(
                            width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                            color: secondColor,
                          );
                        }else {
                          return Container(
                            width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                            color: secondColor,
                          );
                        }
                      }
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.03,top: scH*0.03,right: scW*0.05),
                    child: textHeading('District', scW*0.04),
                  ),
                  waitForDistrict==false?
                  FutureBuilder<DistrictListingModel>(
                      future: _districtListingFuture,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          dropdown2.clear();
                          for(int i=0;i<snapshot.data.data.length;i++){
                            dropdown2.add(snapshot.data.data[i].name);
                            dropdownDistrictId.add(int.parse(snapshot.data.data[i].id));
                          }
                          return Container(
                            width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.03,top: scH*0.01,right: scW*0.04),
                            color: secondColor,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  items: dropdown2.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    setState(() {
                                      _dropDownDistrictValue = value;
                                      int a= dropdown2.indexOf(_dropDownDistrictValue);
                                      districtId = dropdownDistrictId[a];
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down_sharp,size: scH*0.038,color: Color.fromRGBO(255, 255, 255, 0.4),),
                                  hint: _dropDownDistrictValue==null?Text('Select District',
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ):
                                  Text(_dropDownDistrictValue,
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ),
                                  style: TextStyle(color: Colors.black,fontSize: scW*0.035),
                                ),
                              ),
                            ),
                          );
                        }else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Container(
                            width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.03,top: scH*0.01,right: scW*0.04),
                            color: secondColor,
                          );
                        }else {
                          return Container( width: scW * 0.43,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.03,top: scH*0.01,right: scW*0.04),
                            color: secondColor,
                          );
                        }
                      }
                  ):
                  Container(
                    width: scW * 0.43,
                    height: 33,
                    margin: EdgeInsets.only(left: scW*0.03,top: scH*0.01,right: scW*0.04),
                    color: secondColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: scH*0.06,bottom: scH*0.02),
            child: Image.asset('images/logo_pulse.png',height: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: textHeading('Welcome!', 24.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.03),
                child: Image.asset('images/welcome_image.png',height: 61),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.07,top: scH*0.05),
            child: textHeading('Health Care Resources', scW*0.045),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.07,top: scH*0.008),
            child: textHeading('Search', scW*0.04)
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: scH*0.005),
              height: 35,
              width: scW*0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromRGBO(136, 135, 137, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  index==0?
                  Container(
                    width: scW*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: secondColor
                  ),
                    child: Center(
                      child: Text('By Pincode',
                        style: TextStyle(color: grey1,fontSize: 14),
                      ),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      setState(() {
                        pinCodeController = TextEditingController();
                        index = 0;
                      });
                    },
                    child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: scW*0.05),
                        child: Text('By Pincode',
                          style: TextStyle(color: grey1,fontSize: 14),
                        ),
                    ),
                  ),
                  ),
                  index==1?
                  Container(
                    width: scW*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: secondColor
                    ),
                    child: Center(
                      child: Text('By District',
                        style: TextStyle(color: grey1,fontSize: 14),
                      ),
                    ),
                  ):
                  InkWell(
                    onTap: (){
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: scW*0.07),
                        child: Text('By District',
                          style: TextStyle(color: grey1,fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
             switchInCurve: Curves.easeInOut,
             switchOutCurve: Curves.easeInOut,
            child: _returnWidget(),
          ),
          AnimatedOpacity(
            opacity: waitForCityLoad==false ? 1.0 : 0.3,
            duration: const Duration(milliseconds: 800),
            child: Container(
              height: 45,
              width: scW,
              margin: EdgeInsets.only(left: scW*0.34,right: scW*0.34),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                color: purpleColor,
                elevation: 10,
                onPressed: (){
                  if(index==0){
                    if(pinCodeController.text.length<6){
                      Fluttertoast.showToast(
                          msg: "Please Enter Pincode",
                          fontSize: 16,
                          backgroundColor: bgColor,
                          textColor: grey1,
                          toastLength: Toast.LENGTH_LONG);
                    }else if(waitForCityLoad==true){
                      Fluttertoast.showToast(
                          msg: "Please wait we are fetching city name",
                          fontSize: 16,
                          backgroundColor: bgColor,
                          textColor: grey1,
                          toastLength: Toast.LENGTH_LONG);
                    }else if(cityName==null){
                      Fluttertoast.showToast(
                          msg: "Please check your pin code",
                          fontSize: 16,
                          backgroundColor: bgColor,
                          textColor: grey1,
                          toastLength: Toast.LENGTH_LONG);
                    }else{
                      Get.offAll(Home(pinCodeController.text,cityName,index,0));
                    }
                  }
                  if(index==1){
                    if(_dropDownStateValue==null){
                      Fluttertoast.showToast(
                          msg: "Please Select State",
                          fontSize: 16,
                          backgroundColor: bgColor,
                          textColor: grey1,
                          toastLength: Toast.LENGTH_LONG);
                    }else if(_dropDownDistrictValue==null){
                      Fluttertoast.showToast(
                          msg: "Please Select District",
                          fontSize: 16,
                          backgroundColor: bgColor,
                          textColor: grey1,
                          toastLength: Toast.LENGTH_LONG);
                    }else{
                      Get.offAll(Home(_dropDownStateValue,_dropDownDistrictValue,index,districtId));
                    }
                  }
                },
                child: Text('FIND',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            height: 140,
            margin: EdgeInsets.only(top: scH*0.05,bottom: scH*0.03),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: scW*0.05,right: scW*0.02),
              itemCount: 2,
              itemBuilder: (context,index){
                return Container(
                  width: scW*0.9,
                  margin: EdgeInsets.only(right: scW*0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: secondColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02),
                        child: Text('DISCLAIMER',
                          style: TextStyle(fontSize: scW*0.02,color: grey2,letterSpacing: 2,),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: scW*0.04,right: scW*0.02,top: scH*0.005),
                            child: Image.asset(index==0?'images/image_for_disclaimer1.png':'images/image_for_disclaimer.png',height: scH*0.08),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: scW*0.1,right: scW*0.03,top: index==0?scH*0.01:0),
                                  child: index==0?
                                  Image.asset('images/splash_logo.png',height: scH*0.025):
                                  Text('We are working hard to help the society grow!',
                                    style: TextStyle(fontSize: scW*0.028,color: grey1,height: 1.5,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                  )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: scW*0.1,top: index==0?scH*0.008:scH*0.015,right: scW*0.03),
                                  child: Text(index==0?'is an aggregator, We shall not be responsible for any info uploaded/shared by users/contributors':'We shall not entertain any complaints on user/ contributors uploads',
                                    style: TextStyle(fontSize: scW*0.028,color: grey1,height: 1.5,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

