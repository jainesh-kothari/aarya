import 'package:arya/ladies/lady_himoglobin_data.dart';
import 'package:arya/model/buble_data.dart';
import 'package:arya/model/lady_health_model.dart';
import 'package:arya/model/lady_intervention_model.dart';
import 'package:arya/model/lady_nutritional_model.dart';
import 'package:arya/util/appcontants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../language/app_translations.dart';
import '../libary/api_service.dart';
import '../libary/util.dart';

class LadyNutritionProcess extends StatefulWidget {

  String userId;
  LadyNutritionProcess(this.userId);

  @override
  _LadyNutritionProcessState createState() => _LadyNutritionProcessState(this.userId);
}

class _LadyNutritionProcessState extends State<LadyNutritionProcess> {

  String userId;
  _LadyNutritionProcessState(this.userId);


  int selected = -1;

  TextEditingController hemoglobin_controller = TextEditingController(text:'');
  TextEditingController date_controller = TextEditingController(text:'');
  final format = DateFormat("yyyy-MM-dd");

  late List<bool> _isChecked_health=[];
  bool _isCheckedTHR = false;

  String radioButtonItem = 'ONE';
  int id = 1;
  AppConstants api = AppConstants();

  List<String> _health_texts = [];

  late List<BubbleData> _suppliment_texts = [];

  List<WomenMedicineReference> _supplement_list =[];
  List<WomenFoodReference> _intervention_list =[];

  List<String> _supplement_ids = [];
  bool visible = false;
  getSupplementData() async {
    _supplement_list = (await ApiService().getNutritionalSupplement(userId))!;

    setState(() {
      for (var i = 0; i < _supplement_list!.length; i++) {
        BubbleData bubbleData = BubbleData(id : "${_supplement_list![i].id.toString().trim()}", name: "${_supplement_list![i].name.toString()}", flag: false);
        _suppliment_texts.add(bubbleData);
      }
    });

    _intervention_list = (await ApiService().getNutritionalIntervention(userId))!;
      print(_intervention_list!.length);
    setState(() {
      for (var i = 0; i < _intervention_list!.length; i++) {
        _health_texts.add("${_intervention_list![i].name.toString()}");
      }
      _isChecked_health = List<bool>.filled(_health_texts.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    getSupplementData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title:
        Text(AppTranslations.of(context)!.text("vikas_and_poshan_sambadhi")),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),

      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black54)),
                    child: ExpansionTile(
                      initiallyExpanded: index == selected,
                      key: Key(selected.toString()),
                      onExpansionChanged: (newState) {
                        setState(() {
                          selected = index;
                        });
                      },
                      title: Text(
                          index == 0
                              ? AppTranslations.of(context)!.text("swastha_khoj")
                              : index == 1
                              ? AppTranslations.of(context)
                          !.text("nutrition_anu")
                              : AppTranslations.of(context)
                          !.text("nutrition_has"),
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500)),
                      children: <Widget>[
                        index == 0
                            ? Padding(
                          padding: const EdgeInsets.all(5.0),
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
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 8.0),
                                  child: Text(
                                      AppTranslations.of(context)
                                      !.text("himoglobin"),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 8.0, right: 8.0),
                                  child: TextField(
                                    controller: hemoglobin_controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:  Color(AppConstants.GRAY_COLOR[1]))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:  Color(AppConstants.GRAY_COLOR[1]))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, bottom: 8.0),
                                  child: Text(
                                      AppTranslations.of(context)
                                      !.text("himoglobin_qty"),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ),

                                Row(

                                  children: [

                                    Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadyHemoglobinDetails(userId)));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10.0, right:10,top: 20,bottom: 20),
                                            child: Container(
                                              height: 40,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  gradient: api.gradient(),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: const Border(
                                                    bottom: BorderSide(color: Colors.black),
                                                    top: BorderSide(color: Colors.black),
                                                    left: BorderSide(color: Colors.black),
                                                    right: BorderSide(color: Colors.black),
                                                  )),
                                              child: Center(
                                                child: Text("  Pervious Data  ",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),

                                    Expanded(
                                      flex: 5,
                                      child: InkWell(
                                        onTap: () async {

                                          double hemoglobin = double.parse(hemoglobin_controller.text);

                                          if(hemoglobin > 5 && hemoglobin<30) {

                                          } else {
                                            Fluttertoast.showToast(msg: "hemoglobin should be between 5 to 30");
                                            return;
                                          }

                                          setState(() {
                                            visible = true;
                                          });

                                          LadyHealthModelData? _response = await ApiService()
                                              .addLadyHealthDetails(userId!, hemoglobin_controller.text,date_controller.text);

                                          setState(() {
                                            visible = false;
                                          });

                                          if(_response!=null) {
                                            Alert(
                                              context: context,
                                              style: util().alertStyle,
                                              type: AlertType.success,
                                              title: "",
                                              desc: "Women Health Data added Successfully",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Okay",
                                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                                  radius: BorderRadius.circular(0.0),
                                                ),
                                              ],
                                            ).show();
                                          } else {
                                            Fluttertoast.showToast(msg: "Something went wrong");
                                          }


                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 10.0, right: 10,top: 20,bottom: 20),
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: api.gradient(),
                                                borderRadius: BorderRadius.circular(10),
                                                border: const Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                )),
                                            child: Center(
                                              child: Text(
                                                AppTranslations.of(context)!.text("save"),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                  ],
                                )



                              ],
                            ),
                          ),
                        )
                            : index == 1
                            ? Column(
                          children: [
                            ListTile(
                              title: Text(
                                AppTranslations.of(context)
                                !.text("nutrition_question"),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            ListView.builder(
                                itemCount: _suppliment_texts.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(_suppliment_texts[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    value: _suppliment_texts[index].flag,
                                    onChanged: (val) {
                                      setState(
                                            () {
                                          _suppliment_texts[index].flag = val!;
                                        },
                                      );
                                    },
                                  );
                                }),
                            InkWell(
                              onTap: () async {

                                setState(() {

                                  _supplement_ids =[];

                                  for (var i = 0; i < _suppliment_texts!.length; i++) {
                                    if (_suppliment_texts[i].flag == true) {

                                      String value = '"${_suppliment_texts[i].id.toString()}"';

                                      _supplement_ids.add(value);
                                    }
                                  }
                                });



                                String? response = await ApiService().addSupplementsDetails(userId.toString(), _supplement_ids.toString());

                                if(response == "201"){
                                  Alert(
                                    context: context,
                                    style: util().alertStyle,
                                    type: AlertType.success,
                                    title: "",
                                    desc: "Data added Successfully",
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Color.fromRGBO(0, 179, 134, 1.0),
                                        radius: BorderRadius.circular(0.0),
                                        child: const Text(
                                          "Okay",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ).show();
                                } else {
                                  Fluttertoast.showToast(msg: "Something went wrong");
                                }


                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 40.0, right: 40,top: 20,bottom: 20),
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: api.gradient(),
                                      borderRadius: BorderRadius.circular(10),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                      )),
                                  child: Center(
                                    child: Text(
                                      AppTranslations.of(context)!.text("save"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: Text(
                                  AppTranslations.of(context)
                                  !.text("take_home_rashan"),
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              value: _isCheckedTHR,
                              onChanged: (val) {
                                setState(
                                      () {
                                    _isCheckedTHR = val!;
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0),
                              child: Divider(color: Colors.grey[350]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 8.0),
                              child: Text(
                                  AppTranslations.of(context)
                                  !.text("no_of_days_thr"),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 8.0, right: 8.0),
                              child: TextField(
                                // controller: name_controller,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  Color(AppConstants.GRAY_COLOR[4]))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  Color(AppConstants.GRAY_COLOR[4]))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 8.0),
                              child: Text(
                                  AppTranslations.of(context)
                                  !.text("health_type"),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            ListView.builder(
                                itemCount: _health_texts.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(_health_texts[index],
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    value: _isChecked_health[index],
                                    onChanged: (val) {
                                      setState(
                                            () {
                                          _isChecked_health[index] = val!;
                                        },
                                      );
                                    },
                                  );
                                }),
                            InkWell(
                              onTap: () {
                                //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 40.0, right: 40,top: 20,bottom: 20),
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: api.gradient(),
                                      borderRadius: BorderRadius.circular(10),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                      )),
                                  child: Center(
                                    child: Text(
                                      AppTranslations.of(context)!.text("save"),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),


          visible ? Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ) : Container()


        ],
      ),
    );
  }
}