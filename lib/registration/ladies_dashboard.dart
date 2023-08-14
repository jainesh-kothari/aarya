
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_dashboard_model.dart';
import 'package:arya/model/women_dashboard_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../language/app_translations.dart';
import '../libary/sector.dart';
import '../util/appcontants.dart';

class LadiesDashBoard extends StatefulWidget {
  const LadiesDashBoard({Key? key}) : super(key: key);

  @override
  LadiesDashBoardWidget createState() => LadiesDashBoardWidget();
}

class LadiesDashBoardWidget extends State<LadiesDashBoard> {

  late WomenHomePageModel _dashboard;
  late List<WomenHomePageModelData> list;

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

  double total_high_count = 0;
  double total_medium_count = 0;
  double total_low_count = 0;
  double total_count = 0;

  late bool eng_lang;
  bool visible = true;


  getDetails(BuildContext context) async {

    _dashboard = (await ApiService().getWomenDashBoard(context)) as WomenHomePageModel;

    list = _dashboard.data!;

    setState(() {

      total_women_1 = AppTranslations.of(context)!.text("total") + " : 0";
      total_women_2 = AppTranslations.of(context)!.text("total") + " : 0";
      total_women_3 = AppTranslations.of(context)!.text("total") + " : 0";

      for(var item in list) {

        if(item.name! == "Women (18-45 Age)") {
          women_cat_3 = item.id!;
          total_women_3 = AppTranslations.of(context)!.text("total") + " : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_3 = "${i! + j!}";
          medium_women_3 = "${item.lowCount}";
          low_women_3 = "${item.veryLow}";

          total_count = total_count + item.womenCount!;

          total_high_count = total_high_count + i! + j!;
          total_medium_count = total_medium_count + item.lowCount!;
          total_low_count = total_low_count + item.veryLow!;

        }

        if(item.name! == "Pregnant Women") {
          women_cat_2 = item.id!;
          total_women_2 = AppTranslations.of(context)!.text("total") +" : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_2 = "${i! + j!}";
          medium_women_2 = "${item.lowCount}";
          low_women_2 = "${item.veryLow}";
          total_count = total_count + item.womenCount!;
          total_high_count = total_high_count + i! + j!;
          total_medium_count = total_medium_count + item.lowCount!;
          total_low_count = total_low_count + item.veryLow!;
        }

        if(item.name!.trim() == "Adolescent girls") {
          women_cat_1 = item.id!;
          total_women_1 = AppTranslations.of(context)!.text("total") + " : ${item.womenCount!}";

          int? i = item.veryHighCount;
          int? j = item.highCount;

          high_women_1 = "${i! + j!}";
          medium_women_1 = "${item.lowCount}";
          low_women_1 = "${item.veryLow}";
          total_count = total_count + item.womenCount!;
          total_high_count = total_high_count + i! + j!;
          total_medium_count = total_medium_count + item.lowCount!;
          total_low_count = total_low_count + item.veryLow!;
        }
      }

      visible = false;

    });
  }

  List<Sector> get industrySectors {
    return [
      Sector(
          color: Colors.red,
          value: double.parse(high_women_1),
          title: ''),
      Sector(
          color: Colors.green,
          value: double.parse(medium_women_1),
          title: ''),
      Sector(
          color: Colors.orange,
          value: double.parse(low_women_1),
          title: ''),
    ];
  }

  List<Sector> get industrySectors2 {
    return [
      Sector(
          color: Colors.red,
          value: double.parse(high_women_2),
          title: ''),
      Sector(
          color: Colors.green,
          value:double.parse(medium_women_2),
          title: ''),
      Sector(
          color: Colors.orange,
          value: double.parse(low_women_2),
          title: ''),
    ];
  }

  List<Sector> get industrySectors3 {
    return [
      Sector(
          color: Colors.red,
          value: double.parse(high_women_3),
          title: ''),
      Sector(
          color: Colors.green,
          value: double.parse(medium_women_3),
          title: ''),
      Sector(
          color: Colors.orange,
          value: double.parse(low_women_3),
          title: ''),
    ];
  }

  List<Sector> get industrySectors4 {
    return [
      Sector(
          color: Colors.red,
          value: total_high_count,
          title: ''),
      Sector(
          color: Colors.green,
          value: total_medium_count,
          title: ''),
      Sector(
          color: Colors.orange,
          value: total_low_count,
          title: ''),
    ];
  }

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  @override
  void initState() {
    super.initState();
    getDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (

      appBar: AppBar(
        backgroundColor: Color(AppConstants.BLUE_COLOR[0]),
        title: Text("DashBoard"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20),

              Center(
                child: Text("Total",style: style,),
              ),

              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [


                    Flexible(
                        flex: 3,
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Adolescent girls",style: style,),
                                ],
                              ),
                            ),
                          ),
                        )),


                    Flexible(
                        flex: 3,
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text("Pregnant Women",style: style,),
                                ],
                              ),
                            ),
                          ),
                        )),

                    Flexible(
                        flex: 3,
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Women (18-45 Age)",style: style,),
                                ],
                              ),
                            ),
                          ),
                        )),


                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Row(
                  children: [

                    Flexible(
                        flex: 5,
                        child: Card(
                          child: Column(

                            children: [

                              AspectRatio(
                                  aspectRatio: 1.0,
                                  child: PieChart(
                                      PieChartData(
                                        sections: _chartSections(industrySectors),
                                        centerSpaceRadius: 25.0,
                                      ))),


                              Center(
                                  child: Text("${total_women_1}",style: style,)
                              ),

                              SizedBox(height: 10,)


                            ],

                          ),
                        )),

                    Flexible(
                        flex: 5,
                        child: Card(
                          child: Column(

                            children: [

                              AspectRatio(
                                  aspectRatio: 1.0,
                                  child: PieChart(
                                      PieChartData(
                                        sections: _chartSections(industrySectors2),
                                        centerSpaceRadius: 25.0,
                                      ))),


                              Center(
                                  child: Text("${total_women_2}",style: style,)
                              ),

                              SizedBox(height: 10,)


                            ],

                          ),
                        )),

                    Flexible(
                        flex: 5,
                        child: Card(
                          child: Column(

                            children: [

                              AspectRatio(
                                  aspectRatio: 1.0,
                                  child: PieChart(
                                      PieChartData(
                                        sections: _chartSections(industrySectors3),
                                        centerSpaceRadius: 25.0,
                                      ))),


                              Center(
                                  child: Text("${total_women_3}",style: style,)
                              ),

                              SizedBox(height: 10,)


                            ],

                          ),
                        )),


                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(

                    children: [

                      Flexible(
                        flex:6,
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            child: PieChart(
                                PieChartData(
                                  sections: _mainChartSections(industrySectors4),
                                  centerSpaceRadius: 5,
                                ))),),

                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  Total : ${total_count}",style: style,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      color: Colors.green,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  Normal  : ${total_medium_count}",style: style,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5),



                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  Low  : ${total_low_count}",style: style,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 5),

                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      color: Colors.red,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  High   : ${total_high_count}",style: style,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 10,)


                    ],

                  ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 20.0;
      String title = sector.value.toString();
      final data = PieChartSectionData(
          color: sector.color,
          value: sector.value,
          radius: radius,
          title: '$title',
          titleStyle: TextStyle(fontSize: 8,color: Colors.white)
      );
      list.add(data);
    }
    return list;
  }


  List<PieChartSectionData> _mainChartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 100.0;
      String title = sector.value.toString();
      final data = PieChartSectionData(
          color: sector.color,
          value: sector.value,
          radius: radius,
          title: '$title',
          titleStyle: TextStyle(fontSize: 12,color: Colors.white)
      );
      list.add(data);
    }
    return list;
  }
}