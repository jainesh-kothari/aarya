
import 'package:arya/language/application.dart';
import 'package:arya/registration/home_page.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../language/app_translations.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => new _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {

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

  @override
  void initState() {
    super.initState();
    getAllDetails();
  }


  getAllDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    print("asokjfvhoaiusdhi");
    print(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE));

    setState(() {
      if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "Hindi") {
        language_select = true;
      } else {
        language_select = false;
      }
    });


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
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    return Scaffold(

      body: SafeArea(
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
                          backgroundColor: language_select ? Color(AppConstants.BLUE_COLOR[0]):Colors.white ,
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
                          backgroundColor: language_select ? Colors.white : Color(AppConstants.BLUE_COLOR[0]),
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

                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Done ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
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
        ),
      ),

    );
  }
}