import 'dart:convert';
import 'package:arya/forget_password/forgot_pin_otp_verify.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPassword> {
  FocusNode? _focusNode;
  TextEditingController txt_mobile = new TextEditingController(text: '');
  late DateTime currentBackPressTime;

  AppConstants api = new AppConstants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        Text(
                          AppTranslations.of(context)!.text("forget_password"),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30,
                        ),


                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Color(AppConstants.GRAY_COLOR[0]),
                                height: 49,
                                margin: EdgeInsets.only(left: 10, top: 2, right: 2),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child:
                                      Image.asset('assets/images/india_flag.png'),
                                    ),
                                    Text("+91",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 9.0, left: 10.0, right: 20.0),
                                child: TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                    ],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    controller: txt_mobile,
                                    focusNode: _focusNode,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14),
                                        hintText: AppTranslations.of(context)!.text("enter_mobile_number"),
                                        counter: Container(),
                                        border: InputBorder.none,
                                        fillColor:
                                        Color(AppConstants.GRAY_COLOR[0])),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),

                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ForgotPinOTPVerification("mobile_no")));
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
                                  AppTranslations.of(context)!.text("submit"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
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
          )),
    );
  }
}