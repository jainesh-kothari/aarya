
import 'dart:io';
import 'package:arya/children/child_home_page.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../libary/api_service.dart';
import '../libary/util.dart';
import '../model/caste_category.dart';
import '../model/category_of_cast.dart';
import '../model/login_gs.dart';


class AddNewChildren extends StatefulWidget {
  @override
  _AddNewChildrenState createState() => new _AddNewChildrenState();
}


class _AddNewChildrenState extends State<AddNewChildren> {

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  final format = DateFormat("MM-dd-yyyy");
  TextEditingController name_controller =  TextEditingController(text:'');
  TextEditingController aadhar_controller =  TextEditingController(text:'');
  TextEditingController number_controller =  TextEditingController(text:'');
  TextEditingController mother_controller =  TextEditingController(text:'');
  TextEditingController father_controller =  TextEditingController(text:'');
  TextEditingController mother_aadhar_controller =  TextEditingController(text:'');
  TextEditingController ohter_controller =  TextEditingController(text:'');
  TextEditingController dob_controller = TextEditingController(text:'');

  String? gender;
  String? minority;
  String? mother_associate;
  String? _chosenValue;
  String _chosenCategoryName ="";
  String? _chosenCaste;
  String? _chosenCasteId;
  String? do_have_aadhar = "No";
  // bool mother_aadhar_visible = true;
  final GlobalKey<FormFieldState> _key_dropdown = GlobalKey<FormFieldState>();
  bool visible = false;

  late SharedPreferences _sharedPreferences;

  List<String>   _occupation_list = [];
  List<String>   _occupation_en_list =   ['Govt. Employee','Pvt. Employee','Self Employed','Business', 'Unemployed', 'Labor', 'Farmer','Other'];

  List<String>   _occupation_hi_list =   ['सरकारी कर्मचारी','प्रा. कर्मचारी','स्वनियोजित','व्यवसाय','बेरोज़गार','श्रम','किसान', 'अन्य'];
  var cast_items;

  File? imageFile;
  late Future<List<CastCategoryData>?> _category_list;
  late Future<List<CastCategoryDetailsData>?> _cast_list;
  List<CastCategoryData> list=[];
  List<CastCategoryDetailsData> cast_list=[];
  late CastCategoryData _chosenCategory;
  late bool eng_lang;

  _getDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    setState(() async {

      if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "English") {
        eng_lang = true;
        _occupation_list = _occupation_en_list;
      } else {
        eng_lang = false;
        _occupation_list = _occupation_hi_list;
      }

      _category_list = ApiService().getCategory();
      list = (await _category_list)!;

    });
  }

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    var items = list?.map((item) {
      return DropdownMenuItem<CastCategoryData>(
        value: item,
        child: Text(eng_lang == true ? item.name.toString() : item.hiName.toString()),
      );
    }).toList();

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
          child: Stack(
            children: [

              SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("children_name"), style: style)),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: name_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("aadhar_number_children"), style: style),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          //  enabled: !mother_aadhar_visible,
                          controller: aadhar_controller,
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("do_not_aadhar"), style: style),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: do_have_aadhar,
                              onChanged: (value){
                                setState(() {
                                  do_have_aadhar = value.toString();
                                  //  mother_aadhar_visible = true;
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: do_have_aadhar,
                              onChanged: (value){
                                setState(() {
                                  do_have_aadhar = value.toString();
                                  //  mother_aadhar_visible = false;
                                });
                              },
                            ),
                          ),

                        ],
                      ),


                      Visibility(
                        // visible: mother_aadhar_visible,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("aadhar_number_mother"), style: style),
                        ),
                      ),

                      Visibility(
                        // visible: mother_aadhar_visible,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: mother_aadhar_controller,
                            keyboardType: TextInputType.number,
                            maxLength: 12,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("dob"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
                        child: DateTimeField(
                          format: format,
                          controller: dob_controller,
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
                                firstDate: DateTime(2017),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime.now());
                            return picked;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("gender"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("male"), style: style),
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("female"),style: style),
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("father_name"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: father_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("father_occupation"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          focusColor:Colors.white,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor:Colors.black,
                          items: _occupation_list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style:TextStyle(color:Colors.black),),
                            );
                          }).toList(),
                          hint:Text(AppTranslations.of(context)!.text("select_occupation"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _chosenValue = value;
                            });
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("mother_name"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: mother_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("mother_associate"), style: const TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: mother_associate,
                              onChanged: (value){
                                setState(() {
                                  mother_associate = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: mother_associate,
                              onChanged: (value){
                                setState(() {
                                  mother_associate = value.toString();
                                });
                              },
                            ),
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("mobile_number"), style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: number_controller,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // prefixText: "+91",
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("category"), style: const TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<CastCategoryData>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          focusColor:Colors.transparent,
                          //elevation: 5,
                          style: const TextStyle(color: Colors.black),
                          iconEnabledColor:Colors.black,
                          items: items,
                          hint:Text(AppTranslations.of(context)!.text("select_category"),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),

                          onChanged: (CastCategoryData? newVal)  {
                            setState(() async{
                              _key_dropdown.currentState!.reset();
                              _chosenCategory = newVal!;
                              _chosenCategoryName = newVal.name!;
                              _chosenCaste = "";
                              _chosenCasteId = "";

                              _cast_list = ApiService().getCastCategory(newVal.id.toString(), eng_lang);
                              cast_list = (await _cast_list)!;

                              setState(() {
                                cast_items = cast_list.map((item) {
                                  return DropdownMenuItem<CastCategoryDetailsData>(
                                    value: item,
                                    child: Text(item != null ? item.name.toString() : "please select the cast"),
                                  );
                                }).toList();
                              });


                            });
                          },


                        ),
                      ),


                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("cast"), style: const TextStyle(
                              fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                          )),
                        ),
                      ),

                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<CastCategoryDetailsData>(
                            key: _key_dropdown,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            isExpanded: true,
                            focusColor:Colors.transparent,

                            //elevation: 5,
                            style: const TextStyle(color: Colors.black),
                            iconEnabledColor:Colors.black,

                            hint:Text(AppTranslations.of(context)!.text("select_cast"),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: cast_items,
                            onChanged: (CastCategoryDetailsData? value) {
                              setState(() {
                                // castCategoryData = value!;
                                _chosenCaste = value!.name;
                                _chosenCasteId = value!.id;

                              });
                            },
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("belong_minority"), style: const TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: minority,
                              onChanged: (value){
                                setState(() {
                                  minority = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: minority,
                              onChanged: (value){
                                setState(() {
                                  minority = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      InkWell(
                        onTap: () async {

                          if (do_have_aadhar?.toUpperCase() == "YES") {
                            if (aadhar_controller.text.isEmpty || aadhar_controller.text.length != 12) {
                              Fluttertoast.showToast(
                                  msg: "Please enter the 12 Digit  Aadhaar Number");
                              return;
                            } else {
                              print("+++++++++++>>>>>>>>>3");
                            }
                          }


                          if (mother_aadhar_controller.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Please enter the 12 Digit Mother's Aadhaar Number");
                           } else if (name_controller.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Please enter the children Name");
                          } else if (father_controller.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Please enter the Father Name");
                          } else if (mother_controller.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Please enter the Mother Name");
                          }  else if (number_controller.text.length != 10) {
                            Fluttertoast.showToast(msg: "Please enter Valid Mobile Number");
                          } else if (dob_controller.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Please enter the Date of birth");
                          } else if (gender.toString().length == 0) {
                            Fluttertoast.showToast(msg: "Please enter the Gender");
                          } else if (_chosenValue.toString().length == 0) {
                            Fluttertoast.showToast(msg: "Please select the father occupation");
                          } else if (mother_associate.toString().isEmpty) {
                            Fluttertoast.showToast(msg: "Please select the Mother Self Group");
                          } else if (minority.toString().isEmpty) {
                            Fluttertoast.showToast(msg: "Please select the Minority");
                          } else if (_chosenCategoryName.isEmpty) {
                            Fluttertoast.showToast(msg: "Please select the Category");
                          } else if (_chosenCaste.toString().length == 0) {
                            Fluttertoast.showToast(msg: "Please select the Caste");
                          } else {

                            setState(() {
                              visible = true;
                            });

                            LoginResponse? _loginResponse = await ApiService().addChildDetails
                              (name_controller.text, aadhar_controller.text, dob_controller.text, mother_aadhar_controller.text, father_controller.text,
                                mother_controller.text, number_controller.text, mother_associate.toString(),
                                gender.toString(),_chosenValue.toString(),minority.toString(),_chosenCategory.id.toString(), _chosenCaste.toString());


                            setState(() {
                              visible = false;
                            });

                            if(_loginResponse!=null) {
                              Alert(
                                context: context,
                                style: util().alertStyle,
                                type: AlertType.success,
                                title: "",
                                desc: "Children added Successfully",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChildHomePage()));
                                    },
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                    radius: BorderRadius.circular(0.0),
                                  ),
                                ],
                              ).show();
                            } else {
                              Fluttertoast.showToast(msg: "$_loginResponse");
                            }
                          }
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 20),
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
                  )),


              visible ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Container()

            ],
          ),
        ),
      ),
    );
  }
}