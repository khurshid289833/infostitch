import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infostitch/constant.dart';
import 'package:infostitch/screen/api_base/api_response.dart';
import 'package:infostitch/screen/loginPage/bloc/loginApiCallPageBloc.dart';
import 'package:infostitch/screen/loginPage/model/loginApiCallPageModel.dart';
import 'package:infostitch/screen/myHomePage/myHomePage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  String phoneNumber;
  OTPPage(this.phoneNumber);
  @override
  _OTPPageState createState() => _OTPPageState(phoneNumber);
}

class _OTPPageState extends State<OTPPage> {
  String phoneNumber;
  _OTPPageState(this.phoneNumber);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController otpController = TextEditingController();
  String _verificationCode;

  LoginApiCallPageBloc _loginApiCallPageBloc;
  SharedPreferences _sharedPreferences;

  int secondsRemaining = 59;
  bool enableResend = false;
  Timer timer;

  @override
  void initState() {
    _verifyPhone();
    _loginApiCallPageBloc = LoginApiCallPageBloc();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      }
      if(secondsRemaining==0) {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }


  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }


  _verifyPhone() async {

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber}',

        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          });
        },

        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },

        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },

        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },

        timeout: Duration(seconds: 10),
    );

    setState((){
      secondsRemaining = 59;
      enableResend = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: bgColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          StreamBuilder<ApiResponse<LoginApiCallPageModel>>(
              stream: _loginApiCallPageBloc.LoginApiCallPageBlocStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container();
                      break;

                    case Status.COMPLETED:
                      Get.back();
                      Future.delayed(Duration.zero, () async {
                        _sharedPreferences = await SharedPreferences.getInstance();
                        _sharedPreferences.setString('access_token', snapshot.data.data.data.token);
                        _sharedPreferences.setString('name', snapshot.data.data.data.user.name);
                        _sharedPreferences.setString('phone', snapshot.data.data.data.user.phone);
                        _sharedPreferences.setString('email', snapshot.data.data.data.user.email);
                        _sharedPreferences.setString('device_id', snapshot.data.data.data.user.deviceId);
                        _sharedPreferences.setString('profile_picture', snapshot.data.data.data.user.profilePic);
                        _sharedPreferences.setString('user_id', snapshot.data.data.data.user.id.toString());
                        Fluttertoast.showToast(
                            msg: "Login Successfull",
                            fontSize: 16,
                            backgroundColor: bgColor,
                            textColor: grey1,
                            toastLength: Toast.LENGTH_LONG);
                        Get.offAll(MyHomePage());
                      });
                      print("api call done");
                      break;

                    case Status.ERROR:
                      Get.back();
                      Future.delayed(Duration.zero, () async {
                        Fluttertoast.showToast(
                            msg: "Something went wrong please try again",
                            fontSize: 16,
                            backgroundColor: bgColor,
                            textColor: grey1,
                            toastLength: Toast.LENGTH_LONG);
                        Get.back();
                      });
                      print("api call not done");
                      break;
                  }
                }
                return Container();
              }),
          Padding(
            padding: EdgeInsets.only(top: scH*0.25),
            child: Center(
              child: Text('OTP Verification' ,
                style: TextStyle(fontSize: scW*0.06,color: grey1,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: scH*0.01),
            child: Center(
              child: Text('You will get a one time password',
                style: TextStyle(fontSize: scW*0.035,color: grey2,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: scW * 0.08, right: scW * 0.08,top: scH*0.08),
            child: PinCodeTextField(
              validator: (val) {
                if (val.length == 0)
                  return "Please enter OTP sent to your mobie number";
                else
                  return null;
              },
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              backgroundColor: bgColor,
              cursorColor: grey1,
              enableActiveFill: true,
              textStyle: TextStyle(fontWeight: FontWeight.w400,color: grey1),
              controller: otpController,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderWidth: 1.0,
                fieldHeight: 42,
                fieldWidth: 40,
                inactiveColor: secondColor,
                activeColor: secondColor,
                selectedColor:  secondColor,
                inactiveFillColor:  secondColor,
                activeFillColor: secondColor,
                selectedFillColor: secondColor,
              ),
            ),
          ),
          Container(
            height: 45,
            width: scW,
            margin: EdgeInsets.only(left: scW*0.35,right: scW*0.35,top: scH*0.05),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
              color: purpleColor,
              elevation: 10,
              onPressed: () async {
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
                try {
                  await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: otpController.text)).then((value) async {
                    if (value.user != null) {
                      print(value.user);
                      Map body = {
                        "phone":"+91${phoneNumber}"
                      };
                      _loginApiCallPageBloc.LoginApiCallPageBlocFunction(body);
                    }
                  });
                } catch (e) {
                  Get.back();
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
              child: Text('VERIFY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: scH*0.28),
            child: Center(
              child: Column(
                children: [
                  Text("Didn't received code ? ",
                    style: TextStyle(color: grey1, fontSize: 13.5,fontFamily: 'assets/Nunito-SemiBold.ttf',fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scH*0.005,bottom: scH*0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            enableResend? _verifyPhone():null;
                            enableResend?
                            Fluttertoast.showToast(
                                msg: "Sending OTP to $phoneNumber",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG):
                            Fluttertoast.showToast(
                                msg: "Please wait for $secondsRemaining seconds",
                                fontSize: 16,
                                backgroundColor: bgColor,
                                textColor: grey1,
                                toastLength: Toast.LENGTH_LONG);
                          },
                          child: Text("Resend OTP  ",
                            style: TextStyle(color: purpleColor, fontSize: 13.5,fontWeight: FontWeight.w500,fontFamily: 'assets/Nunito-SemiBold.ttf'),
                          ),
                        ),
                        Text(
                          'in $secondsRemaining seconds',
                          style: TextStyle(color: grey1, fontSize: 13.5,fontFamily: 'assets/Nunito-SemiBold.ttf',fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
