import 'package:arya/model/buble_data.dart';
import 'package:arya/model/child_nutritional_intervention.dart';
import 'package:arya/model/child_nutritional_suppliments.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../language/app_translations.dart';
import '../libary/api_service.dart';
import '../libary/util.dart';

class NutritionProcess extends StatefulWidget {

  String? user_id;
  NutritionProcess(this.user_id);

  @override
  _NutritionProcessState createState() => _NutritionProcessState(this.user_id);
}

class _NutritionProcessState extends State<NutritionProcess> {

  String? user_id;
  _NutritionProcessState(this.user_id);

  List<MedicineReference> _supplement_list =[];
  late List<BubbleData> _suppliment_texts = [];
  List<String> _supplement_ids = [];

  late Future<List<FoodReference>?> _intervention_list;
  late List<bool> _intervention_checked;

  bool _isCheckedTHR = false;
  bool _isCheckedFood = false;

  String radioButtonItem = 'ONE';
  int id = 1;
  AppConstants api = new AppConstants();


  getSupplementData() async {

    _intervention_list = ApiService().getChildNutritionalInterventionList(user_id.toString());

    _intervention_list.then((value) => {
      _intervention_checked = List<bool>.filled(value!.length, false)
    });



    _supplement_list = (await ApiService().getChildNutritionalSupplements(user_id.toString()))!;

    setState(() {
      for (var i = 0; i < _supplement_list!.length; i++) {
        BubbleData bubbleData = BubbleData(id : "${_supplement_list![i].id.toString().trim()}", name: "${_supplement_list![i].name.toString()}", flag: false);
        _suppliment_texts.add(bubbleData);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSupplementData();
  }

  int selected = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTranslations.of(context)!.text("vikas_and_poshan_sambadhi")),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color:Colors.black54)
                ),
                child: ExpansionTile(
                  initiallyExpanded: index == selected,
                  key: Key(selected.toString()),
                  onExpansionChanged: (newState) {
                    setState(() {
                      selected = index;
                    });
                  },
                  title: Text(index == 0 ? AppTranslations.of(context)!.text("nutrition_anu")
                            : AppTranslations.of(context)!.text("nutrition_has"),
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  children: <Widget>[

                    index == 0 ? Column(
                      children: [
                        ListTile(
                          title: Text(AppTranslations.of(context)!.text("nutrition_question"),
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,color: Colors.black),
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:   ListView.builder(
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
                        ),

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



                            String? response = await ApiService().addChildSupplementsDetails(user_id.toString(), _supplement_ids.toString());

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
                    ) :

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text("Is the child on solid foods ?",
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,color: Colors.black),
                          ),
                        ),

                        Padding(
                          padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'ONE';
                                    id = 1;
                                  });
                                },
                              ),
                              Text("YES", style: TextStyle(
                                  fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                              )),

                              Radio(
                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'TWO';
                                    id = 2;
                                  });
                                },
                              ),
                              Text("NO", style: TextStyle(
                                  fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                              )),
                            ],
                          ),
                        ),

                        Padding(
                          padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Divider(color: Colors.grey[350]),
                        ),

                        CheckboxListTile(
                          title: Text(AppTranslations.of(context)!.text("take_home_rashan"), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500,color: Colors.black)),
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
                        padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: Divider(color: Colors.grey[350]),
                      ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("no_of_days_thr"), style: TextStyle(
                              fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                          )),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0,right: 8.0),
                          child: TextField(
                            // controller: name_controller,
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

                        CheckboxListTile(
                          title: Text(AppTranslations.of(context)!.text("extra_food"), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500,color: Colors.black)),
                          value: _isCheckedFood,
                          onChanged: (val) {
                            setState(
                                  () {
                                _isCheckedFood = val!;
                              },
                            );
                          },
                        ),

                        Padding(
                          padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Divider(color: Colors.grey[350]),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("no_of_days_thr"), style: TextStyle(
                              fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                          )),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0,right: 8.0),
                          child: TextField(
                            // controller: name_controller,
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
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("himoglobin"), style: TextStyle(
                              fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                          )),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0,right: 8.0),
                          child: TextField(
                            // controller: name_controller,
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
                          child: Text(AppTranslations.of(context)!.text("himoglobin_qty"), style: TextStyle(
                              fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold
                          )),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("health_type"), style: TextStyle(
                              fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                          )),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder<List<FoodReference>?>(
                              future: _intervention_list,
                              builder: (context, snapshot) {

                                print(snapshot.hasData);


                                if(!snapshot.hasData) {
                                  return const Center(child: Text("No Medicine Found"));
                                }

                                return ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context,index) {
                                      var todo = snapshot.data?[index];
                                      return CheckboxListTile(

                                        title: Text(todo!.name.toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black)),
                                        value: _intervention_checked[index],
                                        onChanged: (val) {
                                          setState(
                                                () {
                                                  _intervention_checked[index] = val!;
                                            },
                                          );
                                        },
                                      );;
                                    },
                                    separatorBuilder: (context,index) {
                                      return Container();
                                    },
                                    itemCount: snapshot.data?.length ?? 0);
                              },
                            )
                        ),

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
    );
  }


}