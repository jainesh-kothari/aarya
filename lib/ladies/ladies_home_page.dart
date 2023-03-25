import 'package:arya/children/children_list_view_category.dart';
import 'package:arya/ladies/self_help_group.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_dashboard.dart';
import 'package:arya/ladies/list_view.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_self_group.dart';


class LadiesHomePage extends StatefulWidget {
  @override
  _LadiesHomePageState createState() => new _LadiesHomePageState();
}

class _LadiesHomePageState extends State<LadiesHomePage> {

  late DateTime currentBackPressTime;
  AppConstants api = AppConstants();

  // late Future<ChildDashBoardDetils?> _dashboard;
  late ChildDashBoardDetils _dashboard;
  late List<UserAgeRef> list;

  String age_ref1 ="";
  String age_ref2 ="";
  String age_ref3 ="";
  String age_ref4 ="";

  String age_ref1_id ="";
  String age_ref2_id ="";
  String age_ref3_id ="";
  String age_ref4_id ="";

  String total_child_1 ="";
  String total_child_2 ="";
  String total_child_3 ="";
  String total_child_4 ="";

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

      age_ref1 = eng_lang == true ? "Adolescent girls" : "किशोरियां";
      age_ref2 = eng_lang == true ? "Pregnant Women" : "गर्भवती महिला";
      age_ref3 = eng_lang == true ? "Lactating Mother" : "स्तनपान कराने वाली माँ";
      age_ref4 = eng_lang == true ? "Self Help Group" : "स्वयं सहायता समूह";

      total_child_1 = AppTranslations.of(context)!.text("total") + " : 15";
      total_child_2 = AppTranslations.of(context)!.text("total") + " : 25";
      total_child_3 = AppTranslations.of(context)!.text("total") + " : 19";
      total_child_4 = AppTranslations.of(context)!.text("total") + " : 18";

      /*for(var item in list) {
        if (item.minAge == 0) {

          age_ref1_id = item.id.toString();
          total_child_1 = item.totalChildren.toString();
        } else if (item.minAge == 6) {

          age_ref2_id = item.id.toString();
          total_child_2 = item.totalChildren.toString();
        } else if (item.minAge == 36) {

          age_ref3_id = item.id.toString();
          total_child_3 = item.totalChildren.toString();
        }
      }*/

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
                                          image: AssetImage('assets/images/ld2.jpeg'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview()));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref1", style: const TextStyle(
                                                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_1", style: const TextStyle(
                                                    fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
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
                                          image: AssetImage('assets/images/ld3.jpeg'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview()));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref2", style: const TextStyle(
                                                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_2", style: const TextStyle(
                                                    fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
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
                                    Text(" : 8  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 3  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 4  "),
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
                                    Text(" : 13  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 2  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 10  "),
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
                                          image: AssetImage('assets/images/ld1.jpeg'),
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview()));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref3", style: TextStyle(
                                                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_3", style: TextStyle(
                                                    fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
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
                                          image: AssetImage('assets/images/ld4.jpg'),
                                          fit:BoxFit.fill
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesSelfHelpListview()));
                                      },
                                      child: Card(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          shadowColor: Colors.black45,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$age_ref4", style: TextStyle(
                                                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                                )),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("$total_child_4", style: TextStyle(
                                                    fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
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
                                    Text(" : 4  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 10  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 5  "),
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
                                    Text(" : 8  "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : 4  "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : 6  "),
                                  ],
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