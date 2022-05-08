import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/hospitalDetails/hospitalDetails.dart';
import 'package:infostitch/screen/manageSaved/model/savedListingModel.dart';
import 'package:infostitch/screen/manageSaved/repository/savedListingRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageSaved extends StatefulWidget {
  @override
  _ManageSavedState createState() => _ManageSavedState();
}

class _ManageSavedState extends State<ManageSaved> {

  Future<SavedListingModel> _futureSavedListing;
  SavedListingRepository _savedListingRepository;

  int i;
  bool streamCheckForSaved=false;
  bool isLoading = false;
  bool inc;

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

  String token;
  SharedPreferences _sharedPreferences;
  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");
    _savedListingRepository = SavedListingRepository();
    _futureSavedListing = _savedListingRepository.savedListingRepositoryFunction(1, token);
    setState(() {
      streamCheckForSaved=true;
    });
  }

  int pageForSaved = 1;
  Future _loadDataForHospitals() async {
    inc==true?pageForSaved=pageForSaved+1:inc = false;

    inc==true? _futureSavedListing = _savedListingRepository.savedListingRepositoryFunction(pageForSaved, token) : null;

    _futureSavedListing.whenComplete(() =>
        setState(() {
          isLoading = false;
          inc = false;
          streamCheckForSaved = true;
        })
    );
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
            child: heading('Saved'),
          ),
          Padding(
            padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
            child: divider,
          ),
          // Row(
          //   children: [
          //     Container(
          //       height: 33,
          //       width: scW*0.2,
          //       margin: EdgeInsets.only(left: scW*0.05,top: scH*0.005,right: scW*0.75),
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
                FutureBuilder<SavedListingModel>(
                    future: _futureSavedListing,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.datum.hospitals.data.length != 0) {
                          if(streamCheckForSaved)
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
                              isSaved.add(true);
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
                                streamCheckForSaved = false;
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
                                  padding: EdgeInsets.only(top: scH*0.04),
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
                            height: scH*0.6,
                            child: Center(
                              child: Text("No saved hospital found",
                                style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                              ),
                            ),
                          );
                        }
                      }else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Container(
                          height: scH*0.6,
                          child: Center(
                            child: Text("Something went wrong please try again",
                              style: TextStyle(color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: scH*0.6,
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
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: Padding(
          //         padding: EdgeInsets.only(left: scW*0.06,top: scH*0.08),
          //         child: Image.asset('images/mark.png',height: 19),
          //       ),
          //     ),
          //     Expanded(
          //       flex: 9,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: EdgeInsets.only(left: scW*0.13,top: scH*0.075),
          //             child: Text('Subtitle 1',
          //               style: TextStyle(color: grey1,fontSize: scW*0.04,fontFamily: 'assets/Nunito-SemiBold.ttf'),
          //             ),
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: scW*0.13,top: scH*0.01,right: scW*0.05),
          //             child: Text('Hi i am here to show your saved Hi i am here to show your saved',
          //               style: TextStyle(color: grey2,fontSize: scW*0.038,fontFamily: 'assets/Nunito-SemiBold.ttf'),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: scW*0.23,right: scW*0.05,top: scH*0.01),
          //   child: divider,
          // ),
        ],
      ),
    );
  }
}
