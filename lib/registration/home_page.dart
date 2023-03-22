import 'package:arya/children/child_home_page.dart';
import 'package:arya/ladies/ladies_home_page.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/registration/list_view.dart';
import 'package:arya/start_up/change_language.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

 late DateTime currentBackPressTime;
 AppConstants api = AppConstants();

 late SharedPreferences _sharedPreferences;
 bool is_arya = true;
 bool is_gnm = true;

 @override
  void initState() {
   // _getDetails();
   super.initState();

  }

 _getDetails() async {
   _sharedPreferences = await SharedPreferences.getInstance();
   setState(() {
     is_arya = _sharedPreferences.getBool(AppConstants.IS_ARYA)!;
     is_gnm = _sharedPreferences.getBool(AppConstants.IS_GNM)!;
   });

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.GRAY_COLOR[4]),
      appBar: AppBar(
        title: Text(AppTranslations.of(context)!.text("app_name")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
              gradient: api.gradient(),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [

              Visibility(
               visible: is_gnm,
                child: Container(
                  child: Card(
                    color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey,width: 0.3,),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: InkWell(
                        onTap: (){
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesHomePage()));
                        },
                        child: Column(

                          children: [

                            Center(

                              child: Container(

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: api.gradient(),
                                      borderRadius: BorderRadius.circular(45.0)),

                                  child: Image.asset(
                                      'assets/images/lady_one.png',
                                      fit:BoxFit.fill

                                  )
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(AppTranslations.of(context)!.text("adolescent_girls_and_women"), style: TextStyle(
                                  fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                              )),
                            )


                          ],
                        ),
                      )),
                ),
              ),

              Visibility(
                visible: is_arya,
                child: Container(
                  child: Card(
                     // color: Color(AppConstants.GRAY_COLOR[4]),
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey,width: 0.3,),
                          borderRadius: BorderRadius.circular(15.0)),

                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChildHomePage()));
                        },
                        child: Column(

                          children: [

                            Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Image.asset('assets/images/ch3.png')),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(AppTranslations.of(context)!.text("children"), style: TextStyle(
                                  fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                              )),
                            )


                          ],
                        ),
                      )),
                ),
              )

            ],
          ),
        )),

      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[

            Container(
              height: 250,
              decoration: BoxDecoration(
                  gradient: api.gradient(),
              ),
            ),

            ListTile(
              leading: Icon(Icons.dashboard_outlined), title: Text("DashBoard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person), title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Change Language"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChangeLanguage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts), title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined), title: Text("LogOut"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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