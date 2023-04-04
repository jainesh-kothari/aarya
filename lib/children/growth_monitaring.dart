import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../language/app_translations.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

class GrowthMonitoring extends StatefulWidget {

  String? userId;
  GrowthMonitoring(this.userId);


  @override
  _GrowthMonitoringState createState() => _GrowthMonitoringState(this.userId);
}

class _GrowthMonitoringState extends State<GrowthMonitoring> {

  String? userId;
  _GrowthMonitoringState(this.userId);

  var now = new DateTime.now();
  final format = DateFormat("MM-dd-yyyy");
  TextEditingController date_controller = TextEditingController(text:'');
  TextEditingController height_controller = TextEditingController(text:'');
  TextEditingController weight_controller = TextEditingController(text:'');

  String prv_height = "";
  String prv_weight ="";
  String prv_date = "";

  final List<Feature> features = [
    Feature(
      title: "A",
      color: Colors.blue,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
    Feature(
      title: "B",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      title: "C",
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      title: "D",
      color: Colors.green,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),

  ];
  AppConstants api = AppConstants();
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(AppTranslations.of(context)!.text("growth_monitaring")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),

      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListView(
                primary: false,
                shrinkWrap: true,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                    child: Text(AppTranslations.of(context)!.text("pervious_reading") + " : "+ prv_date, style: const TextStyle(
                        fontSize: 13, color: Colors.grey,fontWeight: FontWeight.bold
                    )),
                  ),

                  Padding(
                    padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Divider(color: Colors.grey[350]),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 2.0,right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppTranslations.of(context)!.text("height"), style: TextStyle(
                              fontSize: 11, color: Colors.grey
                          )),

                          Text(prv_height.isEmpty ? "Not Available" : prv_height, style: TextStyle(
                              fontSize: 11, color: Colors.grey
                          )),
                        ],
                      )
                  ),

                  Padding(
                    padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Divider(color: Colors.grey[350]),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 2.0,right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppTranslations.of(context)!.text("weight"), style: TextStyle(
                              fontSize: 11, color: Colors.grey
                          )),

                          Text(prv_weight.isEmpty ? "Not Available" : prv_weight, style: TextStyle(
                              fontSize: 11, color: Colors.grey
                          )),
                        ],
                      )
                  ),


                  Padding(
                    padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Divider(color: Colors.grey[350]),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: Colors.white70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                            child: Text("Date", style: TextStyle(
                                fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                            )),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
                            child: DateTimeField(
                              format: format,
                              controller: date_controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                ),
                              ),
                              onShowPicker: (context, currentValue) async {
                                DateTime? picked = await showDatePicker(
                                    context: context,
                                    builder: (BuildContext? context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Color(AppConstants.BLUE_COLOR[0]),
                                            onPrimary: Colors.white,
                                            surface: Color(AppConstants.BLUE_COLOR[0]),
                                            onSurface: Colors.black,
                                          ),
                                          dialogBackgroundColor:Colors.white,
                                        ),
                                        child: child!,
                                      );
                                    },
                                    firstDate: DateTime(2000),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime.now());
                                return picked;
                              },
                            ),
                          ),

                          Padding(
                            padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: Divider(color: Colors.grey[350]),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                            child: Text(AppTranslations.of(context)!.text("height"), style: TextStyle(
                                fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
                            )),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 8.0,right: 8.0),
                            child: TextField(
                               controller: height_controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[0]))
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[0]))
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 8.0),
                            child: Text(AppTranslations.of(context)!.text("height_should_be"), style: TextStyle(
                                fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold
                            )),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                            child: Text(AppTranslations.of(context)!.text("weight"), style: TextStyle(
                                fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold
                            )),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 8.0,right: 8.0),
                            child: TextField(
                               controller: weight_controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[0]))
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[0]))
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 8.0),
                            child: Text(AppTranslations.of(context)!.text("weight_should_be"), style: TextStyle(
                                fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold
                            )),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 40,
                              onPressed: () async{

                                if (date_controller.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Please enter the date");
                                } else if (height_controller.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Please enter the Height");
                                } else if (weight_controller.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Please enter the weight");
                                } else {

                                  double height = double.parse(height_controller.text);
                                  double weight = double.parse(weight_controller.text);

                                  if(height > 45.72 && height<121.92) {

                                  } else {
                                    Fluttertoast.showToast(msg: "Height should be between 45.72 to 121.92 cm");
                                    return;
                                  }

                                  if(weight > 0.2 && weight<20) {

                                  } else {
                                    Fluttertoast.showToast(msg: "Weight should be between 0.5 to 20 kg");
                                    return;
                                  }

                                  String? response = await ApiService().addGrowthMonitoring(userId.toString(), height, weight , date_controller.text);

                                  if(response == "201"){
                                    Fluttertoast.showToast(msg: "Your data save Successfully");
                                  } else {
                                    Fluttertoast.showToast(msg: "Something went wrong");
                                  }

                                  setState(() {

                                    prv_date = date_controller.text;
                                    prv_height = height_controller.text;
                                    prv_weight = weight_controller.text;

                                    weight_controller.text = "";
                                    date_controller.text = "";
                                    height_controller.text = "";
                                  });

                                }

                                },
                              color: Color(AppConstants.BLUE_COLOR[0]),
                              elevation: 0,
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Text(AppTranslations.of(context)!.text("save"),style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Colors.white)),
                            ),
                          ),




                        ],
                      ),
                    ),
                  ),





                ],


              ),
            ),


           /* Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomSheetOnClick(context);
                            },
                            child: const Text(
                                'Show Height '), // trying to move to the bottom
                          ),
                        ),
                      ),  Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {

                              showBottomSheetOnClick(context);

                            },
                            child: const Text(
                                'Show Weight '), // trying to move to the bottom
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            ),*/



          ],
        ),

    );
  }


  showBottomSheetOnClick(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: 1000,
            child: ListView(

              children: <Widget>[

                SizedBox(height: 10),


                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(AppTranslations.of(context)!.text("height"), style: const TextStyle(
                        fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold
                    )),
                  ),

                ),
                SizedBox(height: 10),

                Divider(height: 1),

                SizedBox(height: 40),


                Center(
                  child: DataTable(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.black, width: 0.7),
                      verticalInside: BorderSide(color: Colors.black, width: 0.7),
                      borderRadius: BorderRadius.circular(10),
                      bottom: BorderSide(color: Colors.black, width: 0.7),
                      top: BorderSide(color: Colors.black, width: 0.7),
                      left: BorderSide(color: Colors.black, width: 0.7),
                      right: BorderSide(color: Colors.black, width: 0.7),
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Age',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Result',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sarah')),
                          DataCell(Text('19')),
                          DataCell(Text('Student')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Janine')),
                          DataCell(Text('43')),
                          DataCell(Text('Professor')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('William')),
                          DataCell(Text('27')),
                          DataCell(Text('Associate Professor')),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: LineGraph(
                      features: features,
                      size: Size(320, 400),
                      labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
                      labelY: ['20%', '40%', '60%', '80%', '100%'],
                      showDescription: true,
                      graphColor: Colors.black,
                      graphOpacity: 0.2,
                      verticalFeatureDirection: false,
                      descriptionHeight: 130,
                    ),
                  ),
                ),


              ],
            ),
          );
        });
  }
}