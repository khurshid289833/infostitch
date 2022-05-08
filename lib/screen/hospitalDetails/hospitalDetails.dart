import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/addComments/addComments.dart';
import 'package:infostitch/screen/addReply/bloc/addReplyBloc.dart';
import 'package:infostitch/screen/addReply/model/addReplyModel.dart';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/commentsList/model/commentsListModel.dart';
import 'package:infostitch/screen/commentsList/repository/commentsListRepository.dart';
import 'package:infostitch/screen/hospitalSaved/bloc/hospitalSavedBloc.dart';
import 'package:infostitch/screen/hospitalSaved/model/hospitalSavedModel.dart';
import 'package:infostitch/screen/loginPage/loginPage.dart';
import 'package:infostitch/screen/notification/notification.dart';
import 'package:infostitch/screen/voteForComment/bloc/voteForCommentBloc.dart';
import 'package:infostitch/screen/voteForComment/model/voteForCommentModel.dart';
import 'package:infostitch/screen/voteForHospital/bloc/voteForHospitalBloc.dart';
import 'package:infostitch/screen/voteForHospital/model/voteForHospitalModel.dart';
import 'package:infostitch/screen/voteForPhone/bloc/voteForPhoneBloc.dart';
import 'package:infostitch/screen/voteForPhone/model/voteForPhoneModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetails extends StatefulWidget {
  String hospitalName,cityName,stateName,pincodeValue,googleMapLocation,
      phone1,phone2,hospitalAddress,hospitalId,bed_oxy,bed_wo_oxy,bed_icu,
      bed_wo_icu,bed_venti,avail_bed_oxy,avail_bed_wo_oxy,avail_bed_icu,avail_bed_wo_icu,avail_bed_venti,
      poc_name,poc_number,poc_designation,source,contributorName,contributorImage;
  bool isSaved,isUpvoted,isDownvoted;
  int upVotePhone1,downVotePhone1,upVotePhone2,downVotePhone2;

  HospitalDetails(this.hospitalName,this.cityName,this.stateName,this.pincodeValue,this.googleMapLocation,
      this.phone1,this.phone2,this.hospitalAddress,this.hospitalId,this.bed_oxy,this.bed_wo_oxy,this.bed_icu,
      this.bed_wo_icu,this.bed_venti,this.avail_bed_oxy,this.avail_bed_wo_oxy,this.avail_bed_icu,this.avail_bed_wo_icu,
      this.avail_bed_venti,this.poc_name,this.poc_number,this.poc_designation,this.isSaved,
      this.upVotePhone1, this.downVotePhone1,this.upVotePhone2,this.downVotePhone2,this.isUpvoted,this.isDownvoted,
      this.source,this.contributorName,this.contributorImage);
  @override
  _HospitalDetailsState createState() => _HospitalDetailsState(hospitalName,cityName,stateName,pincodeValue,googleMapLocation,
      phone1,phone2,hospitalAddress,hospitalId,bed_oxy,bed_wo_oxy,bed_icu,
      bed_wo_icu,bed_venti,avail_bed_oxy,avail_bed_wo_oxy,avail_bed_icu,avail_bed_wo_icu,avail_bed_venti,
      poc_name,poc_number,poc_designation,isSaved,upVotePhone1,downVotePhone1,upVotePhone2,downVotePhone2,isUpvoted,isDownvoted,
     source,contributorName,contributorImage);
}

class _HospitalDetailsState extends State<HospitalDetails> {
  String hospitalName,cityName,stateName,pincodeValue,googleMapLocation,
      phone1,phone2,hospitalAddress,hospitalId,bed_oxy,bed_wo_oxy,bed_icu,
      bed_wo_icu,bed_venti,avail_bed_oxy,avail_bed_wo_oxy,avail_bed_icu,avail_bed_wo_icu,avail_bed_venti,
      poc_name,poc_number,poc_designation,source,contributorName,contributorImage;
  bool isSaved,isUpvoted,isDownvoted;
  int upVotePhone1,downVotePhone1,upVotePhone2,downVotePhone2;

  _HospitalDetailsState(this.hospitalName,this.cityName,this.stateName,this.pincodeValue,this.googleMapLocation,
      this.phone1,this.phone2,this.hospitalAddress,this.hospitalId,this.bed_oxy,this.bed_wo_oxy,this.bed_icu,
      this.bed_wo_icu,this.bed_venti,this.avail_bed_oxy,this.avail_bed_wo_oxy,this.avail_bed_icu,this.avail_bed_wo_icu,
      this.avail_bed_venti,this.poc_name,this.poc_number,this.poc_designation,this.isSaved,
      this.upVotePhone1, this.downVotePhone1,this.upVotePhone2,this.downVotePhone2,this.isUpvoted,this.isDownvoted,
      this.source,this.contributorName,this.contributorImage);

  static void navigateTo(String location) async {
    List<String> result = location.split(',');
    String lat = result[0];
    String lng = result[1];
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
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

  String token;
  String user_id;
  SharedPreferences _sharedPreferences;
  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");
    user_id = _sharedPreferences.getString("user_id");
    int hospitalID = int.parse(hospitalId);
    _commentsListFuture = _commentsListRepository.commentsListRepositoryFunction(hospitalID);
    setState(() {});
  }

  Future<CommentsListModel> _commentsListFuture;
  CommentsListRepository _commentsListRepository;

  HospitalSavedBloc _hospitalSavedBloc;
  VoteForHospitalBloc _voteForHospitalBloc;
  VoteForPhoneBloc _voteForPhoneBloc;
  AddReplyBloc _addReplyBloc;
  VoteForCommentBloc _voteForCommentBloc;

  TextEditingController replyController = TextEditingController();
  List visibilityReply=[];
  List visibilityViewReply=[];
  bool streamCheckForHospitalSaved = false;
  bool streamCheckForHospitalVote = false;
  bool streamCheckForPhoneVote = false;
  bool streamCheckForCommentVote = false;
  bool streamCheckForReply = false;
  bool moreComments = true;
  bool waitForFuture = false;
  int commentsLength;

  Color colorForSaved;
  bool checkForSaved;

  Color colorForupVotePhone1;
  int checkForupVotePhone1;
  Color colorFordownVotePhone1;
  int checkFordownVotePhone1;

  Color colorForupVotePhone2;
  int checkForupVotePhone2;
  Color colorFordownVotePhone2;
  int checkFordownVotePhone2;

  bool checkBreakForPhone1UpVote;
  bool checkBreakForPhone1DownVote;
  bool checkBreakForPhone2UpVote;
  bool checkBreakForPhone2DownVote;

  Color colorForUpVoteHospital;
  bool checkForUpVoteHospital;
  Color colorForDownVoteHospital;
  bool checkForDownVoteHospital;
  bool checkBreakForHospitalUpvote;
  bool checkBreakForHospitalDownvote;

  bool hospitalTextSize;

  @override
  void initState() {

    hospitalTextSize = hospitalName.length>18?true:false;
    colorForSaved = isSaved==true?purpleColor:null;
    checkForSaved = isSaved==true?true:false;

    colorForupVotePhone1 = upVotePhone1==1?purpleColor:null;
    checkForupVotePhone1 = upVotePhone1==1?1:0;
    colorFordownVotePhone1 = downVotePhone1==1?purpleColor:null;
    checkFordownVotePhone1 = downVotePhone1==1?1:0;

    colorForupVotePhone2 = upVotePhone2==1?purpleColor:null;
    checkForupVotePhone2 = upVotePhone2==1?1:0;
    colorFordownVotePhone2 = downVotePhone2==1?purpleColor:null;
    checkFordownVotePhone2 = downVotePhone2==1?1:0;

    colorForUpVoteHospital = isUpvoted==true?purpleColor:null;
    checkForUpVoteHospital = isUpvoted==true?true:false;
    colorForDownVoteHospital = isDownvoted==true?purpleColor:null;
    checkForDownVoteHospital = isDownvoted==true?true:false;

    _commentsListRepository = CommentsListRepository();
    _hospitalSavedBloc = HospitalSavedBloc();
    _voteForHospitalBloc = VoteForHospitalBloc();
    _voteForPhoneBloc = VoteForPhoneBloc();
    _addReplyBloc = AddReplyBloc();
    _voteForCommentBloc = VoteForCommentBloc();

    createSharedPref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int totalCapacity = int.parse(bed_oxy)+int.parse(bed_wo_oxy)+int.parse(bed_icu)+int.parse(bed_wo_icu)+int.parse(bed_venti);
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    Widget rowStarting(text1,text2) =>  Row(
      children: [
        Container(
          width: scW*0.27,
          padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
          child: Text(text1,
            style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: scH*0.01),
            child: Text(text2,
              style: TextStyle(color: grey2,fontSize: scW*0.04),
            ),
          ),
        ),
      ],
    );
    Widget headingHospital(heading) =>  Padding(
      padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
      child: Text(heading,
        style: TextStyle(color: grey1,fontSize: 18,fontFamily: 'assets/Nunito-SemiBold.ttf'),
      ),
    );
    Widget rowInsideIncharge(text1,text2) => Row(
      children: [
        Container(
          width: scW*0.32,
          padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
          child: Text(text1,
            style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: scH*0.01),
            child: Text(text2,
              style: TextStyle(color: grey2,fontSize: scW*0.04,),
            ),
          ),
        ),
      ],
    );
    Widget columnForBeds(checkForLeft,heading1,heading2,checkForHeading,availBed,totalBed,checkForRight) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: checkForLeft==true?scW*0.04:scW*0.02,top: scH*0.02,right: checkForRight==true?scW*0.04:0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading1,
                style: TextStyle(color: grey1,fontSize: scW*0.022,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
              checkForHeading==true?
              Text(heading2,
                style: TextStyle(color: grey1,fontSize: scW*0.022,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ):Container(),
            ],
          ),
        ),
        Container(
          height: 30,
          width: scW*0.12,
          margin: EdgeInsets.only(left: checkForLeft==true?scW*0.04:scW*0.02,top: checkForHeading==true?31:40,right: checkForRight==true?scW*0.04:0),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.3)),
          ),
          child: Center(
            child: Text('$availBed/$totalBed',
              style: TextStyle(color: grey1,fontSize: scW*0.022,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: checkForLeft==true?scW*0.04:scW*0.02,top: scH*0.02,right: checkForRight==true?scW*0.04:0),
          child: Text('Available',
            style: TextStyle(color: int.parse(availBed)>0?purpleColor:grey2,fontSize: scW*0.025,fontFamily: 'assets/Nunito-SemiBold.ttf'),
          ),
        ),
      ],
    );
    final verticalLineForBeds = Container(
      margin: EdgeInsets.only(left: scW*0.015,top: scH*0.02),
      color: Color.fromRGBO(255, 255, 255, 0.3),
      height: scH*0.13,
      width: scW*0.002,
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --------Stream Builder for hospital saved----------- ///
              StreamBuilder<ApiResponse<HospitalSavedModel>>(
                  stream: _hospitalSavedBloc.hospitalSavedStream,
                  builder: (context, snapshot) {
                    if (streamCheckForHospitalSaved) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            break;

                          case Status.COMPLETED:
                            Get.back();
                            streamCheckForHospitalSaved = false;
                            Future.delayed(Duration.zero, () async {
                              colorForSaved = checkForSaved==true?null:purpleColor;
                              checkForSaved = checkForSaved==true?false:true;
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: snapshot.data.data.datum.msg,
                                  fontSize: 16,
                                  backgroundColor: bgColor,
                                  textColor: grey1,
                                  toastLength: Toast.LENGTH_LONG);
                            });
                            print("api call done");
                            break;

                          case Status.ERROR:
                            Get.back();
                            streamCheckForHospitalSaved = false;
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
              /// --------Stream builder for hospital upvote and downvote----------- ///
              StreamBuilder<ApiResponse<VoteForHospitalModel>>(
                  stream: _voteForHospitalBloc.voteForHospitalStream,
                  builder: (context, snapshot) {
                    if (streamCheckForHospitalVote) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            break;

                          case Status.COMPLETED:
                            Get.back();
                            streamCheckForHospitalVote = false;
                            Future.delayed(Duration.zero, () async {
                              if(checkForUpVoteHospital!=true&&checkBreakForHospitalUpvote==true){
                                print('upVote Hospital');
                                checkForUpVoteHospital=true;
                                colorForUpVoteHospital=purpleColor;
                                checkForDownVoteHospital=false;
                                colorForDownVoteHospital=null;
                                checkBreakForHospitalUpvote=false;
                                setState(() {});
                              }
                              if(checkForDownVoteHospital!=true&&checkBreakForHospitalDownvote==true){
                                print('downVote Hospital');
                                checkForDownVoteHospital=true;
                                colorForDownVoteHospital=purpleColor;
                                checkForUpVoteHospital=false;
                                colorForUpVoteHospital=null;
                                checkBreakForHospitalDownvote=false;
                                setState(() {});
                              }
                              Fluttertoast.showToast(
                                  msg: snapshot.data.data.datum.msg,
                                  fontSize: 16,
                                  backgroundColor: bgColor,
                                  textColor: grey1,
                                  toastLength: Toast.LENGTH_LONG);
                            });
                            print("api call done");
                            break;

                          case Status.ERROR:
                            Get.back();
                            streamCheckForHospitalVote = false;
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
              /// --------Stream builder for phone upvote and downvote----------- ///
              StreamBuilder<ApiResponse<VoteForPhoneModel>>(
                  stream: _voteForPhoneBloc.voteForPhoneStream,
                  builder: (context, snapshot) {
                    if (streamCheckForPhoneVote) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            break;

                          case Status.COMPLETED:
                            Get.back();
                            streamCheckForPhoneVote = false;
                            Future.delayed(Duration.zero, () async {
                              if(checkForupVotePhone1!=1&&checkBreakForPhone1UpVote==true){
                                checkForupVotePhone1=1;
                                colorForupVotePhone1=purpleColor;
                                checkFordownVotePhone1=0;
                                colorFordownVotePhone1=null;
                                checkBreakForPhone1UpVote=false;
                                setState(() {});
                              }
                              if(checkFordownVotePhone1!=1&&checkBreakForPhone1DownVote==true){
                                checkFordownVotePhone1=1;
                                colorFordownVotePhone1=purpleColor;
                                checkForupVotePhone1=0;
                                colorForupVotePhone1=null;
                                checkBreakForPhone1DownVote=false;
                                setState(() {});
                              }
                              if(checkForupVotePhone2!=1&&checkBreakForPhone2UpVote==true){
                                checkForupVotePhone2=1;
                                colorForupVotePhone2=purpleColor;
                                checkFordownVotePhone2=0;
                                colorFordownVotePhone2=null;
                                checkBreakForPhone2UpVote=false;
                                setState(() {});
                              }
                              if(checkFordownVotePhone2!=1&&checkBreakForPhone2DownVote==true){
                                checkFordownVotePhone2=1;
                                colorFordownVotePhone2=purpleColor;
                                checkForupVotePhone2=0;
                                colorForupVotePhone2=null;
                                checkBreakForPhone2DownVote=false;
                                setState(() {});
                              }
                              Fluttertoast.showToast(
                                  msg: snapshot.data.data.datum.msg,
                                  fontSize: 16,
                                  backgroundColor: bgColor,
                                  textColor: grey1,
                                  toastLength: Toast.LENGTH_LONG);
                            });
                            print("api call done");
                            break;

                          case Status.ERROR:
                            Get.back();
                            streamCheckForPhoneVote = false;
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
              /// --------Stream builder for comment upvote and downvote----------- ///
              StreamBuilder<ApiResponse<VoteForCommentModel>>(
                  stream: _voteForCommentBloc.voteForCommentStream,
                  builder: (context, snapshot) {
                    if (streamCheckForCommentVote) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            break;

                          case Status.COMPLETED:
                            Get.back();
                            streamCheckForCommentVote = false;
                            Future.delayed(Duration.zero, () async {
                              int hospitalID = int.parse(hospitalId);
                              _commentsListFuture = _commentsListRepository.commentsListRepositoryFunction(hospitalID);
                              setState(() {});
                              Fluttertoast.showToast(
                                  msg: snapshot.data.data.success,
                                  fontSize: 16,
                                  backgroundColor: bgColor,
                                  textColor: grey1,
                                  toastLength: Toast.LENGTH_LONG);
                            });
                            print("api call done");
                            break;

                          case Status.ERROR:
                            Get.back();
                            streamCheckForCommentVote = false;
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
              ///-------------------All Widgets---------------------------///
              Padding(
                padding: EdgeInsets.only(right: scW*0.07,top: scH*0.03),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: (){
                        Get.to(Notifications());
                      },
                      child: Image.asset('images/bell.png',height: 19)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.03,top: scH*0.03),
                    child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_outlined,color: purpleColor)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: hospitalTextSize==true?scW*0.11:scW*0.05,right: scW*0.05,top: scH*0.03),
                      child: Center(
                        child: Text(hospitalName,
                          style: TextStyle(color: grey1,fontSize: hospitalTextSize==true?18:26,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scH*0.03,right: scW*0.07),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
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
                          Map body = {
                            "hospital_id": hospitalId,
                            "is_saved": checkForSaved==true?"1":"0"
                          };
                          streamCheckForHospitalSaved = true;
                          _hospitalSavedBloc.hospitalSavedBlocFunction(body, token);
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/bookmark.png',height: 19,color: colorForSaved),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.006,bottom: scH*0.01),
                child: divider,
              ),
              rowStarting('State :', stateName),
              rowStarting('City :', cityName),
              rowStarting('Address :', hospitalAddress),
              rowStarting('Pincode :', pincodeValue),
              Row(
                children: [
                  Container(
                    width: scW*0.27,
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                    child: Text('Location :',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scH*0.01),
                    child: InkWell(
                        onTap: (){
                          navigateTo(googleMapLocation);
                        },
                        child: Image.asset('images/navigation.png',height: 23)
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.025),
                child: divider,
              ),
              headingHospital('Contact Details'),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.02),
                    child: Text('Phone :',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.13,top: scH*0.02),
                    child: InkWell(
                      onTap: (){
                        _launchCaller(phone1);
                      },
                      child: Text(phone1,
                        style: TextStyle(color: grey2,fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.1,top: scH*0.02),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
                          if(checkForupVotePhone1!=1){
                            showDialog(
                              useRootNavigator: false,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(grey1))),
                            );
                            Map body = {
                              "hospital_id": hospitalId,
                              "phone_number": phone1,
                              "vote_status":"upvote"
                            };
                            checkBreakForPhone1UpVote=true;
                            streamCheckForPhoneVote = true;
                            _voteForPhoneBloc.voteForPhoneBlocFunction(body, token);
                          }else{
                            Fluttertoast.showToast(
                                msg: "You have already upVoted this number",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/check-circle.png',height: 23,color: colorForupVotePhone1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.06,top: scH*0.02),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
                          if(checkFordownVotePhone1!=1){
                            showDialog(
                              useRootNavigator: false,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(grey1))),
                            );
                            Map body = {
                              "hospital_id": hospitalId,
                              "phone_number": phone1,
                              "vote_status":"downvote"
                            };
                            checkBreakForPhone1DownVote=true;
                            streamCheckForPhoneVote = true;
                            _voteForPhoneBloc.voteForPhoneBlocFunction(body, token);
                          }else{
                            Fluttertoast.showToast(
                                msg: "You have already downVoted this number",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/x-circle.png',height: 23,color: colorFordownVotePhone1),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.03),
                    child: Text('Mobile :',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.13,top: scH*0.03),
                    child: InkWell(
                      onTap: (){
                        _launchCaller(phone2);
                      },
                      child: Text(phone2,
                        style: TextStyle(color: grey2,fontSize: 15,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.088,top: scH*0.03),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
                          if(checkForupVotePhone2!=1){
                            showDialog(
                              useRootNavigator: false,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(grey1))),
                            );
                            Map body = {
                              "hospital_id": hospitalId,
                              "phone_number": phone2,
                              "vote_status":"upvote"
                            };
                            checkBreakForPhone2UpVote=true;
                            streamCheckForPhoneVote = true;
                            _voteForPhoneBloc.voteForPhoneBlocFunction(body, token);
                          }else{
                            Fluttertoast.showToast(
                                msg: "You have already upVoted this number",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/check-circle.png',height: 23,color: colorForupVotePhone2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: scW*0.06,top: scH*0.03),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
                          if(checkFordownVotePhone2!=1){
                            showDialog(
                              useRootNavigator: false,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(grey1))),
                            );
                            Map body = {
                              "hospital_id": hospitalId,
                              "phone_number": phone2,
                              "vote_status":"downvote"
                            };
                            checkBreakForPhone2DownVote=true;
                            streamCheckForPhoneVote = true;
                            _voteForPhoneBloc.voteForPhoneBlocFunction(body, token);
                          }else{
                            Fluttertoast.showToast(
                                msg: "You have already downVoted this number",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/x-circle.png',height: 23,color: colorFordownVotePhone2),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.035),
                child: divider,
              ),
              headingHospital('Incharge'),
              Padding(
                padding: EdgeInsets.only(top: scH*0.01),
                child: rowInsideIncharge('Name :', poc_name),
              ),
              rowInsideIncharge('Designation :', poc_designation),
              Row(
                children: [
                  Container(
                    width: scW*0.32,
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                    child: Text('Contact',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: scH*0.01),
                      child: InkWell(
                        onTap: (){
                          _launchCaller(poc_number);
                        },
                        child: Text(poc_number,
                          style: TextStyle(color: grey2,fontSize: scW*0.04,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //rowInsideIncharge('Contact :', poc_number),
              Padding(
                padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.025),
                child: divider,
              ),
              headingHospital('Services'),
              Container(
                height: 33,
                width: scW*0.2,
                margin: EdgeInsets.only(left: scW*0.04,top: scH*0.02),
                decoration: BoxDecoration(
                  color: purpleBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text('Beds',
                    style: TextStyle(color: purpleColor),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: scW*0.05,right: scW*0.05,top: scH*0.05,bottom: scH*0.015),
                color: secondColor,
                height: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: scW*0.04,top: scH*0.02),
                          child: Text('Total Capacity',
                            style: TextStyle(color: grey1,fontSize: scW*0.04,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: scW*0.1,top: scH*0.02),
                          child: Text(totalCapacity.toString(),
                            style: TextStyle(color: grey1,fontSize: scW*0.05,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          columnForBeds(true,'W/O Oxygen','',false,avail_bed_wo_oxy, bed_wo_oxy,false),
                          verticalLineForBeds,
                          columnForBeds(false,'With Oxygen','',false,avail_bed_oxy, bed_oxy,false),
                          verticalLineForBeds,
                          columnForBeds(false,'ICU W/O','Oxygen',true,avail_bed_wo_icu,bed_wo_icu,false),
                          verticalLineForBeds,
                          columnForBeds(false, 'ICU with', 'Oxygen', true, avail_bed_icu, bed_icu, false),
                          verticalLineForBeds,
                          columnForBeds(false, 'Ventilator', '', false, avail_bed_venti, bed_venti, true),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: scW*0.05,top: scH*0.015),
                    //   child: Text('*Data synced on 23rd May,21',
                    //     style: TextStyle(color: grey2,fontSize: scW*0.025),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                    child: Text('Source :  ',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: scH*0.01),
                      child: Text(source??'',
                        style: TextStyle(color: grey2,fontSize: scW*0.04,),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: scW*0.05,top: scH*0.01),
                    child: Text('Contributor :  ',
                      style: TextStyle(color: grey1,fontSize: scW*0.04,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scH*0.01),
                    child: CircleAvatar(
                      radius: scW*0.03,
                      backgroundImage: contributorImage!=null?NetworkImage('$imageURL${contributorImage}'):AssetImage('images/profile_pic.png'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: scW*0.02,top: scH*0.01),
                      child: Text(contributorName??'',
                        style: TextStyle(color: grey2,fontSize: scW*0.04,),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: scH*0.03),
                    child: InkWell(
                      onTap: (){
                        if(token!=null){
                          if(checkForUpVoteHospital!=true){
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
                            Map body = {
                              "hospital_id": hospitalId,
                              "vote":"upvote"
                            };
                            checkBreakForHospitalUpvote = true;
                            streamCheckForHospitalVote = true;
                            _voteForHospitalBloc.voteForHospitalBlocFunction(body,token);
                          }else{
                            Fluttertoast.showToast(
                                msg: "You have already upVoted this hospital",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }else{
                          Get.to(LoginPage());
                        }
                      },
                      child: Image.asset('images/check-circle.png',height: 23,color: colorForUpVoteHospital),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: scW*0.05,top: scH*0.03),
                      child: InkWell(
                        onTap: (){
                          if(token!=null){
                            if(checkForDownVoteHospital!=true){
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
                              Map body = {
                                "hospital_id": hospitalId,
                                "vote":"downvote"
                              };
                              checkBreakForHospitalDownvote = true;
                              streamCheckForHospitalVote = true;
                              _voteForHospitalBloc.voteForHospitalBlocFunction(body,token);
                            }else{
                              Fluttertoast.showToast(
                                  msg: "You have already downVoted this hospital",
                                  fontSize: 16,
                                  backgroundColor: bgColor,
                                  textColor: grey1,
                                  toastLength: Toast.LENGTH_LONG);
                            }
                          }else{
                            Get.to(LoginPage());
                          }
                        },
                        child: Image.asset('images/x-circle.png',height: 23,color: colorForDownVoteHospital),
                      ),
                  ),
                  InkWell(
                    onTap: (){
                      token!=null?
                          Get.to(AddComments(hospitalId)).then((value) => {createSharedPref()}):
                          Get.to(LoginPage());
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: scW*0.05,top: scH*0.03,right: scW*0.05),
                        child: Image.asset('images/comment.png',height: 23)
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.025),
                child: divider,
              ),
              headingHospital('Comments'),
              FutureBuilder<CommentsListModel>(
                  future: _commentsListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.length != 0) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: scH*0.015),
                            itemCount: moreComments==true&&snapshot.data.data.length>1?1:snapshot.data.data.length,
                            itemBuilder: (context,index){
                              visibilityReply.add(List.generate(snapshot.data.data.length, (index) => false));
                              visibilityViewReply.add(List.generate(snapshot.data.data.length, (index) => false));
                              Future.delayed(Duration.zero, () async {
                                setState(() {
                                  commentsLength = snapshot.data.data.length;
                                  waitForFuture = true;
                                });
                              });
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:3,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: scW*0.05),
                                          child: Text(snapshot.data.data[index].name,
                                            style: TextStyle(color: grey1,fontSize: scW*0.03,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex:5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.0),
                                              child: Text(snapshot.data.data[index].comment,
                                                style: TextStyle(color: grey1,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                visibilityViewReply[index] = true;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(left: scW*0.05),
                                                child: visibilityViewReply[index] != true?Text('View Reply',
                                                  style: TextStyle(fontSize: scW*0.035,color: purpleColor,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                ):
                                                InkWell(
                                                  onTap: (){
                                                    visibilityViewReply[index] = false;
                                                    setState(() {});
                                                  },
                                                  child: Text('Hide Reply',
                                                    style: TextStyle(fontSize: scW*0.035,color: purpleColor,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.0),
                                            child: InkWell(
                                              onTap: (){
                                                if(token!=null){
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
                                                  Map body = {
                                                    "comment_id": snapshot.data.data[index].commentId,
                                                    "vote_type": "upvote"
                                                  };
                                                  streamCheckForCommentVote = true;
                                                  _voteForCommentBloc.voteForHospitalBlocFunction(body, token);
                                                }else{
                                                  Get.to(LoginPage());
                                                }
                                              },
                                              child: Icon(Icons.keyboard_arrow_up,color: snapshot.data.data[index].userVote.isNotEmpty&&snapshot.data.data[index].userVote[0].voteType=="upvote"?purpleColor:grey1,size: scW*0.07),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: scW*0.005,bottom: scH*0.0),
                                            child: Text('Vote',
                                              style: TextStyle(color: grey2,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: scW*0.01,bottom: scH*0.0),
                                            child: InkWell(
                                              onTap: (){
                                                if(token!=null){
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
                                                  Map body = {
                                                    "comment_id": snapshot.data.data[index].commentId,
                                                    "vote_type": "downvote"
                                                  };
                                                  streamCheckForCommentVote = true;
                                                  _voteForCommentBloc.voteForHospitalBlocFunction(body, token);
                                                }else{
                                                  Get.to(LoginPage());
                                                }
                                              },
                                              child: Icon(Icons.keyboard_arrow_down,color: snapshot.data.data[index].userVote.isNotEmpty&&snapshot.data.data[index].userVote[0].voteType=="downvote"?purpleColor:grey1,size: scW*0.07),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              visibilityReply[index] = true;
                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(left: scW*0.005,bottom: scH*0.0,right: scW*0.04),
                                              child: Text('Reply',
                                                style: TextStyle(color: grey2,fontSize: scW*0.03,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: visibilityViewReply[index]==true?true:false,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.data.data[index].commentReply.length,
                                          itemBuilder: (context,index1){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: scW*0.28,top: scH*0.01),
                                                  child: Text(snapshot.data.data[index].commentReply[index1].name,
                                                    style: TextStyle(fontSize: scW*0.03,color: grey1,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: scW*0.28,right: scW*0.03,top: scH*0.005),
                                                  child: Text(snapshot.data.data[index].commentReply[index1].comment,
                                                    style: TextStyle(fontSize: scW*0.03,color: grey2,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                      )
                                  ),
                                  Visibility(
                                    visible: visibilityReply[index]==true?true:false,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder<ApiResponse<AddReplyModel>>(
                                            stream: _addReplyBloc.addReplyBlocStream,
                                            builder: (context, snapshot) {
                                              if (streamCheckForReply) {
                                                if (snapshot.hasData) {
                                                  switch (snapshot.data.status) {

                                                    case Status.LOADING:
                                                      return Container();
                                                      break;

                                                    case Status.COMPLETED:
                                                      streamCheckForReply = false;
                                                      if (snapshot.data.data.success == "new comment added successfully.") {
                                                        replyController.clear();
                                                        Future.delayed(Duration.zero, () {
                                                          int hospitalID = int.parse(hospitalId);
                                                          _commentsListFuture = _commentsListRepository.commentsListRepositoryFunction(hospitalID);
                                                          setState(() {});
                                                        });
                                                        Fluttertoast.showToast(
                                                            msg: "Reply added successfully",
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 20,
                                                            backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                      print("api call done");
                                                      break;

                                                    case Status.ERROR:
                                                      streamCheckForReply = false;
                                                      Fluttertoast.showToast(
                                                          msg: "Something went wrong please try again",
                                                          toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 20,
                                                          backgroundColor: Color.fromRGBO(114, 111, 111, 0.9),
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);
                                                      print("api call not done");
                                                      break;
                                                  }
                                                }
                                              }
                                              return Container();
                                            }),
                                        Container(
                                          margin: EdgeInsets.only(right: scW*0.04,left: scW*0.04,top: scH*0.01),
                                          height: 45,
                                          child: TextField(
                                            style: TextStyle(fontSize: scW*0.03,color: grey1),
                                            controller: replyController,
                                            cursorColor: grey1,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.send_rounded,size: scW*0.04,color: grey1,),
                                                onPressed: (){
                                                  if(token!=null){
                                                    Map body = {
                                                      "hospital_id": hospitalId.toString(),
                                                      "reply": replyController.text,
                                                      "comment_id": snapshot.data.data[index].commentId
                                                    };
                                                    print(body);
                                                    streamCheckForReply = true;
                                                    _addReplyBloc.addReplyBlocFunction(body, token);
                                                  }else{
                                                    Get.to(LoginPage());
                                                  }
                                                },
                                              ),
                                              hintText: 'Add a Reply',
                                              hintStyle: TextStyle(fontSize: scW * 0.035,color: grey1),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                borderSide: BorderSide(width: 1,color: grey1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                borderSide: BorderSide(width: 1,color: grey1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (){
                                              visibilityReply[index] = false;
                                              setState(() {
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(top: scH*0.01,right: scW*0.04,bottom: scH*0.02),
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(fontSize: scW*0.035,fontWeight: FontWeight.w500,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                                                  )
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: scW*0.04,right: scW*0.04,top: scH*0.001),
                                    child: divider,
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.04),
                                  //   child: Text('58m',
                                  //     style: TextStyle(color: grey2,fontSize: scW*0.03,height: 0.1),
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                        );
                      }else {
                        return Padding(
                          padding: EdgeInsets.only(top: scH*0.04,bottom: scH*0.04),
                          child: Center(
                            child: Text("No comment found",
                              style: TextStyle(color: grey1),
                            ),
                          ),
                        );
                      }
                    }else if (snapshot.hasError) {
                      print(snapshot.error);
                      return  Padding(
                        padding: EdgeInsets.only(top: scH*0.04,bottom: scH*0.04),
                        child: Center(
                          child: Text("Something went wrong please try again",
                            style: TextStyle(color: grey1),
                          ),
                        ),
                      );
                    }else {
                      return Padding(
                        padding: EdgeInsets.only(top: scH*0.04,bottom: scH*0.04),
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
                  }),
              if(waitForFuture==true&&commentsLength>1)
                Visibility(
                visible: moreComments,
                child: Padding(
                  padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.04),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        moreComments = false;
                      });
                    },
                    child: Text('${commentsLength-1} more comments',
                      style: TextStyle(color: grey2,fontSize: scW*0.035,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                    ),
                  ),
                ),
              ),
              if(moreComments==false)
                SizedBox(height: scH*0.04),
            ],
          ),
        ],
      ),
    );
  }
}
