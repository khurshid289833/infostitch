import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/addComments/bloc/addCommentsBloc.dart';
import 'package:infostitch/screen/addComments/model/addCommentsModel.dart';
import 'package:infostitch/screen/addComments/model/categoryListingModel.dart';
import 'package:infostitch/screen/addComments/model/subCategoryListingModel.dart';
import 'package:infostitch/screen/addComments/repository/categoryListingRepository.dart';
import 'package:infostitch/screen/addComments/repository/subCategoryListingModel.dart';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddComments extends StatefulWidget {
  String hospitalID;
  AddComments(this.hospitalID);
  @override
  _AddCommentsState createState() => _AddCommentsState(hospitalID);
}

class _AddCommentsState extends State<AddComments> {
  String hospitalID;
  _AddCommentsState(this.hospitalID);

  final _formKey = GlobalKey<FormState>();
  bool streamCheck=false;
  AddCommentsBloc _addCommentsBloc;
  TextEditingController commentsController = TextEditingController();

  Future<CategoryListingModel> _categoryListingFuture;
  CategoryListingRepository _categoryListingRepository;

  Future<SubCategoryListingModel> _subCategoryListingFuture;
  SubCategoryListingRepository _subCategoryListingRepository;

  List<String> dropdown1=[];
  List<int> dropdownCatId=[];
  List<String> dropdown2=[];
  List<int> dropdownSubCatId=[];
  String _dropDownCatValue;
  String _dropDownSubCatValue;
  bool waitForCat=true;
  int category_id;
  int sub_category_id;

  String token;
  SharedPreferences _sharedPreferences;
  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    token = _sharedPreferences.getString("access_token");
    _categoryListingFuture = _categoryListingRepository.categoryListingRepositoryFunction();
    setState(() {});
  }

  @override
  void initState() {
    _addCommentsBloc = AddCommentsBloc();
    _categoryListingRepository = CategoryListingRepository();
    _subCategoryListingRepository = SubCategoryListingRepository();
    createSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            cross(scH,scW),
            Padding(
              padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.005),
              child: heading('Add Comments'),
            ),
            Padding(
              padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
              child: divider,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: scW*0.05,top: scH*0.04),
                  child: Text('Category',
                    style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                  ),
                ),
                FutureBuilder<CategoryListingModel>(
                    future: _categoryListingFuture,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                          dropdown1.clear();
                          for(int i=0;i<snapshot.data.data.length;i++){
                            dropdown1.add(snapshot.data.data[i].categoryName);
                            dropdownCatId.add(int.parse(snapshot.data.data[i].id));
                          }
                          return Container(
                            width: scW,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
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
                                      _dropDownCatValue = value;
                                      int a= dropdown1.indexOf(_dropDownCatValue);
                                      category_id= dropdownCatId[a];
                                      waitForCat = true;
                                      _dropDownSubCatValue=null;
                                      _subCategoryListingFuture = _subCategoryListingRepository.subCategoryListingRepositoryFunction(category_id);
                                      _subCategoryListingFuture.whenComplete(() =>
                                          setState(() {
                                            waitForCat=false;
                                          }
                                          ));
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down_sharp,size: scH*0.038,color: Color.fromRGBO(255, 255, 255, 0.4),),
                                  hint: _dropDownCatValue==null?Text('Select Category',
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ):
                                  Text(_dropDownCatValue,
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
                          width: scW,
                          height: 33,
                          margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
                          color: secondColor,
                        );
                      }else {
                        return Container(
                          width: scW,
                          height: 33,
                          margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
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
                  padding: EdgeInsets.only(left: scW*0.05,top: scH*0.03,right: scW*0.05),
                  child: Text('Sub Category',
                    style: TextStyle(fontSize: scW*0.04,color: grey1,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                  ),
                ),
                waitForCat==false?
                FutureBuilder<SubCategoryListingModel>(
                    future: _subCategoryListingFuture,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                          dropdown2.clear();
                          for(int i=0;i<snapshot.data.data.length;i++){
                            dropdown2.add(snapshot.data.data[i].subcategoryName);
                            dropdownSubCatId.add(int.parse(snapshot.data.data[i].id));
                          }
                          return Container(
                            width: scW,
                            height: 33,
                            margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
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
                                      _dropDownSubCatValue = value;
                                      int a= dropdown2.indexOf(_dropDownSubCatValue);
                                      sub_category_id= dropdownSubCatId[a];
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down_sharp,size: scH*0.038,color: Color.fromRGBO(255, 255, 255, 0.4),),
                                  hint: _dropDownSubCatValue==null?Text('Select Sub Category',
                                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4)),
                                  ):
                                  Text(_dropDownSubCatValue,
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
                          width: scW,
                          height: 33,
                          margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
                          color: secondColor,
                        );
                      }else {
                        return Container(
                          width: scW,
                          height: 33,
                          margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
                          color: secondColor,
                        );
                      }
                    }
                ):
                Container(
                  width: scW,
                  height: 33,
                  margin: EdgeInsets.only(left: scW*0.05,top: scH*0.01,right: scW*0.05),
                  color: secondColor,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: scW * 0.05, right: scW * 0.05, top: scH * 0.04),
              child: TextFormField(
                controller: commentsController,
                validator: (val) {
                  if (val.length == 0)
                    return "Please leave a comment";
                  else
                    return null;
                },
                cursorColor: grey2,
                maxLines: 3,
                style: TextStyle(color: grey1),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: bgColor,
                  hintText: 'Leave a comment',
                  hintStyle: TextStyle(fontSize: scW * 0.04,color: grey2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: grey2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: grey2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: grey2),
                  ),
                ),
              ),
            ),
            Container(
              height: 45,
              width: scW,
              margin: EdgeInsets.only(left: scW*0.3,right: scW*0.3,top: scH*0.06,bottom: scH*0.04),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                color: purpleColor,
                elevation: 10,
                onPressed: (){
                  if (_formKey.currentState.validate()&&_dropDownCatValue!=null&&_dropDownSubCatValue!=null){
                    Map body = {
                      "hospital_id": hospitalID,
                      "comment": commentsController.text,
                      "category_id": category_id.toString(),
                      "subcategory_id": sub_category_id.toString()
                    };
                    print(body);
                    streamCheck = true;
                    _addCommentsBloc.addCommentsBlocFunction(body, token);
                  }else if(_dropDownCatValue==null){
                    Fluttertoast.showToast(
                        msg: "Please Select Category",
                        fontSize: 16,
                        backgroundColor: bgColor,
                        textColor: grey1,
                        toastLength: Toast.LENGTH_LONG);
                  }else if(_dropDownSubCatValue==null){
                    Fluttertoast.showToast(
                        msg: "Please Select Sub Category",
                        fontSize: 16,
                        backgroundColor: bgColor,
                        textColor: grey1,
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
                child: StreamBuilder<ApiResponse<AddCommentsModel>>(
                    stream: _addCommentsBloc.addCommentsBlocStream,
                    builder: (context, snapshot) {
                      if (streamCheck) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      grey1,
                                    ),
                                  ),
                                ),
                              );
                              break;

                            case Status.COMPLETED:
                              streamCheck = false;
                              Future.delayed(Duration.zero, () async {
                                Fluttertoast.showToast(
                                    msg: "Comment added Successfully",
                                    fontSize: 16,
                                    backgroundColor: bgColor,
                                    textColor: grey1,
                                    toastLength: Toast.LENGTH_LONG);
                                Get.back();
                                commentsController.clear();
                              });
                              print("api call done");
                              break;

                            case Status.ERROR:
                              streamCheck = false;
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
                      return Center(
                        child: Text('ADD COMMENT',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
