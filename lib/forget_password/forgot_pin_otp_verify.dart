import 'dart:convert';
import 'package:arya/forget_password/forget_create_pin_screen.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/pin_code_fields.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../libary/bouncing_button.dart';

class ForgotPinOTPVerification extends StatefulWidget {

  String mobile_no;
  ForgotPinOTPVerification(this.mobile_no);

  @override
  _ForgotPinOTPVerificationScreenState createState() => _ForgotPinOTPVerificationScreenState(mobile_no);
}

class _ForgotPinOTPVerificationScreenState extends State<ForgotPinOTPVerification> {

  String currentText = "";
  String mobile_no;

  _ForgotPinOTPVerificationScreenState(this.mobile_no);
  AppConstants api = new AppConstants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: api.gradient()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 130.0, left: 30.0, right: 30.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          AppTranslations.of(context)!.text("app_name"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(AppConstants.GRAY_COLOR[4]),

                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ), //BorderRadius.all
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Mobile number verification",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Text("Enter your OTP code below",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0,
                                color: Colors.black)),

                        SizedBox(height: 20.0),

                        Column(
                          children: [
                            Container(
                              width: 250,
                              child: PinCodeTextFieldOlder(
                                length: 4,
                                obsecureText: true,
                                animationType: AnimationType.fade,
                                shape: PinCodeFieldShape.box,
                                animationDuration:
                                Duration(milliseconds: 100),
                                borderRadius: BorderRadius.circular(0),
                                fieldHeight: 50,
                                backgroundColor:
                                Color(AppConstants.GRAY_COLOR[4]),
                                fieldWidth: 50,
                                currentText: (value) {
                                  print(value);
                                  setState(() {
                                    // currentText = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 20.0),

                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ForgetCreatePinScreen()));
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 40.0, right: 40),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: api.gradient(),
                                  borderRadius: BorderRadius.circular(10),
                                  border: const Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  )),
                              child: Center(
                                child: Text(
                                  AppTranslations.of(context)!.text("verify").toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),





                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Edit Phone Number",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14.0,
                                            decoration: TextDecoration.underline,
                                            color: Colors.black45))),
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Bouncing(
                                    onPress: () {
                                      // _resendOTP(mobile_no);
                                    },
                                    child: Text(
                                        "Resend OTP", textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14.0,
                                            color: Colors.black,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.0),
                      ],
                    ), //BoxDecoration
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,

                  ),
                ),
              ],
            ),
          ))
    );
  }
}