import 'package:arya/model/child_height_weight_data_gs.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../language/app_translations.dart';
import '../libary/api_service.dart';
import '../util/appcontants.dart';

class ChildrenHeightAndWeightView extends StatefulWidget {
  String? userId;

  ChildrenHeightAndWeightView(this.userId);

  @override
  _ChildrenPageViewState createState() => _ChildrenPageViewState(this.userId);
}

class _ChildrenPageViewState extends State<ChildrenHeightAndWeightView> {
  String? userId;

  _ChildrenPageViewState(this.userId);

  AppConstants api = AppConstants();

  late Future<List<ChildHeightWeightData>?> _weight_list;
  List<ChildHeightWeightData>? wlist = [];

  List<double> wfeature_data = [];
  List<String> wdate_list = [];

  List<Feature> wfeatures = [];

  late Future<List<ChildHeightWeightData>?> _height_list;
  List<ChildHeightWeightData>? hlist = [];

  List<double> hfeature_data = [];
  List<String> hdate_list = [];

  List<Feature> hfeatures = [];

  @override
  void initState() {
    super.initState();
    _getHeightData();
    _getWeighData();
  }

  _getHeightData() async {
    _height_list = ApiService().getChildHeightData(userId.toString());
    hlist = await _height_list;

    hlist!.sort((b, a) {
      DateTime dateTimeA = DateTime.parse(a.date.toString());
      DateTime dateTimeB = DateTime.parse(b.date.toString());
      return dateTimeA.compareTo(dateTimeB);
    });

    for (int i = 0; i < hlist!.length; i++) {
      if (i <= 4) {
        int? height = hlist![i].height;
        double hei = (height! / 100);
        hfeature_data.add(hei);

        DateTime date = DateTime.parse(hlist![i].date.toString());
        String formattedDate = DateFormat('d MMMM').format(date);
        hdate_list.add(formattedDate);
      }
    }

    Feature feature = Feature(
      title: "last ${hfeature_data.length} Height Graph",
      color: Colors.blue,
      data: hfeature_data,
    );

    Feature feature2 = Feature(
      title: "Normal",
      color: Colors.green,
      data: [0.2, 0.4, 0.6, 0.8, 1.0],
    );

    Feature feature3 = Feature(
      title: "High",
      color: Colors.red,
      data: [0.0, 0.2, 0.4, 0.6, 0.8],
    );

    Feature feature4 = Feature(
      title: "Medium",
      color: Colors.orange,
      data: [0.1, 0.3, 0.5, 0.7, 0.8],
    );

    hfeatures.add(feature);
    hfeatures.add(feature2);
    hfeatures.add(feature3);
    hfeatures.add(feature4);
  }

  _getWeighData() async {
    _weight_list = ApiService().getChildWeightData(userId.toString());
    wlist = await _weight_list;

    wlist!.sort((b, a) {
      DateTime dateTimeA = DateTime.parse(a.date.toString());
      DateTime dateTimeB = DateTime.parse(b.date.toString());
      return dateTimeA.compareTo(dateTimeB);
    });

    for (int i = 0; i < wlist!.length; i++) {
      if (i <= 4) {
        dynamic? weight = wlist![i].weight;
        double hei = (weight! / 20);
        wfeature_data.add(hei);

        DateTime date = DateTime.parse(wlist![i].date.toString());
        String formattedDate = DateFormat('d MMMM').format(date);
        wdate_list.add(formattedDate);
      }
    }

    Feature feature = Feature(
      title: "last ${wfeature_data.length} Weight Graph",
      color: Colors.blue,
      data: wfeature_data,
    );

    Feature feature2 = Feature(
      title: "Normal",
      color: Colors.green,
      data: [0.1, 0.4, 0.6, 0.8, 1.0],
    );

    Feature feature3 = Feature(
      title: "High",
      color: Colors.red,
      data: [0.1, 0.2, 0.3, 0.4, 0.5],
    );

    Feature feature4 = Feature(
      title: "Medium",
      color: Colors.orange,
      data: [0.1, 0.3, 0.5, 0.7, 0.8],
    );

    wfeatures.add(feature2);
    wfeatures.add(feature3);
    wfeatures.add(feature4);
    wfeatures.add(feature);
  }

  int selectedValue = 0;
  Map<int, Widget> children = <int, Widget>{
    0: const Text("Height"),
    1: const Text("Weight "),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
        title: Text(AppTranslations.of(context)!.text("app_name")),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: double.infinity,
                child: CupertinoSegmentedControl<int>(
                  children: children,
                  onValueChanged: (value) {
                    selectedValue = value;
                    setState(() {});
                  },
                  selectedColor: CupertinoColors.systemBlue,
                  unselectedColor: CupertinoColors.white,
                  borderColor: CupertinoColors.inactiveGray,
                  pressedColor: CupertinoColors.inactiveGray,
                  groupValue: selectedValue,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: selectedValue == 0
                  ? FutureBuilder<List<ChildHeightWeightData>?>(
                      future: _height_list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: CircularProgressIndicator(),
                          ));
                        }

                        if (hlist!.length == 0) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "No Data Found",
                              style: TextStyle(fontSize: 18),
                            ),
                          ));
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                DataTable(
                                  columns: [
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Height')),
                                    DataColumn(label: Text('Result')),
                                  ],
                                  rows: List.generate(
                                    hlist!.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Text(DateFormat('d MMMM yyyy')
                                            .format(DateTime.parse(hlist![index]
                                                .date
                                                .toString())))),
                                        DataCell(Text(
                                            hlist![index].height.toString())),
                                        DataCell(Text(
                                            hlist![index].result.toString())),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: hdate_list!.length >= 2
                                        ? LineGraph(
                                            features: hfeatures,
                                            size: Size(420, 500),
                                            labelX: hdate_list,
                                            labelY: [
                                              '20',
                                              '40',
                                              '60',
                                              '80',
                                              '100'
                                            ],
                                            showDescription: true,
                                            graphColor: Colors.black,
                                            graphOpacity: 0.2,
                                            verticalFeatureDirection: true,
                                            descriptionHeight: 230,
                                          )
                                        : Container(
                                            child: (Text(
                                                "Mininum 2 date range for showing graph")),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : FutureBuilder<List<ChildHeightWeightData>?>(
                      future: _weight_list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: CircularProgressIndicator(),
                          ));
                        }

                        if (!snapshot.hasData) {
                          return const Center(child: Text("No Data Found"));
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                DataTable(
                                  columns: [
                                    DataColumn(label: Text('Date')),
                                    DataColumn(label: Text('Weight')),
                                    DataColumn(label: Text('Result')),
                                  ],
                                  rows: List.generate(
                                    wlist!.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Text(DateFormat('d MMMM yyyy')
                                            .format(DateTime.parse(wlist![index]
                                                .date
                                                .toString())))),
                                        DataCell(Text(
                                            wlist![index].weight.toString())),
                                        DataCell(Text(
                                            wlist![index].result.toString())),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: wdate_list!.length >= 2
                                        ? LineGraph(
                                            features: wfeatures,
                                            size: Size(420, 400),
                                            labelX: wdate_list,
                                            labelY: [
                                              '4',
                                              '8',
                                              '12',
                                              '16',
                                              '20'
                                            ],
                                            showDescription: true,
                                            graphColor: Colors.black,
                                            graphOpacity: 0.2,
                                            verticalFeatureDirection: true,
                                            descriptionHeight: 230,
                                          )
                                        : Container(
                                            child: (Text(
                                                "Mininum 2 date range for showing graph")),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
