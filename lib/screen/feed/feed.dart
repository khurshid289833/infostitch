import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/districtListing/model/districtListingModel.dart';
import 'package:infostitch/screen/districtListing/repository/districtListingRepository.dart';
import 'package:infostitch/screen/feed/model/helplineNumberModel.dart';
import 'package:infostitch/screen/feed/model/hospitalsListingModel.dart';
import 'package:infostitch/screen/feed/model/vaccinationCentersByDistrictIdModel.dart';
import 'package:infostitch/screen/feed/model/vaccinationCentersByPincodeModel.dart';
import 'package:infostitch/screen/feed/repository/helplineListingByPincodeCityRepository.dart';
import 'package:infostitch/screen/feed/repository/helplineListingByStateDistrictRepository.dart';
import 'package:infostitch/screen/feed/repository/hospitalListingByPincodeCityRepository.dart';
import 'package:infostitch/screen/feed/repository/hospitalListingStateDistrictRepository.dart';
import 'package:infostitch/screen/feed/repository/vaccinationCentersByDistrictIdRepository.dart';
import 'package:infostitch/screen/feed/repository/vaccinationCentersByPincodeRepository.dart';
import 'package:infostitch/screen/hospitalDetails/hospitalDetails.dart';
import 'package:infostitch/screen/myHomePage/myHomePage.dart';
import 'package:infostitch/screen/notifyUser/bloc/notifyUserBloc.dart';
import 'package:infostitch/screen/notifyUser/model/notifyUserModel.dart';
import 'package:infostitch/screen/stateListing/model/stateListingModel.dart';
import 'package:infostitch/screen/stateListing/repository/stateListingRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatefulWidget {
  String value1;
  String value2;
  int indexForCheck;
  int districtId;
  Feed(this.value1,this.value2,this.indexForCheck,this.districtId);
  @override
  _FeedState createState() => _FeedState(value1,value2,indexForCheck,districtId);
}

class _FeedState extends State<Feed> {
  String value1;
  String value2;
  int indexForCheck;
  int districtId;
  _FeedState(this.value1,this.value2,this.indexForCheck,this.districtId);

  int index;
  int indexForHelpline;
  int indexForVacCenter;

  bool indexForAll;
  bool indexFor18;
  bool indexFor45;
  bool indexForCovaxin;
  bool indexForCovidsheild;
  bool indexForDose1;
  bool indexForDose2;

  String _dropDownStateValue;
  String _dropDownDistrictValue;
  bool waitForDistrict=true;
  List<String> dropdown1=[];
  List<int> dropdownStateId=[];
  List<String> dropdown2=[];
  List<int> dropdownDistrictId=[];
  int StateIdTemp;
  int DistrictIdTemp;

  List<String> hospitalName = new List();
  List<String> cityName = new List();
  List<String> stateName = new List();
  List<String> pincodeValue = new List();
  List<String> googleMapLocation = new List();
  List<String> phone1 = new List();
  List<String> phone2 = new List();
  List<String> hospitalAddress = new List();
  List<String> hospitalId = new List();
  List<String> bed_oxy = new List();
  List<String> bed_wo_oxy = new List();
  List<String> bed_icu = new List();
  List<String> bed_wo_icu = new List();
  List<String> bed_venti = new List();
  List<String> avail_bed_oxy = new List();
  List<String> avail_bed_wo_oxy = new List();
  List<String> avail_bed_icu = new List();
  List<String> avail_bed_wo_icu = new List();
  List<String> avail_bed_venti = new List();
  List<String> poc_name = new List();
  List<String> poc_number = new List();
  List<String> poc_designation = new List();
  List<String> source = new List();
  List<String> contributorName = new List();
  List<String> contributorImage = new List();
  List<bool> isSaved = new List();
  List<int> upVotePhone1 = new List();
  List<int> downVotePhone1 = new List();
  List<int> upVotePhone2 = new List();
  List<int> downVotePhone2 = new List();
  List<bool> isUpvoted = new List();
  List<bool> isDownvoted = new List();
  List<int> totalAvailableBed = new List();


  List<String> helplineId = new List();
  List<String> helplinePhone = new List();
  List<String> helplineDetails = new List();
  List<String> helplineOrganizationName = new List();
  List<String> helplinePincode = new List();
  List<String> helplineCountry = new List();
  List<String> helplineState = new List();
  List<String> helplineCity = new List();

  int i;
  bool streamCheck = false;
  bool streamCheckForHelpline=false;
  bool streamCheckForHospital=false;
  bool isLoading = false;
  bool inc;


  int pageForHelpNo = 1;
  Future _loadDataForHelpline() async {
    inc==true?pageForHelpNo=pageForHelpNo+1:inc = false;
    inc==true?
    indexForCheck==0?
    _helplineNumberFuture = _helplineNumberByPincodeCityRepository.helplineNumberByPincodeCityRepositoryFunction(value1, value2, pageForHelpNo):
    _helplineNumberFuture = _helplineNumberByStateDistrictRepository.helplineNumberByStateDistrictRepositoryFunction(value1, value2, pageForHelpNo)
        :null;

    _helplineNumberFuture.whenComplete(() =>
        setState(() {
          isLoading = false;
          inc = false;
          streamCheckForHelpline = true;
        }
        ));
  }

  int pageForHospitals = 1;
  Future _loadDataForHospitals() async {
    inc==true?pageForHospitals=pageForHospitals+1:inc = false;
    inc==true?
    indexForCheck==0?
    token!=null?
    _hospitalsListingFuture =  _hospitalListingByPincodeCityRepository.hospitalListingByPincodeCityRepositoryFunctionPost(value1,value2,pageForHospitals,token):
    _hospitalsListingFuture =  _hospitalListingByPincodeCityRepository.hospitalListingByPincodeCityRepositoryFunctionGet(value1,value2,pageForHospitals):
    token!=null?
    _hospitalsListingFuture =  _hospitalListingByStateDistrictRepository.hospitalListingByStateDistrictRepositoryFunctionPost(value1,value2,pageForHospitals,token):
    _hospitalsListingFuture =  _hospitalListingByStateDistrictRepository.hospitalListingByStateDistrictRepositoryFunctionGet(value1,value2,pageForHospitals)
        :null;

    _hospitalsListingFuture.whenComplete(() =>
        setState(() {
          isLoading = false;
          inc = false;
          streamCheckForHospital = true;
        }
        ));
  }

  String url="https://www.cowin.gov.in";
  Future<void> _launchInBrowser() async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCaller(String number) async {
    final url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<HelplineNumberModel> _helplineNumberFuture;
  HelplineNumberByPincodeCityRepository _helplineNumberByPincodeCityRepository;
  HelplineNumberByStateDistrictRepository _helplineNumberByStateDistrictRepository;

  Future<HospitalsListingModel> _hospitalsListingFuture;
  HospitalListingByPincodeCityRepository _hospitalListingByPincodeCityRepository;
  HospitalListingByStateDistrictRepository _hospitalListingByStateDistrictRepository;

  Future<VaccinationCentersByPincodeModel> _vaccinationCentersByPincodeFuture;
  VaccinationCentersByPincodeRepository _vaccinationCentersByPincodeRepository;
  Future<VaccinationCentersByDistrictIdModel> _vaccinationCentersByDistrictIdFuture;
  VaccinationCentersByDistrictIdRepository _vaccinationCentersByDistrictIdRepository;

  Future<StateListingModel> _stateListingFuture;
  StateListingRepository _stateListingRepository;
  Future<DistrictListingModel> _districtListingFuture;
  DistrictListingRepository _districtListingRepository;

  NotifyUserBloc _notifyUserBloc;

  String token;
  SharedPreferences _sharedPreferences;
  Future<void> createSharedPref() async {
    int pageNo1 = 1;
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");

    _stateListingRepository = StateListingRepository();
    _stateListingFuture = _stateListingRepository.StateListingRepositoryFunction();
    _districtListingRepository = DistrictListingRepository();

    _helplineNumberByPincodeCityRepository = HelplineNumberByPincodeCityRepository();
    _helplineNumberByStateDistrictRepository = HelplineNumberByStateDistrictRepository();
    indexForCheck==0?
    _helplineNumberFuture = _helplineNumberByPincodeCityRepository.helplineNumberByPincodeCityRepositoryFunction(value1, value2, pageNo1):
    _helplineNumberFuture = _helplineNumberByStateDistrictRepository.helplineNumberByStateDistrictRepositoryFunction(value1, value2, pageNo1);

    _hospitalListingByPincodeCityRepository = HospitalListingByPincodeCityRepository();
    _hospitalListingByStateDistrictRepository = HospitalListingByStateDistrictRepository();
    indexForCheck==0?
    token!=null?
    _hospitalsListingFuture = _hospitalListingByPincodeCityRepository.hospitalListingByPincodeCityRepositoryFunctionPost(value1, value2, pageNo1,token):
    _hospitalsListingFuture = _hospitalListingByPincodeCityRepository.hospitalListingByPincodeCityRepositoryFunctionGet(value1, value2, pageNo1):
    token!=null?
    _hospitalsListingFuture = _hospitalListingByStateDistrictRepository.hospitalListingByStateDistrictRepositoryFunctionPost(value1, value2, pageNo1,token):
    _hospitalsListingFuture = _hospitalListingByStateDistrictRepository.hospitalListingByStateDistrictRepositoryFunctionGet(value1, value2, pageNo1);

    _vaccinationCentersByPincodeRepository = VaccinationCentersByPincodeRepository();
    _vaccinationCentersByDistrictIdRepository = VaccinationCentersByDistrictIdRepository();
    indexForCheck==0?
    _vaccinationCentersByPincodeFuture = _vaccinationCentersByPincodeRepository.VaccinationCentersByPincodeRepositoryFunction(value1):
    _vaccinationCentersByDistrictIdFuture = _vaccinationCentersByDistrictIdRepository.vaccinationCentersByDistrictIdRepositoryFunction(districtId);

    setState(() {
      streamCheckForHelpline=true;
      streamCheckForHospital=true;
    });

  }

  @override
  void initState() {
    index = 0;
    indexForHelpline = 0;
    indexForVacCenter = 0;
    indexForAll = true;
    indexFor18 = false;
    indexFor45 = false;
    indexForCovaxin = false;
    indexForCovidsheild = false;
    indexForDose1 = false;
    indexForDose2 = false;
    _notifyUserBloc = NotifyUserBloc();
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    Widget squareBlackBox(text1,text2) => Container(
      height: 98,
      width: scW,
      margin: EdgeInsets.only(left: scW*0.05,right: scW*0.05,top: scH*0.015),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02),
            child: Text(text1,
              style: TextStyle(color: grey2,letterSpacing: 1.5,fontSize: scW*0.028),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: scW*0.05,top: scH*0.0),
                  child: Text(text2,
                    style: TextStyle(color: grey1,fontSize: scW*0.038),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: scW*0.2,top: scH*0.03),
                  child: Text('VISIT',
                    style: TextStyle(color: grey2,letterSpacing: 1.5,fontSize: scW*0.03),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: scW*0.1,top: scH*0.03),
                  child: Icon(Icons.arrow_forward_ios_sharp,color: grey1,size: scW*0.04,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    Widget textInsideBlackBox(text1,number,place) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: scW*0.07,top: scH*0.025),
              child: Text('GOVT. HELPLINE',
                style: TextStyle(color: grey2,fontSize: scW*0.028,letterSpacing: 1.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: scW*0.07,top: scH*0.003),
              child: Text(text1,
                style: TextStyle(color: grey1,fontSize: scW*0.035,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: scW*0.07,top: scH*0.008),
              child: Text('Number',
                style: TextStyle(color: grey1,fontSize: scW*0.035,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: scW*0.07,top: scH*0.008),
              child: Text(place,
                style: TextStyle(color: grey1,fontSize: scW*0.03),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: scW*0.05,top: scH*0.02),
          child: InkWell(
            onTap: (){
              _launchCaller(number);
            },
            child: Text(number,
              style: TextStyle(color: grey1,fontSize: 13,letterSpacing: 0.5),
            ),
          ),
        ),
      ],
    );
    final row1 = Row(
      children: [
        indexForAll == true?
        Container(
            margin: EdgeInsets.only(left: scW*0.1,top: scH*0.02),
            height: scH*0.05,
            width: scW*0.11,
            decoration: BoxDecoration(
                color: purpleBackground,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: Center(child: Text('All',
              style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
            ))
        ):
        Padding(
          padding: EdgeInsets.only(left: scW*0.1,top: scH*0.02),
          child: InkWell(
            onTap: (){
              setState(() {
                indexForAll = true;
                indexFor18 = false;
                indexFor45 = false;
                indexForCovaxin = false;
                indexForCovidsheild = false;
                indexForDose1 = false;
                indexForDose2 = false;
              });
            },
            child: Container(
                height: scH*0.05,
                width: scW*0.11,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text('All',
                  style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                ))
            ),
          ),
        ),
        indexFor18 == true?
        InkWell(
          onTap: (){
            setState(() {
              if(indexForDose2==false&&indexFor45==false&&indexForCovaxin==false&&indexForCovidsheild==false&&indexForDose1==false){
                indexForAll=true;
              }
              indexFor18 = false;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.05,
              width: scW*0.11,
              decoration: BoxDecoration(
                  color: purpleBackground,
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('18+',
                style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ):
        InkWell(
          onTap: (){
            setState(() {
              indexForAll = false;
              indexFor18 = true;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.05,
              width: scW*0.11,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('18+',
                style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ),
        indexFor45 == true?
        InkWell(
          onTap: (){
            setState(() {
              if(indexFor18==false&&indexForDose2==false&&indexForCovaxin==false&&indexForCovidsheild==false&&indexForDose1==false){
                indexForAll=true;
              }
              indexFor45 = false;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.05,
              width: scW*0.11,
              decoration: BoxDecoration(
                  color: purpleBackground,
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('45+',
                style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ):
        InkWell(
          onTap: (){
            setState(() {
              indexForAll = false;
              indexFor45 = true;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.05,
              width: scW*0.11,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('45+',
                style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ),
        indexForCovaxin == true?
        InkWell(
          onTap: (){
            setState(() {
              if(indexFor18==false&&indexFor45==false&&indexForDose2==false&&indexForCovidsheild==false&&indexForDose1==false){
                indexForAll=true;
              }
              indexForCovaxin = false;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.045,
              width: scW*0.18,
              decoration: BoxDecoration(
                  color: purpleBackground,
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('Covaxin',
                style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ):
        InkWell(
          onTap: (){
            setState(() {
              indexForAll = false;
              indexForCovaxin = true;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
              height: scH*0.045,
              width: scW*0.18,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('Covaxin',
                style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ),
        indexForCovidsheild == true?
        Padding(
          padding: EdgeInsets.only(left: scW*0.015,top: scH*0.02,right: scW*0.08),
          child: InkWell(
            onTap: (){
              setState(() {
                if(indexFor18==false&&indexFor45==false&&indexForCovaxin==false&&indexForDose1==false&&indexForDose2==false){
                  indexForAll=true;
                }
                indexForCovidsheild = false;
              });
            },
            child: Container(
                height: scH*0.045,
                width: scW*0.24,
                decoration: BoxDecoration(
                    color: purpleBackground,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text('Covishield',
                  style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                ))
            ),
          ),
        ):
        Padding(
          padding: EdgeInsets.only(left: scW*0.015,top: scH*0.02,right: scW*0.08),
          child: InkWell(
            onTap: (){
              setState(() {
                indexForAll = false;
                indexForCovidsheild = true;
              });
            },
            child: Container(
                height: scH*0.045,
                width: scW*0.24,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text('Covishield',
                  style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                ))
            ),
          ),
        ),
      ],
    );
    final row2 = Row(
      children: [
        indexForDose1 == true?
        Padding(
          padding: EdgeInsets.only(left: scW*0.26,top: scH*0.01),
          child: InkWell(
            onTap: (){
              setState(() {
                if(indexFor18==false&&indexFor45==false&&indexForCovaxin==false&&indexForCovidsheild==false&&indexForDose2==false){
                  indexForAll=true;
                }
                indexForDose1 = false;
              });
            },
            child: Container(
                height: scH*0.045,
                width: scW*0.2,
                decoration: BoxDecoration(
                    color: purpleBackground,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text('Dose 1',
                  style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                ))
            ),
          ),
        ):
        Padding(
          padding: EdgeInsets.only(left: scW*0.26,top: scH*0.01),
          child: InkWell(
            onTap: (){
              setState(() {
                indexForAll = false;
                indexForDose1 = true;
              });
            },
            child: Container(
                height: scH*0.045,
                width: scW*0.2,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text('Dose 1',
                  style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                ))
            ),
          ),
        ),
        indexForDose2 == true?
        InkWell(
          onTap: (){
            setState(() {
              if(indexFor18==false&&indexFor45==false&&indexForCovaxin==false&&indexForCovidsheild==false&&indexForDose1==false){
                indexForAll=true;
              }
              indexForDose2 = false;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.02,top: scH*0.01),
              height: scH*0.045,
              width: scW*0.2,
              decoration: BoxDecoration(
                  color: purpleBackground,
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('Dose 2',
                style: TextStyle(color: purpleColor,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ):
        InkWell(
          onTap: (){
            setState(() {
              indexForAll = false;
              indexForDose2 = true;
            });
          },
          child: Container(
              margin: EdgeInsets.only(left: scW*0.02,top: scH*0.01),
              height: scH*0.045,
              width: scW*0.2,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text('Dose 2',
                style: TextStyle(color: Colors.black,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ))
          ),
        ),
      ],
    );
    final textValue1andValue2 = Text('${value2}, ${value1}',
      style: TextStyle(color: grey1,fontSize: scW*0.035,fontFamily: 'assets/Nunito-SemiBold.ttf',),
    );
    final textChange = InkWell(
      onTap: (){
        Get.offAll(MyHomePage());
      },
      child: Padding(
        padding: EdgeInsets.only(top: scH*0.013),
        child: Text('change',
          style: TextStyle(color: grey1,fontSize: scW*0.02,height: 0.0,fontFamily: 'assets/Nunito-SemiBold.ttf'),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          bell(scH,scW),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.02),
            child: heading('Health Care'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: scW*0.05),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index=0;
                    });
                  },
                  child: Container(
                    height: 34,
                    width: scW*0.29,
                    decoration: BoxDecoration(
                      color: index==0?purpleBackground:secondColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text('Helpline Nos.',
                        style: TextStyle(color: index==0?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf',fontSize: scW*0.038),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.008),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index=1;
                    });
                  },
                  child: Container(
                    height: 34,
                    width: scW*0.21,
                    decoration: BoxDecoration(
                      color: index==1?purpleBackground:secondColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text('Hospitals',
                        style: TextStyle(color: index==1?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf',fontSize: scW*0.038),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.008,right: scW*0.04),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      index=2;
                    });
                  },
                  child: Container(
                    height: 34,
                    width: scW*0.39,
                    decoration: BoxDecoration(
                      color: index==2?purpleBackground:secondColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text('Vaccination Centers',
                        style: TextStyle(color: index==2?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf',fontSize: scW*0.038),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ///---------------index==0 for Helplines NOs.---------------------------///
          if(index==0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: scW*0.05,right: scW*0.04,top: scH*0.03),
                  child: divider,
                ),
                Padding(
                  padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                  child: textValue1andValue2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: scW*0.05),
                  child: textChange,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.05,top: scH*0.035),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            indexForHelpline=0;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: scW*0.2,
                          decoration: BoxDecoration(
                            color: indexForHelpline==0?purpleBackground:secondColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Central',
                              style: TextStyle(color: indexForHelpline==0?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.02,top: scH*0.035),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            indexForHelpline=1;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: scW*0.2,
                          decoration: BoxDecoration(
                            color: indexForHelpline==1?purpleBackground:secondColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('State',
                              style: TextStyle(color: indexForHelpline==1?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.02,top: scH*0.035,right: scW*0.05),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            indexForHelpline=2;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: scW*0.2,
                          decoration: BoxDecoration(
                            color: indexForHelpline==2?purpleBackground:secondColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('District',
                              style: TextStyle(color: indexForHelpline==2?purpleColor:grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if(indexForHelpline==0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      squareBlackBox('CENTRAL WEBSITE','Covid Care Center'),
                      textInsideBlackBox('Covid Care Center','+918420456789','India'),
                      Padding(
                        padding: EdgeInsets.only(left: scW*0.07,right: scW*0.03,top: scH*0.005),
                        child: divider,
                      ),
                    ],
                  ),
                if(indexForHelpline==1)
                  NotificationListener<OverscrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        if(inc==true){
                          _loadDataForHelpline();
                        }
                        setState(() {
                          inc==true?isLoading = true:isLoading=false;
                        });
                      }
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        FutureBuilder<HelplineNumberModel>(
                            future: _helplineNumberFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.datum.helplines.data.length != 0) {
                                  if(streamCheckForHelpline)
                                  {
                                    print('stream builder hit');
                                    for(i=0;i<snapshot.data.datum.helplines.data.length;i++)
                                    {
                                      helplineId.add(snapshot.data.datum.helplines.data[i].id);
                                      helplinePhone.add(snapshot.data.datum.helplines.data[i].phoneNumber);
                                      helplineDetails.add(snapshot.data.datum.helplines.data[i].details);
                                      helplineOrganizationName.add(snapshot.data.datum.helplines.data[i].organizationName);
                                      helplinePincode.add(snapshot.data.datum.helplines.data[i].pincode);
                                      helplineCountry.add(snapshot.data.datum.helplines.data[i].countryName);
                                      helplineState.add(snapshot.data.datum.helplines.data[i].stateName);
                                      helplineCity.add(snapshot.data.datum.helplines.data[i].cityName);
                                    }
                                    Future.delayed(Duration.zero, () {
                                      setState(() {
                                        snapshot.data.datum.helplines.nextPageUrl!=null?inc=true:inc=false;
                                        streamCheckForHelpline = false;
                                      });
                                    });
                                  }
                                  return ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: helplineOrganizationName.length,
                                          //padding: EdgeInsets.only(top: scH*0.04),
                                          itemBuilder: (context,index){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                squareBlackBox('STATE WEBSITE',helplineOrganizationName[index]),
                                                textInsideBlackBox(helplineOrganizationName[index], helplinePhone[index], helplineState[index]),
                                                Padding(
                                                  padding: EdgeInsets.only(left: scW*0.07,right: scW*0.03,top: scH*0.005),
                                                  child: divider,
                                                ),
                                              ],
                                            );
                                          }
                                      ),
                                      isLoading?
                                      Container(
                                        height: 70.0,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3.0,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              grey1,
                                            ),
                                          ),
                                        ),
                                      ):Container(
                                        height: 70.0,
                                      )
                                    ],
                                  );
                                }else {
                                  return Container(
                                    height: scH*0.4,
                                    child: Center(
                                      child: Text("No helpline number found",
                                        style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                      ),
                                    ),
                                  );
                                }
                              }else if(snapshot.hasError) {
                                print(snapshot.error);
                                return Container(
                                  height: scH*0.4,
                                  child: Center(
                                    child: Text("Something went wrong please try again",
                                      style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  height: scH*0.4,
                                  child: Center(child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        grey1
                                    ),
                                  ),),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                if(indexForHelpline==2)
                  NotificationListener<OverscrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        if(inc==true){
                          _loadDataForHelpline();
                        }
                        setState(() {
                          inc==true?isLoading = true:isLoading=false;
                        });
                      }
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        FutureBuilder<HelplineNumberModel>(
                            future: _helplineNumberFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.datum.helplines.data.length != 0) {
                                  if(streamCheckForHelpline)
                                  {
                                    print('stream builder hit');
                                    for(i=0;i<snapshot.data.datum.helplines.data.length;i++)
                                    {
                                      helplineId.add(snapshot.data.datum.helplines.data[i].id);
                                      helplinePhone.add(snapshot.data.datum.helplines.data[i].phoneNumber);
                                      helplineDetails.add(snapshot.data.datum.helplines.data[i].details);
                                      helplineOrganizationName.add(snapshot.data.datum.helplines.data[i].organizationName);
                                      helplinePincode.add(snapshot.data.datum.helplines.data[i].pincode);
                                      helplineCountry.add(snapshot.data.datum.helplines.data[i].countryName);
                                      helplineState.add(snapshot.data.datum.helplines.data[i].stateName);
                                      helplineCity.add(snapshot.data.datum.helplines.data[i].cityName);
                                    }
                                    Future.delayed(Duration.zero, () {
                                      setState(() {
                                        snapshot.data.datum.helplines.nextPageUrl!=null?inc=true:inc=false;
                                        streamCheckForHelpline = false;
                                      });
                                    });
                                  }
                                  return ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: [
                                      ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: helplineOrganizationName.length,
                                          //padding: EdgeInsets.only(top: scH*0.04),
                                          itemBuilder: (context,index){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                squareBlackBox('DISTRICT WEBSITE',helplineOrganizationName[index]),
                                                textInsideBlackBox(helplineOrganizationName[index], helplinePhone[index], helplineCity[index]),
                                                Padding(
                                                  padding: EdgeInsets.only(left: scW*0.07,right: scW*0.03,top: scH*0.005),
                                                  child: divider,
                                                ),
                                              ],
                                            );
                                          }
                                      ),
                                      isLoading?
                                      Container(
                                        height: 70.0,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3.0,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              grey1,
                                            ),
                                          ),
                                        ),
                                      ):Container(
                                        height: 70.0,
                                      )
                                    ],
                                  );
                                } else {
                                  return Container(
                                    height: scH*0.4,
                                    child: Center(
                                      child: Text("No helpline number found",
                                        style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                      ),
                                    ),
                                  );
                                }
                              }else if (snapshot.hasError) {
                                print(snapshot.error);
                                return Container(
                                  height: scH*0.4,
                                  child: Center(
                                    child: Text("Something went wrong please try again",
                                      style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  height: scH*0.4,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        grey1
                                    ),
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  ),
              ],
            ),
          ///---------------index==1 for Hospitals-------------------------------///
          if(index==1)
            Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: EdgeInsets.only(left: scW*0.05,right: scW*0.04,top: scH*0.03),
                 child: divider,
               ),
               Padding(
                 padding: EdgeInsets.only(left: scW*0.07,top: scH*0.01),
                 child: textValue1andValue2,
               ),
               Padding(
                 padding: EdgeInsets.only(left: scW*0.07),
                 child: textChange,
               ),
               NotificationListener<OverscrollNotification>(
                 onNotification: (ScrollNotification scrollInfo) {
                   if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                     if(inc==true){
                       _loadDataForHospitals();
                     }
                     setState(() {
                       inc==true?isLoading = true:isLoading=false;
                     });
                   }
                 },
                 child: ListView(
                   scrollDirection: Axis.vertical,
                   physics: ScrollPhysics(),
                   shrinkWrap: true,
                   children: [
                     FutureBuilder<HospitalsListingModel>(
                         future: _hospitalsListingFuture,
                         builder: (context, snapshot) {
                           if (snapshot.hasData) {
                             if (snapshot.data.datum.hospitals.data.length != 0) {
                               if(streamCheckForHospital)
                               {
                                 print('future builder hit');
                                 for(i=0;i<snapshot.data.datum.hospitals.data.length;i++)
                                 {
                                   hospitalName.add(snapshot.data.datum.hospitals.data[i].hospitalName);
                                   cityName.add(snapshot.data.datum.hospitals.data[i].cityName);
                                   stateName.add(snapshot.data.datum.hospitals.data[i].stateName);
                                   pincodeValue.add(snapshot.data.datum.hospitals.data[i].pincode);
                                   googleMapLocation.add(snapshot.data.datum.hospitals.data[i].googleMapLocation);
                                   phone1.add(snapshot.data.datum.hospitals.data[i].phoneNumber1);
                                   phone2.add(snapshot.data.datum.hospitals.data[i].phoneNumber2);
                                   hospitalAddress.add(snapshot.data.datum.hospitals.data[i].hospitalAddress);
                                   hospitalId.add(snapshot.data.datum.hospitals.data[i].hospitalId);
                                   bed_oxy.add(snapshot.data.datum.hospitals.data[i].bedOxygen);
                                   bed_wo_oxy.add(snapshot.data.datum.hospitals.data[i].bedWoOxygen);
                                   bed_icu .add(snapshot.data.datum.hospitals.data[i].bedIcu);
                                   bed_wo_icu.add(snapshot.data.datum.hospitals.data[i].bedWoIcu);
                                   bed_venti.add(snapshot.data.datum.hospitals.data[i].bedVentilator);
                                   avail_bed_oxy.add(snapshot.data.datum.hospitals.data[i].availBedOxygen);
                                   avail_bed_wo_oxy.add(snapshot.data.datum.hospitals.data[i].availBedWoOxygen);
                                   avail_bed_icu.add(snapshot.data.datum.hospitals.data[i].availBedIcu);
                                   avail_bed_wo_icu.add(snapshot.data.datum.hospitals.data[i].availBedWoIcu);
                                   avail_bed_venti.add(snapshot.data.datum.hospitals.data[i].availBedVentilator);
                                   poc_name.add(snapshot.data.datum.hospitals.data[i].pocName);
                                   poc_number.add(snapshot.data.datum.hospitals.data[i].pocNumber);
                                   poc_designation.add(snapshot.data.datum.hospitals.data[i].pocDesg);
                                   source.add(snapshot.data.datum.hospitals.data[i].source);
                                   contributorName.add(snapshot.data.datum.hospitals.data[i].contributor);
                                   contributorImage.add(snapshot.data.datum.hospitals.data[i].image);
                                   isSaved.add(snapshot.data.datum.hospitals.data[i].isSaved);
                                   upVotePhone1.add(snapshot.data.datum.hospitals.data[i].isUpVotedPhoneNumber1);
                                   downVotePhone1.add(snapshot.data.datum.hospitals.data[i].isDownVotedPhoneNumber1);
                                   upVotePhone2.add(snapshot.data.datum.hospitals.data[i].isUpVotedPhoneNumber2);
                                   downVotePhone2.add(snapshot.data.datum.hospitals.data[i].isDownVotedPhoneNumber2);
                                   isUpvoted.add(snapshot.data.datum.hospitals.data[i].isUpvoted);
                                   isDownvoted.add(snapshot.data.datum.hospitals.data[i].isDownvoted);
                                   totalAvailableBed.add(
                                           int.parse(snapshot.data.datum.hospitals.data[i].availBedOxygen)+
                                           int.parse(snapshot.data.datum.hospitals.data[i].availBedWoOxygen)+
                                           int.parse(snapshot.data.datum.hospitals.data[i].availBedIcu)+
                                           int.parse(snapshot.data.datum.hospitals.data[i].availBedWoIcu)+
                                           int.parse(snapshot.data.datum.hospitals.data[i].availBedVentilator)
                                   );
                                 }
                                 Future.delayed(Duration.zero, () {
                                   setState(() {
                                     snapshot.data.datum.hospitals.nextPageUrl!=null?inc=true:inc=false;
                                     streamCheckForHospital = false;
                                   });
                                 });
                               }
                               return ListView(
                                 scrollDirection: Axis.vertical,
                                 shrinkWrap: true,
                                 physics: ScrollPhysics(),
                                 children: [
                                   ListView.builder(
                                       scrollDirection: Axis.vertical,
                                       physics: ScrollPhysics(),
                                       shrinkWrap: true,
                                       itemCount: hospitalName.length,
                                       padding: EdgeInsets.only(top: scH*0.03),
                                       itemBuilder: (context,index){
                                         return Column(
                                           children: [
                                             InkWell(
                                               onTap: (){
                                                 Get.to(HospitalDetails(
                                                   hospitalName[index],cityName[index],stateName[index],
                                                   pincodeValue[index], googleMapLocation[index],phone1[index],
                                                   phone2[index], hospitalAddress[index],hospitalId[index],bed_oxy[index],
                                                   bed_wo_oxy[index],bed_icu[index],bed_wo_icu[index],bed_venti[index],
                                                   avail_bed_oxy[index],avail_bed_wo_oxy[index],avail_bed_icu[index],
                                                   avail_bed_wo_icu[index],avail_bed_venti[index],poc_name[index],
                                                   poc_number[index],poc_designation[index],isSaved[index],upVotePhone1[index],
                                                   downVotePhone1[index],upVotePhone2[index],downVotePhone2[index],
                                                   isUpvoted[index],isDownvoted[index],source[index],contributorName[index],contributorImage[index]

                                                 ));
                                               },
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Expanded(
                                                     child: Column(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         Padding(
                                                           padding: EdgeInsets.only(left: scW*0.07,top: scH*0.01),
                                                           child: Text('HOSPITAL',
                                                             style: TextStyle(color: grey2,fontSize: scW*0.028,letterSpacing: 1.5),
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(left: scW*0.07,top: scH*0.003,right: scW*0.04),
                                                           child: Text(hospitalName[index],
                                                             style: TextStyle(color: grey1,fontSize: scW*0.042,fontWeight: FontWeight.bold),
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(left: scW*0.07,top: scH*0.008),
                                                           child: Text('Available',
                                                             style: TextStyle(color: totalAvailableBed[index]>0?purpleColor:grey2,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: EdgeInsets.only(right: scW*0.05,top: scH*0.01),
                                                     child: arrowPurple,
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: scW*0.07,top: scH*0.01,right: scW*0.03),
                                               child: divider,
                                             ),
                                           ],
                                         );
                                       }
                                   ),
                                   isLoading?
                                   Container(
                                     height: 70.0,
                                     child: Center(
                                       child: CircularProgressIndicator(
                                         strokeWidth: 3.0,
                                         valueColor: AlwaysStoppedAnimation<Color>(
                                           grey1,
                                         ),
                                       ),
                                     ),
                                   ):Container(
                                     height: 70.0,
                                   )
                                 ],
                               );
                             }else {
                               return Container(
                                 height: scH*0.4,
                                 child: Center(
                                   child: Text("No hospital found",
                                     style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                   ),
                                 ),
                               );
                             }
                           }else if (snapshot.hasError) {
                             print(snapshot.error);
                             return Container(
                               height: scH*0.4,
                               child: Center(
                                 child: Text("Something went wrong please try again",
                                   style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                 ),
                               ),
                             );
                           } else {
                             return Container(
                               height: scH*0.4,
                               child: Center(
                                 child: CircularProgressIndicator(
                                 strokeWidth: 3.0,
                                 valueColor: AlwaysStoppedAnimation<Color>(grey1),
                               ),
                               ),
                             );
                           }
                         })
                   ],
                 ),
               ),
             ],
           ),
          ///---------------index==2 for Vaccination Centers---------------------///
          if(index==2)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<ApiResponse<NotifyUserModel>>(
                    stream: _notifyUserBloc.notifyUserStream,
                    builder: (context, snapshot) {
                      if (streamCheck) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return Container();
                              break;

                            case Status.COMPLETED:
                              streamCheck = false;
                              Get.back();
                              Future.delayed(Duration.zero, () async {
                                if(snapshot.data.data.success=="new notification acquired successfully."){
                                  Fluttertoast.showToast(
                                      msg: "Notification acquired successfully",
                                      fontSize: 16,
                                      backgroundColor: bgColor,
                                      textColor: grey1,
                                      toastLength: Toast.LENGTH_LONG);
                                }else{
                                  Fluttertoast.showToast(
                                      msg: indexForVacCenter==0?"Notification already acquired for this pinCode":"Notification already acquired for this district id",
                                      fontSize: 16,
                                      backgroundColor: bgColor,
                                      textColor: grey1,
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              });
                              print("api call done");
                              break;

                            case Status.ERROR:
                              streamCheck = false;
                              Get.back();
                              Future.delayed(Duration.zero, () async {
                                Fluttertoast.showToast(
                                    msg: "Something went wrong please try again",
                                    fontSize: 16,
                                    backgroundColor: bgColor,
                                    textColor: grey1,
                                    toastLength: Toast.LENGTH_LONG);
                              });
                              print("api call not done");
                              break;
                          }
                        }
                      }
                      return Container();
                    }),
                Padding(
                  padding: EdgeInsets.only(left: scW*0.05,right: scW*0.04,top: scH*0.03),
                  child: divider,
                ),
                Container(
                  margin: EdgeInsets.only(left: scW*0.0,right: scW*0.0,top: scH*0.01),
                  height: 83,
                  width: scW,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: secondColor
                  ),
                  child: InkWell(
                    onTap: (){
                      _launchInBrowser();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02),
                          child: Text('GOVT WEBSITE',
                            style: TextStyle(color: grey2,letterSpacing: 1.5,fontSize: scW*0.028),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                              child: Text('CoWin Website',
                                style: TextStyle(color: grey1,fontSize: scW*0.038),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: scW*0.45,top: scH*0.01),
                              child: Text('VISIT',
                                style: TextStyle(color: grey2,letterSpacing: 1.5,fontSize: scW*0.03),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: scW*0.05,top: scH*0.01),
                              child: Icon(Icons.arrow_forward_ios_sharp,color: grey1,size: scW*0.04,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: scW*0.13,top: scH*0.03),
                  child: Text('Search',
                    style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: scW*0.25),
                  height: 35,
                  width: scW*0.58,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(136, 135, 137, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      indexForVacCenter==0?
                      Container(
                        width: scW*0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: secondColor
                        ),
                        child: Center(
                          child: Text('By Pincode',
                            style: TextStyle(color: grey1),
                          ),
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          setState(() {
                            indexForVacCenter = 0;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: scW*0.05),
                            child: Text('By Pincode',
                              style: TextStyle(color: grey1),
                            ),
                          ),
                        ),
                      ),
                      indexForVacCenter==1?
                      Container(
                        width: scW*0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: secondColor
                        ),
                        child: Center(
                          child: Text('By District',
                            style: TextStyle(color: grey1),
                          ),
                        ),
                      ):
                      InkWell(
                        onTap: (){
                          setState(() {
                            indexForVacCenter = 1;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: scW*0.07),
                            child: Text('By District',
                              style: TextStyle(color: grey1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                indexForVacCenter==0?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02),
                      child: textValue1andValue2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: scW*0.05),
                      child: textChange,
                    ),
                    row1,
                    row2,
                    indexForCheck==0?
                    FutureBuilder<VaccinationCentersByPincodeModel>(
                        future: _vaccinationCentersByPincodeFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.data.centers.length != 0) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: scH*0.03),
                                  itemCount: snapshot.data.data.centers.length,
                                  itemBuilder: (context,index) => Visibility(
                                    visible: (indexForAll==true) ? true :
                                    ((indexFor18 == true? snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==18) : false) ||
                                        (indexFor45 == true? snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==45) : false) ||
                                        (indexForCovaxin == true? snapshot.data.data.centers[index].sessions.any((element) => element.vaccine=="COVAXIN") : false) ||
                                        (indexForCovidsheild == true? snapshot.data.data.centers[index].sessions.any((element) => element.vaccine=="COVISHIELD") : false) ||
                                        (indexForDose1 == true? snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacityDose1>0) : false) ||
                                        (indexForDose2 == true? snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacityDose2>0) : false)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: scW*0.07,top: scH*0.005),
                                                    child: Text(snapshot.data.data.centers[index].name,
                                                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: scW*0.07,top: scH*0.01),
                                                        child: Text('Available',
                                                          style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacity>0))?purpleColor:grey2,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                                                        child: Text('18+',
                                                          style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==18))? purpleColor : grey2 ,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                                                        child: Text('45+',
                                                          style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==45))? purpleColor : grey2 ,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.only(right: scW*0.1),
                                                child: InkWell(
                                                    onTap: (){
                                                      streamCheck=true;
                                                      Map body={
                                                        "pincode":value1.toString(),
                                                      };
                                                      showDialog(
                                                        useRootNavigator: false,
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) =>
                                                            Center(
                                                              child: CircularProgressIndicator(
                                                                  strokeWidth: 2.0,
                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                    grey1,
                                                                  )),
                                                            ),
                                                      );
                                                      _notifyUserBloc.notifyUserBlocFunction(body, token);
                                                    },
                                                    child: Image.asset('images/bell.png',height: scH*0.03,color: purpleColor,)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: scW*0.07,right: scW*0.03,top: scH*0.007),
                                          child: divider,
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            }else {
                              return Container(
                                height: scH*0.2,
                                child: Center(
                                  child: Text("No vaccination center found",
                                    style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                  ),
                                ),
                              );
                            }
                          }else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Container(
                              height: scH*0.2,
                              child: Center(
                                child: Text("Something went wrong please try again",
                                  style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                ),
                              ),
                            );
                          }else {
                            return Padding(
                              padding: EdgeInsets.only(top: scH*0.04),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    grey1,
                                  ),
                                ),
                              ),
                            );
                          }
                        }):
                    Container(),
                  ],
                ):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: scW*0.06,top: scH*0.02),
                              child: Text('State',
                                style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                              ),
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
                                                  StateIdTemp= dropdownStateId[a];
                                                  print(StateIdTemp);
                                                  waitForDistrict = true;
                                                  _dropDownDistrictValue=null;
                                                  _districtListingFuture = _districtListingRepository.districtListingRepositoryFunction(StateIdTemp);
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
                                    return Container( width: scW * 0.43,
                                      height: 33,
                                      margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                                      color: secondColor,
                                    );
                                  }else {
                                    return Container( width: scW * 0.43,
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
                              padding: EdgeInsets.only(left: scW*0.04,top: scH*0.02,right: scW*0.05),
                              child: Text('District',
                                style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                              ),
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
                                                  DistrictIdTemp = dropdownDistrictId[a];
                                                  print(DistrictIdTemp);
                                                  _vaccinationCentersByDistrictIdFuture = _vaccinationCentersByDistrictIdRepository.vaccinationCentersByDistrictIdRepositoryFunction(DistrictIdTemp);
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
                                    return Container(
                                      width: scW * 0.43,
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
                    Padding(
                      padding: EdgeInsets.only(top: scH*0.02),
                        child: row1,
                    ),
                    row2,
                    FutureBuilder<VaccinationCentersByDistrictIdModel>(
                        future: _vaccinationCentersByDistrictIdFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.data.centers.length != 0) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: scH*0.03),
                                  itemCount: snapshot.data.data.centers.length,
                                  itemBuilder: (context,index) =>
                                      Visibility(
                                        visible: (indexForAll==true) ? true :
                                        ((indexFor18 == true? snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==18) : false) ||
                                            (indexFor45 == true? snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==45) : false) ||
                                            (indexForCovaxin == true? snapshot.data.data.centers[index].sessions.any((element) => element.vaccine=="COVAXIN") : false) ||
                                            (indexForCovidsheild == true? snapshot.data.data.centers[index].sessions.any((element) => element.vaccine=="COVISHIELD") : false) ||
                                            (indexForDose1 == true? snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacityDose1>0) : false) ||
                                            (indexForDose2 == true? snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacityDose2>0) : false)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 8,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: scW*0.07,top: scH*0.005),
                                                        child: Text(snapshot.data.data.centers[index].name,
                                                          style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(left: scW*0.07,top: scH*0.01),
                                                            child: Text('Available',
                                                              style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.availableCapacity>0))?purpleColor:grey2,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                                                            child: Text('18+',
                                                              style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==18))? purpleColor : grey2 ,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                                                            child: Text('45+',
                                                              style: TextStyle(color: (snapshot.data.data.centers[index].sessions.any((element) => element.minAgeLimit==45))? purpleColor : grey2 ,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: InkWell(
                                                    onTap: (){
                                                      streamCheck=true;
                                                      Map body={
                                                        "district_id": DistrictIdTemp.toString(),
                                                      };
                                                      showDialog(
                                                        useRootNavigator: false,
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) =>
                                                            Center(
                                                              child: CircularProgressIndicator(
                                                                  strokeWidth: 2.0,
                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                    grey1,
                                                                  )),
                                                            ),
                                                      );
                                                      _notifyUserBloc.notifyUserBlocFunction(body, token);
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: scW*0.1),
                                                      child: Image.asset('images/bell.png',height: scH*0.03,color: purpleColor,),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: scW*0.07,right: scW*0.03,top: scH*0.007),
                                              child: divider
                                            ),
                                          ],
                                        ),
                                      )
                              );
                            }else {
                              return Container(
                                height: scH*0.2,
                                child: Center(
                                  child: Text("No vaccination center found",
                                    style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                  ),
                                ),
                              );
                            }
                          }else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Container(
                              height: scH*0.2,
                              child: Center(
                                child: Text("Something went wrong please try again",
                                  style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                ),
                              ),
                            );
                          }else {
                            return _dropDownDistrictValue!=null?
                              Padding(
                              padding: EdgeInsets.only(top: scH*0.04),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    grey1,
                                  ),
                                ),
                              ),
                            ):Container();
                          }
                        }),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
