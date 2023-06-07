
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_dashboard_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../libary/sector.dart';
import '../util/appcontants.dart';

class ChartHomePage extends StatefulWidget {
  const ChartHomePage({Key? key}) : super(key: key);

  @override
  PieChartWidget createState() => PieChartWidget();
}

class PieChartWidget extends State<ChartHomePage> {

  List<ChildDashBoardUserAgeRef> dasboardList = [];

  int group1Total = 0;
  int group1Medium = 0;
  int group1Normal = 0;
  int group1Low = 0;

  int group2Total = 0;
  int group2Medium = 0;
  int group2Normal = 0;
  int group2Low = 0;

  int group3Total = 0;
  int group3Medium = 0;
  int group3Normal = 0;
  int group3Low = 0;

  int group4Total = 0;
  int group4Medium = 0;
  int group4Normal = 0;
  int group4Low = 0;

  getDetails() async {

    dasboardList = (await ApiService().getChildDashBoardUserAgeRef())!;

    setState(() {

      for(int i= 0; i< dasboardList.length;i++) {

        if(dasboardList[i].name == "GROUP 1") {
          group1Total = dasboardList[i].totalChildren!;
          group1Normal = dasboardList[i].normal!;
          group1Medium = dasboardList[i].medium!;
          group1Low = dasboardList[i].low!;

        }  if(dasboardList[i].name == "GROUP 2") {
          group2Total = dasboardList[i].totalChildren!;
          group2Normal = dasboardList[i].normal!;
          group2Medium = dasboardList[i].medium!;
          group2Low = dasboardList[i].low!;

        }  if(dasboardList[i].name == "GROUP 3") {
          group3Total = dasboardList[i].totalChildren!;
          group1Normal = dasboardList[i].normal!;
          group3Medium = dasboardList[i].medium!;
          group3Low = dasboardList[i].low!;

        }
      }

      group4Total = group3Total + group2Total + group1Total;
      group4Normal = group3Normal + group2Normal + group1Normal;
      group4Medium = group3Medium + group2Medium + group1Medium;
      group4Low = group3Low + group2Low + group1Low;
    });
    print(dasboardList!.length);
  }

  List<Sector> get industrySectors {
    return [
      Sector(
          color: Colors.red,
          value: group1Medium.toDouble(),
          title: ''),
      Sector(
          color: Colors.green,
          value: group1Normal.toDouble(),
          title: ''),
      Sector(
          color: Colors.orange,
          value: group1Low.toDouble(),
          title: ''),
    ];
  }

  List<Sector> get industrySectors2 {
    return [
      Sector(
          color: Colors.red,
          value: group2Medium.toDouble(),
          title: ''),
      Sector(
          color: Colors.green,
          value: group2Normal.toDouble(),
          title: ''),
      Sector(
          color: Colors.orange,
          value: group2Low.toDouble(),
          title: ''),
    ];
  }

  List<Sector> get industrySectors3 {
    return [
      Sector(
          color: Colors.red,
          value: group3Medium.toDouble(),
          title: ''),
      Sector(
          color: Colors.green,
          value: group3Normal.toDouble(),
          title: ''),
      Sector(
          color: Colors.orange,
          value: group3Low.toDouble(),
          title: ''),
    ];
  }

  List<Sector> get industrySectors4 {
    return [
      Sector(
          color: Colors.red,
          value: group4Medium.toDouble(),
          title: ''),
      Sector(
          color: Colors.green,
          value: group4Normal.toDouble(),
          title: ''),
      Sector(
          color: Colors.orange,
          value: group4Low.toDouble(),
          title: ''),
    ];
  }

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  @override
  void initState() {
    super.initState();
    getDetails();
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
                child: Text("कूल  सर्वेक्षण ",style: style,),
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
                              child: Text("उम्र (0 - 6 महीने)",style: style,),
                            ),
                          ),
                        )),


                    Flexible(
                        flex: 3,
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("उम्र (7 महीने - 3 वर्ष)",style: style,),
                            ),
                          ),
                        )),

                    Flexible(
                        flex: 3,
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("उम्र (3 - 6 वर्ष)",style: style,),
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
                        flex: 3,
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
                                  child: Text("कूल",style: style,)
                              ),

                              Center(
                                  child: Text("$group1Total",style: style,)
                              ),

                              SizedBox(height: 10,)


                            ],

                          ),
                        )),

                    Flexible(
                        flex: 3,
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
                                  child: Text("कूल",style: style,)
                              ),

                              Center(
                                  child: Text("$group2Total",style: style,)
                              ),

                              SizedBox(height: 10,)


                            ],

                          ),
                        )),

                    Flexible(
                        flex: 3,
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
                                  child: Text("कूल",style: style,)
                              ),

                              Center(
                                  child: Text("$group3Total",style: style,)
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
                                    text: "  कूल : ${group4Total}",style: style,
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
                                    text: "  सामान्य  : ${group4Normal}",style: style,
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
                                    text: "  मध्यम  : ${group4Medium}",style: style,
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
                                    text: "  गंभीर   : ${group4Low}",style: style,
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