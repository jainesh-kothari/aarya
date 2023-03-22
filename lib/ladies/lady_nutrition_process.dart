import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import '../language/app_translations.dart';

class LadyNutritionProcess extends StatefulWidget {
  @override
  _LadyNutritionProcessState createState() => _LadyNutritionProcessState();
}

class _LadyNutritionProcessState extends State<LadyNutritionProcess> {
  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
    _isChecked_health = List<bool>.filled(_health_texts.length, false);
  }

  int selected = -1;

  List<String> _texts = ["फोलिक एसिड", "आयरन", "विटामिन", "कैल्शियम "];

  List<String> _health_texts = [
    "एलोपैथ",
    "होम्योपैथी",
    "आयुष",
  ];

 late List<bool> _isChecked;
 late List<bool> _isChecked_health;
  bool _isCheckedTHR = false;
  bool _isCheckedFood = false;

  String radioButtonItem = 'ONE';
  int id = 1;
  AppConstants api = new AppConstants();
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

      body: Padding(
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
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 3.0),
                              child: Text(
                                  AppTranslations.of(context)
                                      !.text("height"),
                                  style: const TextStyle(
                                      fontSize: 13,
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
                                          color:  Color(AppConstants.GRAY_COLOR[0]))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  Color(AppConstants.GRAY_COLOR[0]))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 8.0),
                              child: Text(
                                  AppTranslations.of(context)
                                      !.text("height_should_be_lady"),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 8.0),
                              child: Text(
                                  AppTranslations.of(context)
                                      !.text("weight"),
                                  style: const TextStyle(
                                      fontSize: 13,
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
                                          color:  Color(AppConstants.GRAY_COLOR[0]))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:  Color(AppConstants.GRAY_COLOR[0]))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 8.0),
                              child: Text(
                                  AppTranslations.of(context)
                                      !.text("weight_should_be_lady"),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
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
                                // controller: name_controller,
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
                            itemCount: _texts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(_texts[index],
                                    style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                                value: _isChecked[index],
                                onChanged: (val) {
                                  setState(
                                        () {
                                      _isChecked[index] = val!;
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
    );
  }
}