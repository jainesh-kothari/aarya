import 'package:arya/language/app_translations.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddNewladies extends StatefulWidget {
  @override
  _AddNewladiesState createState() => new _AddNewladiesState();
}

class _AddNewladiesState extends State<AddNewladies> {

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = new AppConstants();

  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    final format = DateFormat("yyyy-MM-dd");
    String radioButtonItem = 'ONE';
    int id = 1;
    TextEditingController name_controller = new TextEditingController(text:'');
    TextEditingController aadhar_controller = new TextEditingController(text:'');
    TextEditingController number_controller = new TextEditingController(text:'+91');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppConstants.BLUE_COLOR[0]),
        title: Text(AppTranslations.of(context)!.text("new_registration")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("p_lady_name"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text("Lady Image", style: TextStyle(
                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                )),
              ),


              InkWell(
                onTap: () {

                },
                child: Padding(
                  padding:
                  const EdgeInsets.all(20),
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
                        "Upload Image",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("husband_name"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("aadhar_number"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: aadhar_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("svastha_id"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: aadhar_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("dob"), style: style),
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
                child: Text(AppTranslations.of(context)!.text("mobile_number"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: number_controller,
                  decoration: InputDecoration(
                    // prefixText: "+91",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("category"), style: style),
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
                    'General',
                    'OBC',
                    'ST',
                    'SC',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black),),
                    );
                  }).toList(),
                  hint:Text(AppTranslations.of(context)!.text("select_category"),
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


              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("belong_minority"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[

                    Row(
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
                        Text(AppTranslations.of(context)!.text("yes"), style: style),

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
                        Text(AppTranslations.of(context)!.text("no"), style: style),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("first_pregnancy"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'YES';
                              id = 1;
                            });
                          },
                        ),
                        Text(AppTranslations.of(context)!.text("yes"), style: style),

                        Radio(
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'NO';
                              id = 2;
                            });
                          },
                        ),
                        Text(AppTranslations.of(context)!.text("no"), style: style),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("garbhPath_before"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[

                    Row(
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
                        Text(AppTranslations.of(context)!.text("yes"), style: style),

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
                        Text(AppTranslations.of(context)!.text("no"), style:style),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("Labhahti_death"), style: style),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[

                    Row(
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
                        Text(AppTranslations.of(context)!.text("yes"), style: style),

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
                        Text(AppTranslations.of(context)!.text("no"), style:style),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text(AppTranslations.of(context)!.text("last_menstruation_cycle"), style: style),
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
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(2016),
                        lastDate: new DateTime(2019));
                    return picked;
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
            ],
          ),
        ),
      ),
    );
  }



}