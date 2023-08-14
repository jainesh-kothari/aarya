import 'package:arya/children/child_home_page.dart';
import 'package:arya/ladies/ladies_home_page.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/ladies/ladies_list_view.dart';
import 'package:arya/registration/ladies_dashboard.dart';
import 'package:arya/registration/my_profile.dart';
import 'package:arya/start_up/change_language.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../selfhelpgroup/self_help_group_listview.dart';
import '../start_up/contact_us.dart';
import 'child_dashboard.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

 late DateTime currentBackPressTime;
 AppConstants api = AppConstants();

 late SharedPreferences _sharedPreferences;
 bool is_arya = false;
 bool is_gnm = false;
 bool is_sathin = false;

 @override
  void initState() {
    _getDetails();
   super.initState();

   // age_ref4 = eng_lang == true ? "Self Help Group" : "स्वयं सहायता समूह";

  }

 _getDetails() async {
   _sharedPreferences = await SharedPreferences.getInstance();
   setState(() {
     is_arya = _sharedPreferences.getBool(AppConstants.IS_ARYA)!;
     is_gnm = _sharedPreferences.getBool(AppConstants.IS_GNM)!;
     is_sathin = _sharedPreferences.getBool(AppConstants.IS_SATHIN)!;
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

              Container(
                child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey,width: 0.3,),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: InkWell(
                      onTap: (){
                        if(is_gnm) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesHomePage()));
                        } else{
                          Fluttertoast.showToast(msg: "User not register as GNM");
                        }


                      },
                      child: Column(

                        children: [

                          Center(

                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/lady_one.png"),
                                    fit: BoxFit.fill,
                                  )),


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

              SizedBox(height: 10),

              Container(
                child: Card(
                  // color: Color(AppConstants.GRAY_COLOR[4]),
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey,width: 0.3,),
                        borderRadius: BorderRadius.circular(15.0)),

                    child: InkWell(
                      onTap: (){

                        if(is_arya) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChildHomePage()));
                        } else{
                          Fluttertoast.showToast(msg: "User not register as Arya");
                        }
                      },
                      child: Column(

                        children: [

                          Center(
                            child:
                            Container(

                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/ch3.png"),
                                      fit: BoxFit.fill,
                                    ))

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(AppTranslations.of(context)!.text("children_heading"), style: TextStyle(
                                fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                            )),
                          )


                        ],
                      ),
                    )),
              ),

              SizedBox(height: 10),

              Visibility(
                visible: true,
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


                          if(is_sathin) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesSelfHelpListview()));
                          } else{
                            Fluttertoast.showToast(msg: "User not register as self help group");
                          }
                          },
                        child: Column(

                          children: [
                          Center(
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/images/ld4.jpg"),
                                fit: BoxFit.fill,
                              )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("Self Help Group", style: TextStyle(
                                  fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                              )),
                            )


                          ],
                        ),
                      )),
                ),
              ),

              SizedBox(height: 10),

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

            ExpansionTile(
              leading: Icon(Icons.dashboard_outlined),
              title: Text("DashBoard"),

              children: [


                Visibility(
                  visible: is_gnm,
                  child: ListTile(
                    title: Text("Ladies Dashboard"),
                    onTap: (){

                      if(is_gnm) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesDashBoard()));
                      } else{
                        Fluttertoast.showToast(msg: "User not register as GNM");
                      }
                    },
                  ),
                ),

                Visibility(
                  visible: is_arya,
                  child: ListTile(
                    title: Text("Child Dashboard"),
                    onTap: (){

                      if(is_arya) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChartHomePage()));
                      } else{
                        Fluttertoast.showToast(msg: "User not register as Arya");
                      }
                    },
                  ),
                ),

              ],

            ),
            ListTile(
              leading: Icon(Icons.person), title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ContactUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined), title: Text("LogOut"),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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