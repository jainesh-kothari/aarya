import 'package:arya/children/children_list_view_category.dart';
import 'package:arya/selfhelpgroup/add_self_help_group.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_dashboard.dart';
import 'package:arya/ladies/ladies_list_view.dart';
import 'package:arya/model/women_dashboard_model.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../selfhelpgroup/self_help_group_listview.dart';


class LadiesHomePage extends StatefulWidget {
  @override
  _LadiesHomePageState createState() => new _LadiesHomePageState();
}

class _LadiesHomePageState extends State<LadiesHomePage> {

  late DateTime currentBackPressTime;
  AppConstants api = AppConstants();

  // late Future<ChildDashBoardDetils?> _dashboard;
  late WomenHomePageModel _dashboard;
  late List<WomenHomePageModelData> list;

  String age_ref1 ="";
  String age_ref2 ="";
  String age_ref3 ="";

  String age_ref1_id ="";
  String age_ref2_id ="";
  String age_ref3_id ="";

  String total_women_1 ="";
  String total_women_2 ="";
  String total_women_3 ="";

  String women_cat_1 ="";
  String women_cat_2 ="";
  String women_cat_3 ="";

  String high_women_1 ="0";
  String high_women_2 ="0";
  String high_women_3 ="0";

  String medium_women_1 ="0";
  String medium_women_2 ="0";
  String medium_women_3 ="0";

  String low_women_1 ="0";
  String low_women_2 ="0";
  String low_women_3 ="0";

  bool visible = true;
  late SharedPreferences _sharedPreferences;
  late bool eng_lang;

  @override
  void initState()  {
    super.initState();
    _getData();
  }

  _getData() async {

    _dashboard = (await ApiService().getWomenDashBoard()) as WomenHomePageModel;

    list = _dashboard.data!;

    _sharedPreferences = await SharedPreferences.getInstance();

    setState(() {



      if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "English") {
        eng_lang = true;
      } else {
        eng_lang = false;
      }


      age_ref1 = eng_lang == true ? "Adolescent girls" : "किशोरियां";
      age_ref2 = eng_lang == true ? "Pregnant Women" : "गर्भवती महिला";
      age_ref3 = eng_lang == true ? "Lactating Mother" : "स्तनपान कराने वाली माँ";

      total_women_1 = AppTranslations.of(context)!.text("total") + " : 0";
      total_women_2 = AppTranslations.of(context)!.text("total") + " : 0";
      total_women_3 = AppTranslations.of(context)!.text("total") + " : 0";

      for(var item in list) {

        if(item.name! == "Lactating Mother") {
          women_cat_3 = item.id!;
          total_women_3 = AppTranslations.of(context)!.text("total") + " : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_3 = "${i! + j!}";
          medium_women_3 = "${item.lowCount}";
          low_women_3 = "${item.veryLow}";

        }

        if(item.name! == "Pregnant Women") {
          women_cat_2 = item.id!;
          total_women_2 = AppTranslations.of(context)!.text("total") +" : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_2 = "${i! + j!}";
          medium_women_2 = "${item.lowCount}";
          low_women_2 = "${item.veryLow}";

        }

        if(item.name! == "Adolescent girls and Lady (15-45 Age)") {
          women_cat_1 = item.id!;
          total_women_1 = AppTranslations.of(context)!.text("total") + " : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_1 = "${i! + j!}";
          medium_women_1 = "${item.lowCount}";
          low_women_1 = "${item.veryLow}";
        }
      }

      visible = false;

      print(women_cat_1);
      print(women_cat_2);
      print(women_cat_3);
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview(women_cat_1, false)));
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
                                                child: Text("$total_women_1", style: const TextStyle(
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview(women_cat_2, true)));
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
                                                child: Text("$total_women_2", style: const TextStyle(
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
                                  children: [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : ${high_women_1} "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : ${medium_women_1} "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : ${low_women_1} "),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : ${high_women_2} "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : ${medium_women_2} "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : ${low_women_2} "),
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesListview(women_cat_3, true)));
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
                                                child: Text("$total_women_3", style: TextStyle(
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
                                child: Container(),
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
                                  children: [

                                    Icon(Icons.circle, color: Colors.red, size: 15,),
                                    Text(" : ${high_women_3} "),
                                    Icon(Icons.circle, color: Colors.yellow, size: 15,),
                                    Text(" : ${medium_women_3} "),
                                    Icon(Icons.circle, color: Colors.green, size: 15,),
                                    Text(" : ${low_women_3} "),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(),
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