import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/profile/bloc/profileUpdateBloc.dart';
import 'package:infostitch/screen/profile/model/profileUpdateModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  final _formKey = GlobalKey<FormState>();

  File profile_pic;

  TextEditingController _nameController;
  TextEditingController _emailController;

  ProfileUpdateBloc _profileUpdateBloc;
  //final String url = "http://eqsxerusrangoon.com/cowin/public/api/upload/profile-image";

  SharedPreferences _sharedPreferences;
  String token;
  String picture;
  String name;
  String email;
  bool streamCheck = false;

  Future<void> createSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    picture = _sharedPreferences.getString("profile_picture");
    name = _sharedPreferences.getString("name");
    email = _sharedPreferences.getString("email");
    token = _sharedPreferences.getString("access_token");
    _nameController = TextEditingController(text: name);
    _emailController = TextEditingController(text: email);
    setState(() {});
  }

  @override
  void initState() {
    createSharedPref();
    _profileUpdateBloc = ProfileUpdateBloc();
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
            cross(scH, scW),
            Padding(
              padding: EdgeInsets.only(left: scW*0.05,bottom: scH*0.005),
              child: heading('Update Profile'),
            ),
            Padding(
              padding: EdgeInsets.only(left: scW*0.05,right: scW*0.05),
              child: divider,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 115),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: grey1,
                    child: CircleAvatar(
                        radius: 49,
                        backgroundImage: profile_pic != null ? FileImage(File(profile_pic.path)) : picture!=null?NetworkImage("$imageURL${picture}"):AssetImage("images/profile_pic.png")
                    ),
                  ),
                  Positioned(
                      top: 55,
                      left: 33,
                      //right: 120,
                      //bottom: 00,
                      child: MaterialButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: InkWell(
                                    onTap: () async {
                                      var picture = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 30);
                                      this.setState(() {
                                        profile_pic = picture;
                                        if (profile_pic == null)
                                          print("image null");
                                        else
                                          print("image not null");
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.photo, size: 50),
                                  ),
                                );
                              });
                        },
                        color: Color.fromRGBO(136, 135, 137, 1),
                        textColor: grey1,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                      )),
                ],
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(left: scW*0.06, right: scW*0.06, top: scH*0.06),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.length == 0)
                    return "Please enter your name";
                  else
                    return null;
                },
                controller: _nameController,
                style: TextStyle(color: grey1),
                cursorColor: Color.fromRGBO(255, 255, 255, 0.4),
                decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                  hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4),fontFamily: 'assets/Nunito-SemiBold.ttf'),
                  fillColor: secondColor,
                  filled: true,
                  prefixIcon: Icon(Icons.person,color: grey1,size: 18,),
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
              margin: EdgeInsets.only(left: scW*0.06, right: scW*0.06, top: scH*0.03),
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.length == 0)
                    return "Please enter email id";
                  else if (!val.contains("@"))
                    return "Please enter valid email id";
                  else
                    return null;
                },
                controller: _emailController,
                style: TextStyle(color: grey1),
                cursorColor: Color.fromRGBO(255, 255, 255, 0.4),
                decoration: InputDecoration(
                  hintText: 'Enter Your Email Id',
                  contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 16),
                  hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.4),fontFamily: 'assets/Nunito-SemiBold.ttf'),
                  fillColor: secondColor,
                  filled: true,
                  prefixIcon: Icon(Icons.email,color: grey1,size: 18,),
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
              margin: EdgeInsets.only(left: scW*0.35,right: scW*0.35,top: scH*0.06,bottom: scH*0.04),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                color: purpleColor,
                elevation: 10,
                onPressed: ()  {
                  if (_formKey.currentState.validate()) {
                    Map body = {
                      "name": _nameController.text,
                      "email": _emailController.text,
                    };
                    print(body);
                    streamCheck = true;
                    _profileUpdateBloc.ProfileUpdateBlocFunction(body, profile_pic,token);
                  }
                },
                child: StreamBuilder<ApiResponse<ProfileUpdateModel>>(
                    stream: _profileUpdateBloc.ProfileUpdateBlocStream,
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
                                _sharedPreferences = await SharedPreferences.getInstance();
                                _sharedPreferences.setString('name', snapshot.data.data.data.name);
                                _sharedPreferences.setString('email', snapshot.data.data.data.email);
                                _sharedPreferences.setString('profile_picture', snapshot.data.data.data.profilePic);
                              });
                              if(snapshot.data.data.success=="user profile updated successfully"){
                                Fluttertoast.showToast(
                                    msg: "Profile Updated Successfully",
                                    fontSize: 16,
                                    backgroundColor: bgColor,
                                    textColor: grey1,
                                    toastLength: Toast.LENGTH_LONG);
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Please check your email id",
                                    fontSize: 16,
                                    backgroundColor: bgColor,
                                    textColor: grey1,
                                    toastLength: Toast.LENGTH_LONG);
                              }
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
                        child: Text('UPDATE',
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
  // Future<String> uploadImage() async {
  //
  //   Map<String, String> headers = { "Authorization": "Bearer " + token};
  //   final request = new http.MultipartRequest('POST', Uri.parse(url));
  //   request.headers.addAll(headers);
  //
  //   print('/////////////////////////////////////////////////////////');
  //   print(token);
  //
  //   profile_pic!=null?
  //   request.files.add(await http.MultipartFile.fromPath('profile_pic',profile_pic.path )) :null;
  //
  //   var res = await request.send();
  //
  //   if (res.statusCode == 200) {
  //     Get.back();
  //     Fluttertoast.showToast(
  //         msg: "Profile Picture Updated Successfully",
  //         fontSize: 16,
  //         backgroundColor: bgColor,
  //         textColor: grey1,
  //         toastLength: Toast.LENGTH_LONG);
  //   }else{
  //     Get.back();
  //     Fluttertoast.showToast(
  //         msg: "Something went wrong while uploading profile picture",
  //         fontSize: 16,
  //         backgroundColor: bgColor,
  //         textColor: grey1,
  //         toastLength: Toast.LENGTH_LONG);
  //   }
  // }
}
