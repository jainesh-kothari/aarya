import 'package:arya/model/child_vaccination_gs.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../language/app_translations.dart';
import '../libary/api_service.dart';
import '../libary/util.dart';
import '../model/buble_data.dart';

class TikaVivaran extends StatefulWidget {

  String user_id;
  TikaVivaran(this.user_id);

  @override
  _TikaVivaranState createState() => _TikaVivaranState(this.user_id);
}

class _TikaVivaranState extends State<TikaVivaran> {

  String? user_id;
  _TikaVivaranState(this.user_id);

  late List<VaccinationReference>? _vaccination_list;
  late List<BubbleData> _suppliment_texts = [];
  List<String> _supplement_ids = [];
  AppConstants api = AppConstants();
  late int size =0;
  bool visible = false;

  getVaccinationData() async {

    _vaccination_list = (await ApiService().getVaccinationList(user_id.toString()))!;

    setState(() {
      for (var i = 0; i < _vaccination_list!.length; i++) {
        BubbleData bubbleData = BubbleData(id : "${_vaccination_list![i].id.toString().trim()}", name: "${_vaccination_list![i].name.toString()}", flag: false);
        _suppliment_texts.add(bubbleData);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getVaccinationData();
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

      body: Stack(
        children: [

          ListView(
            children: [

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
                  setState(() {
                    visible = true;
                  });
                  String? response = await ApiService().addChildVaccinationDetails(user_id.toString(), _supplement_ids.toString());
                  setState(() {
                    visible = false;
                  });
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

