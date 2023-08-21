
import 'dart:async';
import 'package:arya/language/application.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/app_version_gs.dart';
import 'package:arya/registration/home_page.dart';
import 'package:arya/start_up/select_language.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../children/add_new_children.dart';
import '../registration/login_screen.dart';
import '../util/appcontants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    super.initState();
    getDetails();
    // getLoginDetails();
  }

  getDetails() async {
    AppVersionGS? response = await ApiService().getAndroidAppVersion();

    if(response?.value.toString() != "v1"){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Version Available'),
            content: Text('A new version of the app is available on the Play Store. Update now to access new features and improvements.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Redirect the user to the Play Store for the update
                  // You can use the 'url_launcher' package to open URLs
                  // Example: await launch('PLAY_STORE_URL');
                  Navigator.of(context).pop();
                },
                child: Text('Update Now'),
              ),
            ],
          );
        },
      );
    } else {
      getLoginDetails();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _sharedPreferences == null ?
        const Image(image: AssetImage('assets/images/splash_english.jpeg'),fit: BoxFit.fill) :

        _sharedPreferences?.getString(AppConstants.SELECTED_LANGUAGE) == "English" ?
        const Image(image: AssetImage('assets/images/splash_english.jpeg'),fit: BoxFit.fill) :

        const Image(image: AssetImage('assets/images/splash_hindi.jpeg'),fit: BoxFit.fill),

      ),
    );
  }


  getLoginDetails() async {

    _sharedPreferences = await SharedPreferences.getInstance();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;


    print(appName);
    print(packageName);
    print("===$version");
    print(buildNumber);

    setState(() {

    if(_sharedPreferences?.getBool(AppConstants.KEY_IS_LOGGEDIN) == null) {
      _sharedPreferences?.setBool(AppConstants.KEY_IS_LOGGEDIN, false);
    } else {
      print(_sharedPreferences?.getBool(AppConstants.KEY_IS_LOGGEDIN));
    }

    if(_sharedPreferences?.getString(AppConstants.SELECTED_LANGUAGE) == null) {
      _sharedPreferences?.setString(AppConstants.SELECTED_LANGUAGE, "English");
    }

    Timer(const Duration(seconds: 2), () => {

          if(_sharedPreferences?.getBool(AppConstants.IS_FIRST_TIME_OPEN) == null) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SelectLanguage()))
          } else if(_sharedPreferences?.getBool(AppConstants.IS_FIRST_TIME_OPEN) == false) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SelectLanguage()))
          } else if(_sharedPreferences?.getBool(AppConstants.KEY_IS_LOGGEDIN) == true){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()))
          }else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
          }
       });
    });
  }
}