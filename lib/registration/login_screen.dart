import 'dart:convert';

import  'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/registration/home_page.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forget_password/forget_password.dart';
import '../libary/bouncing_button.dart';
import '../libary/pin_code_fields.dart';
import '../model/login_gs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<StatefulWidget> {
  late DateTime currentBackPressTime;

  TextEditingController number_controller =  TextEditingController(text:'');
  AppConstants api = AppConstants();

  late String mPin;

  late LoginResponse? _loginResponse;
  late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  _getDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

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
                  padding: const EdgeInsets.only(
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

                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ), //BorderRadius.all
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppTranslations.of(context)!.text("login"),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              makeInput(
                                  label: AppTranslations.of(context)!
                                      .text("enter_mobile_number")),


                              Text(
                                AppTranslations.of(context)!
                                    .text("m_pin"),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),

                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
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
                                const Duration(milliseconds: 100),
                                borderRadius: BorderRadius.circular(0),
                                fieldHeight: 50,
                                backgroundColor:
                                Color(AppConstants.GRAY_COLOR[4]),
                                fieldWidth: 50,
                                currentText: (value) {
                                  print(value);
                                  setState(() {
                                    mPin = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Bouncing(
                                  onPress: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ForgetPassword()));
                                  },
                                  child: Text(
                                      AppTranslations.of(context)!.text(
                                          "forget_password"))),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Bouncing(
                          onPress: () async {

                             String? number = number_controller.text;

                          //  _loginResponse = await ApiService().getLoginDetails(number, mPin)!;
                            _loginResponse = await ApiService().getLoginDetails("7014737142", "1234")!;

                            if(_loginResponse!=null) {
                              _sharedPreferences.setBool(AppConstants.KEY_IS_LOGGEDIN, true);
                              _sharedPreferences.setBool(AppConstants.IS_ARYA, _loginResponse!.data!.user!.isArya!);
                              _sharedPreferences.setBool(AppConstants.IS_GNM, _loginResponse!.data!.user!.isGnm!);
                              _sharedPreferences.setString(AppConstants.TOKEN, _loginResponse!.data!.token.toString());

                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));

                            } else {
                              Fluttertoast.showToast(msg: "Invalid number or Pin");
                            }
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
                                  AppTranslations.of(context)!.text("login"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ), //BoxDecoration
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(AppTranslations.of(context)!.text(
                                "do_not_have_account")),
                            Text(
                              AppTranslations.of(context)!.text("sign_up"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: number_controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))),
            border: OutlineInputBorder(
                borderSide:
                BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
