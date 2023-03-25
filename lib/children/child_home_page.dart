import 'package:arya/children/children_list_view_category.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_dashboard.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'children_listview.dart';

class ChildHomePage extends StatefulWidget {
  @override
  _ChildHomePageState createState() => new _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {

  late DateTime currentBackPressTime;
  AppConstants api = AppConstants();

 // late Future<ChildDashBoardDetils?> _dashboard;
  late ChildDashBoardDetils _dashboard;
  late List<UserAgeRef> list;

  String age_ref1 ="";
  String age_ref2 ="";
  String age_ref3 ="";

  String age_ref1_id ="";
  String age_ref2_id ="";
  String age_ref3_id ="";

  String total_child_1 ="";
  String total_child_2 ="";
  String total_child_3 ="";

  bool visible = true;
  late SharedPreferences _sharedPreferences;
  late bool eng_lang;

  @override
  void initState()  {
    super.initState();
    _getData();
  }

  _getData() async {

    _dashboard = (await ApiService().getChildDashBoard()) as ChildDashBoardDetils;
    _sharedPreferences = await SharedPreferences.getInstance();

    setState(() {

      if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "English") {
        eng_lang = true;
      } else {
        eng_lang = false;
      }

      list = _dashboard.data!.userAgeRef!;

     /* age_ref1 = eng_lang == true ? "(0 - 6 Months)" : "(0 - 6 महीने)";
     // age_ref1_id = item.id.toString();
      total_child_1 = AppTranslations.of(context)!.text("total_child");

      age_ref2 = eng_lang == true ? "(6 Month - 3 Years)" : "(6 महीने - 3 वर्ष)";
     // age_ref2_id = item.id.toString();
      total_child_2 = AppTranslations.of(context)!.text("total_child");

      age_ref3 = eng_lang == true ? "(3 - 6 Years)" : "(3 - 6 वर्ष)";
      //age_ref3_id = item.id.toString();
      total_child_3 = AppTranslations.of(context)!.text("total_child");*/

     for(var item in list) {
        if (item.minAge == 0) {
          age_ref1 = eng_lang == true ? "(0 - 6 Months)" : "(0 - 6 महीने)";
          age_ref1_id = item.id.toString();
          total_child_1 = AppTranslations.of(context)!.text("total") + " : " +item.totalChildren.toString();
        } else if (item.minAge == 7) {
          age_ref2 = eng_lang == true ? "(7 Month - 3 Years)" : "(7 महीने - 3 वर्ष)";
          age_ref2_id = item.id.toString();
          total_child_2 = AppTranslations.of(context)!.text("total") + " : " +item.totalChildren.toString();
        } else if (item.minAge == 37) {
          age_ref3 = eng_lang == true ? "(3 - 6 Years)" : "(3 - 6 वर्ष)";
          age_ref3_id = item.id.toString();
          total_child_3 = AppTranslations.of(context)!.text("total") + " : " +item.totalChildren.toString();
        }
      }

      visible = false;
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
            child: Stack(
              children: [

                Column(
                  children: [

                    Column(

                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/ch2.png'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChildrenListViewCategory(age_ref1_id)));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref1", style: TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_1", style: TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),
                                            ],
                                          )),
                                    )),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/ch1.png'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChildrenListViewCategory(age_ref2_id)));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref2", style: const TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_2", style: const TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),
                                            ],
                                          )),
                                    )),
                              ),
                            ),
                          ],
                        ),

                        Row(

                          children: [

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : 1  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 1  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 3  "),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : 3  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 2  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 5  "),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Column(

                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage('assets/images/ch4.png'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChildrenListViewCategory(age_ref3_id)));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref3", style: TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_3", style: TextStyle(
                                                    fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),
                                            ],
                                          )),
                                    )),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 170,
                                ),
                              ),
                            ),

                          ],
                        ),

                        Row(

                          children: [

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : 2  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 4  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 6  "),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(

                                ),
                              ),
                            ),


                          ],
                        ),




                      ],
                    ),

                  ],
                ),

                visible ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ) : Container()



              ],

            ),


          )),


    );
  }
}