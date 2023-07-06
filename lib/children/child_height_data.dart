
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/child_height_weight_data_gs.dart';
import 'package:arya/util/appcontants.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ChildrenHeightData extends StatefulWidget {

  String? userId;
  ChildrenHeightData(this.userId);

  @override
  _ChildrenChildrenHeightDataState createState() => _ChildrenChildrenHeightDataState(this.userId);
}

class _ChildrenChildrenHeightDataState extends State<ChildrenHeightData> {


  String? userId;
  _ChildrenChildrenHeightDataState(this.userId);


  AppConstants api = AppConstants();

  late Future<List<ChildHeightWeightData>?> _height_list;
  List<ChildHeightWeightData>? list = [];

  List<double> feature_data =[];
  List<String> date_list =[];

  List<Feature> features = [];


  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    _height_list = ApiService().getChildHeightData(userId.toString());
     list = await _height_list;

    list!.sort((b, a) {
      DateTime dateTimeA = DateTime.parse(a.date.toString());
      DateTime dateTimeB = DateTime.parse(b.date.toString());
      return dateTimeA.compareTo(dateTimeB);
    });

    for (int i = 0; i < list!.length; i++) {
      if (i <= 4) {
        int? height = list![i].height;
        double hei = (height! / 100);
        feature_data.add(hei);

        DateTime date = DateTime.parse(list![i].date.toString());
        String formattedDate = DateFormat('d MMMM').format(date);
        date_list.add(formattedDate);
      }
    }

    Feature feature = Feature(
      title: "last ${feature_data.length} Height Graph",
      color: Colors.blue,
      data: feature_data,
    );

    features.add(feature);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
        title: Text(AppTranslations.of(context)!.text ("app_name")),
        centerTitle: true,
      ),

      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<ChildHeightWeightData>?>(
                      future: _height_list,
                      builder: (context, snapshot) {
                        print(snapshot.hasData);
                        print(list!.length);

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: CircularProgressIndicator(),
                          ));
                        }

                        if (list!.length == 0) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No Data Found",style: TextStyle(fontSize: 18),),
                          ));
                        }


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                DataTable(
                                  columns: [
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Height')),
                                    DataColumn(label: Text('Result')),
                                  ],
                                  rows: List.generate(
                                    list!.length,
                                        (index) =>
                                        DataRow(
                                          cells: [
                                            DataCell(
                                                Text(DateFormat('d MMMM yyyy').format(DateTime.parse(list![index].date.toString())))),
                                            DataCell(
                                                Text(list![index].height.toString())),
                                            DataCell(
                                                Text(list![index].result.toString())),
                                          ],
                                        ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: date_list!.length >= 2 ?
                                    LineGraph(
                                      features: features,
                                      size: Size(420, 300),
                                      labelX: date_list,
                                      labelY: ['20', '40', '60', '80', '100'],
                                      showDescription: true,
                                      graphColor: Colors.black,
                                      graphOpacity: 0.2,
                                      verticalFeatureDirection: false,
                                      descriptionHeight: 130,
                                    )
                                        : Container(
                                      child: (Text("Mininum 2 date range for showing graph")),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }
                  ),


                ],
              ),
          )
    ));
  }

}
