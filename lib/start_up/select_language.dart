
import 'package:arya/language/app_translations.dart';
import 'package:arya/language/application.dart';
import 'package:arya/start_up/onbording_screen.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => new _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String label = languagesList[0];
  late SharedPreferences _sharedPreferences;
 late String selectLanguage;
  bool language_select = true;
 late DateTime currentBackPressTime;

  int lang_value = 0 ;

  bool selected_hindi = false;
  bool selected_english = false;

  @override
  void initState() {
    super.initState();
    getAllDetails();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["Hindi"]));
  }


  getAllDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool(AppConstants.IS_FIRST_TIME_OPEN, true);
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }


  void _select(String language) {
    print("dd "+language);
    onLocaleChange(Locale(languagesMap[language]));

    setState(() {
      if (language == "Hindi") {
        label = "हिंदी";
      } else {
        label = language;
      }
    });

    _sharedPreferences.setString(AppConstants.SELECTED_LANGUAGE, language);

    // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));
    bool _flag = true;

    return Scaffold(

      body: SafeArea(
        child: WillPopScope(
            onWillPop: onWillPop,
          child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[

                  SizedBox(height: 30),

                  Container(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset('assets/images/arya_splash.jpg'))),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('Choose Your Language',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center),
                  ),

                  SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                        boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 90, offset: Offset(0, 90))]),
                    child: ElevatedButton(

                      onPressed: () {
                        setState(() {
                          lang_value = 0;
                          language_select = true;
                          selectLanguage = "Hindi";
                          selected_english = false;
                          selected_hindi = true;
                          _select(selectLanguage);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Colors.black // the color of the border
                          ),
                          elevation: 12.0,
                          backgroundColor: selected_hindi ? Color(AppConstants.BLUE_COLOR[0]): Colors.white ,
                          textStyle: const TextStyle(color: Colors.white)),

                      child: const Text("HINDI", style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                        boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 90, offset: Offset(0, 90))]),
                    child: ElevatedButton(

                      onPressed: () {
                        setState(() {
                          lang_value = 1;
                          language_select = false;
                          selectLanguage = "English";

                          selected_english = true;
                          selected_hindi = false;

                          _select(selectLanguage);
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1, // the thickness
                              color: Colors.black // the color of the border
                          ),
                          elevation: 12.0,
                          backgroundColor: selected_english ? Color(AppConstants.BLUE_COLOR[0]) : Colors.white ,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text("English", style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                  ),

                  SizedBox(height: 30),

                  Center(
                    child: InkWell(
                      onTap: () {
                        // FirebaseCrashlytics.instance.crash();

                        if(lang_value == 0) {
                          selectLanguage = "Hindi";
                          _select(selectLanguage);
                        } else {
                          selectLanguage = "English";
                          _select(selectLanguage);
                        }

                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "NEXT ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
                            ),
                            WidgetSpan(
                              child:  Image.asset('assets/images/next_arrow.png',height: 18,width: 18,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        )),
      ),

    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: AppTranslations.of(context)!.text("back_press"));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}