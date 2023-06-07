import 'package:arya/model/buble_data.dart';
import 'package:arya/model/child_vaccination_gs.dart';
import 'package:arya/model/vaccination.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../language/app_translations.dart';
import '../libary/api_service.dart';
import '../libary/util.dart';

class LadyVaccination extends StatefulWidget {

  String userId;
  LadyVaccination(this.userId);

  @override
  _LadyVaccinationState createState() => _LadyVaccinationState(this.userId);
}

class _LadyVaccinationState extends State<LadyVaccination> {

  String userId;
  _LadyVaccinationState(this.userId);

  List<WomenVaccinationReference>? _vaccination_list;

  AppConstants api = AppConstants();
  late int size =0;

  List<BubbleData> _vaccination_texts = [];
  bool visible =false;

  getSupplementData() async {
    _vaccination_list = (await ApiService().getWomenVaccinationList(userId))!;

    setState(() {
      for (var i = 0; i < _vaccination_list!.length; i++) {
        BubbleData bubbleData = BubbleData(id : "${_vaccination_list![i].id.toString().trim()}",
            name: "${_vaccination_list![i].name.toString()}", flag: false);
         _vaccination_texts.add(bubbleData);
      }

      if(_vaccination_texts.length == 0){
        visible = true;
      }
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTranslations.of(context)!.text("tika_vivaran")),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),

      body:SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Vaccination Details",
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            ListView.builder(
                itemCount: _vaccination_texts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_vaccination_texts[index].name.toString(),
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    value: _vaccination_texts[index].flag,
                    onChanged: (val) {
                      setState(
                            () {
                              _vaccination_texts[index].flag = val!;
                        },
                      );
                    },
                  );
                }),

            Center(child: Text( visible == true ? "No Vaccination Found" : "",style: TextStyle(fontSize: 18))),

            InkWell(
              onTap: () async {
                List<String> _vaccination_ids = [];
                setState(() {
                 for (var i = 0; i < _vaccination_texts!.length; i++) {
                    if (_vaccination_texts[i].flag == true) {
                       _vaccination_ids.add('"${_vaccination_texts[i].id.toString()}"');
                    }
                  }
                });

                String? response = await ApiService().addVaccinationDetails(userId.toString(), _vaccination_ids.toString());

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
        ),
      ),
    );
  }
}

