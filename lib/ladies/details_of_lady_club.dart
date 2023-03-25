
import 'package:arya/children/add_new_children.dart';
import 'package:arya/children/growth_monitaring.dart';
import 'package:arya/children/nutrition_class.dart';
import 'package:arya/children/tika_vavaran.dart';
import 'package:arya/ladies/add_new_lady.dart';
import 'package:arya/ladies/lady_nutrition_process.dart';
import 'package:arya/ladies/self_help_group.dart';
import 'package:arya/ladies/suckle_lady.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/get_child_gs.dart';

class LadiesGroupDetails extends StatefulWidget {
  @override
  _LadiesGroupDetailsState createState() => _LadiesGroupDetailsState();
}

class _LadiesGroupDetailsState extends State<LadiesGroupDetails> {

  AppConstants api = AppConstants();
  final format = DateFormat("dd-MM-yyyy");
  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);

  List<String> _cardList = [];
  List<String> minority = [];

  @override
  void initState() {
    super.initState();
    _cardList.add("ABC");
    _cardList.add("XYZ");
    _cardList.add("PQR");
    _cardList.add("DFG");
    _cardList.add("VBN");

    minority.add("");
    minority.add("");
    minority.add("");
    minority.add("");
    minority.add("");
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

              Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 8.0,top: 8.0),
                    child: Text("Details of the monthly meeting of the women's club", style: style)),
              ),




              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 30.0),
                child: Text("Date of meeting", style: style),
              ),

              Padding(
                padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
                child: DateTimeField(
                  format: format,
                  // controller: txt_date,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
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
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    return picked;
                  },
                ),
              ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                    child: Text("Topic of Meeting", style: style),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      focusColor:Colors.white,
                      // value: _chosenValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor:Colors.black,
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style:TextStyle(color:Colors.black),),
                        );
                      }).toList(),
                      hint:Text("Select the topic",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          // _chosenValue = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,top: 30.0),
                    child: Text("Details of Member", style: style),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        Expanded(
                          flex:3,
                          child: Text("Name", style: style),
                        ),

                        Expanded(
                          flex:3,
                          child: Text("Designation", style: style),
                        ),

                        Expanded(
                          flex:3,
                          child: Text("Attendance", style: style),
                        ),



                        Expanded(
                          flex:3,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _cardList.length,
                      itemBuilder: (context, index) {
                        return  Row(
                          children: [

                            Expanded(
                              flex:3,
                              child: Text(_cardList[index], style: style),
                            ),

                            Expanded(
                              flex:3,
                              child: Text("Member", style: style),
                            ),

                            Expanded(
                              flex:3,
                              child: RadioListTile(
                                title: Text("Present", style: style),
                                value: "Present",
                                groupValue: minority[index],
                                onChanged: (value){
                                  setState(() {
                                    minority[index] = value.toString();
                                  });
                                },
                              ),
                            ),

                            Expanded(
                              flex:3,
                              child: RadioListTile(
                                title: Text("Absent",style: style),
                                value: "Absent",
                                groupValue: minority,
                                onChanged: (value){
                                  setState(() {
                                    minority[index] = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),




                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 40.0, right: 40),
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


            ]),
          )),


    );
  }

}
