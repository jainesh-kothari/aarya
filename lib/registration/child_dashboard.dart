
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

  List<Sector> get industrySectors2 {
    return [
      Sector(
          color: Colors.red,
          value: 200,
          title: 'Information Technology'),
      Sector(
          color: Colors.green,
          value: 200,
          title: 'Automobile'),
      Sector(
          color: Colors.orange,
          value: 200,
          title: 'Food'),
      Sector(
          color: Colors.blueAccent,
          value: 0,
          title: 'Finance'),
    ];
  }



  List<Sector> get industrySectors {
    return [
      Sector(
          color: Colors.red,
          value: 50,
          title: 'Information Technology'),
      Sector(
          color: Colors.green,
          value: 80,
          title: 'Automobile'),
      Sector(
          color: Colors.orange,
          value: 70,
          title: 'Food'),
      Sector(
          color: Colors.blueAccent,
          value: 0,
          title: 'Finance'),
    ];
  }

  List<Sector> get industrySectors3 {
    return [
      Sector(
          color: Colors.red,
          value: 40,
          title: 'Information Technology'),
      Sector(
          color: Colors.green,
          value: 80,
          title: 'Automobile'),
      Sector(
          color: Colors.orange,
          value: 80,
          title: 'Food'),
      Sector(
          color: Colors.blueAccent,
          value: 0,
          title: 'Finance'),
    ];
  }


  List<Sector> get industrySectors4 {
    return [
      Sector(
          color: Colors.red,
          value: 75,
          title: 'Information Technology'),
      Sector(
          color: Colors.green,
          value: 75,
          title: 'Automobile'),
      Sector(
          color: Colors.orange,
          value: 50,
          title: 'Food'),
      Sector(
          color: Colors.blueAccent,
          value: 0,
          title: 'Finance'),
    ];
  }

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

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
                              padding: const EdgeInsets.all(8.0),
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
                                  child: Text("200",style: style,)
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
                                  child: Text("200",style: style,)
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
                                        sections: _chartSections(industrySectors4),
                                        centerSpaceRadius: 25.0,
                                      ))),

                              Center(
                                  child: Text("कूल",style: style,)
                              ),

                              Center(
                                  child: Text("200",style: style,)
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
                                sections: _mainChartSections(industrySectors2),
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
                                    text: "  कूल : 600",style: style,
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
                                    text: "  सामान्य  : 200",style: style,
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
                                    text: "  मध्यम  : 200",style: style,
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
                                    text: "  गंभीर   : 200",style: style,
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