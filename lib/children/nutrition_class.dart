import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';

import '../language/app_translations.dart';

class NutritionProcess extends StatefulWidget {
  @override
  _NutritionProcessState createState() => _NutritionProcessState();
}

class _NutritionProcessState extends State<NutritionProcess> {

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
    _isChecked_health = List<bool>.filled(_health_texts.length, false);
  }

  int selected = -1;

 final List<String> _texts = [
    "फोलिक एसिड",
    "आयरन",
    "विटामिन",
    "कैल्शियम "
  ];

  final List<String> _health_texts = [
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

                        ListView.builder(
                            itemCount: _texts.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(_texts[index], style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500,color: Colors.black)),
                                value: _isChecked[index],
                                onChanged: (val) {
                                  setState(
                                        () {
                                      _isChecked[index] = val!;
                                    },
                                  );
                                },
                              );

                            }
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

                      ListView.builder(
                            itemCount: _health_texts.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(_health_texts[index], style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500,color: Colors.black)),
                                value: _isChecked_health[index],
                                onChanged: (val) {
                                  setState(
                                        () {
                                          _isChecked_health[index] = val!;
                                    },
                                  );
                                },
                              );

                            }
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