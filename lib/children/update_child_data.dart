
import 'dart:io';

import 'package:arya/language/app_translations.dart';
import 'package:arya/model/get_child_gs.dart';
import 'package:arya/model/particular_child_data_gs.dart';
import 'package:arya/registration/list_view.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../libary/api_service.dart';
import '../libary/util.dart';
import '../model/caste_category.dart';
import '../model/category_of_cast.dart';
import '../model/login_gs.dart';
import 'children_listview.dart';

class UpdateChildren extends StatefulWidget {

  String? userId;
  UpdateChildren(this.userId);

  @override
  _UpdateChildrenState createState() => new _UpdateChildrenState(userId);
}


class _UpdateChildrenState extends State<UpdateChildren> {

  String? userId;
  _UpdateChildrenState(this.userId);

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  final format = DateFormat("dd-MM-yyyy");
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
  String _chosenCategoryId="";
  String? _chosenCaste = "";
  String? _chosenCasteId;
  String? do_have_aadhar = "No";
  bool mother_aadhar_visible = false;

  bool visible = true;

  late SharedPreferences _sharedPreferences;

  List<String> _occupation_list =[];
  File? imageFile;

  late Future<List<CastCategoryData>?> _category_list;
  List<CastCategoryData> list=[];

  late bool eng_lang;

  late SingleChildData? _childData;

  List<CastCategoryDetailsData> cast_list=[];
  late Future<List<CastCategoryDetailsData>?> _cast_list;
  var cast_items;
  final GlobalKey<FormFieldState> _key_dropdown = GlobalKey<FormFieldState>();

  _getDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _childData = await ApiService().getSingleChildDetails(userId);

    setState(() async {

      print(userId);
      print(_childData!.data.toString());

      if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "English") {
        eng_lang = true;

        _occupation_list =   [
          'Govt. Employee',
          'Pvt. Employee',
          'Self Employed',
          'Business',
          'Unemployed',
          'Labor',
          'Farmer',
          'Other',
        ];

      } else {
        eng_lang = false;
        _occupation_list =   [
          'सरकार। कर्मचारी',
          'प्रा. कर्मचारी',
          'स्वनियोजित',
          'व्यवसाय',
          'बेरोज़गार',
          'श्रम',
          'किसान',
          'अन्य',
        ];
      }

      _category_list = ApiService().getCategory();
      list = (await _category_list)!;



      String date = _childData!.data!.dOB.toString().toString().substring(0,10);

      name_controller.text = _childData!.data!.name.toString();
      aadhar_controller.text = _childData!.data!.aadhar.toString();
      mother_aadhar_controller.text = _childData!.data!.motherAdhar.toString();
      mother_controller.text = _childData!.data!.motherName.toString();
      father_controller.text = _childData!.data!.fatherName.toString();
      number_controller.text = _childData!.data!.mobileNumber.toString();
      //  dob_controller.text = tempDate.toString();
      _chosenValue = _childData!.data!.fatherOccupation.toString();
      mother_associate = _childData!.data!.motherSelfHelpGroup.toString();
      _chosenCaste = _childData!.data!.cast.toString();
      _chosenCategoryId = _childData!.data!.categoryId.toString();

      _cast_list = ApiService().getCastCategory(_chosenCategoryId.toString(), eng_lang);
      cast_list = (await _cast_list)!;

      setState(() {
        cast_items = cast_list.map((item) {
          return DropdownMenuItem<CastCategoryDetailsData>(
            value: item,
            child: Text(item.name.toString()),
          );
        }).toList();
      });



      setState(() {

        for (var i = 0; i < list.length; i++) {

          if(list[i].id.toString() == _childData!.data!.categoryId.toString()) {
            _chosenCategoryName = list[i].name.toString();
          }
        }


        dob_controller.text = date;
        gender = _childData!.data!.gender.toString();

        if(_childData!.data!.hasAadhar == true) {
          do_have_aadhar = "Yes";
        } else {
          do_have_aadhar = "No";
        }

        if(_childData!.data!.isReligiousMinority == true) {
          minority = "Yes";
        } else {
          minority = "No";
        }
      });

      visible =false;

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
        title: Text(AppTranslations.of(context)!.text("update_user")),
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

                      /* Center(
                    child: InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0)),
                          child: Image.asset('assets/images/profile_icon.png')
                      ),
                    ),
                  ),*/


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
                          enabled: !mother_aadhar_visible,
                          controller: aadhar_controller,
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
                                  mother_aadhar_visible = true;
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
                                  mother_aadhar_visible = false;
                                });
                              },
                            ),
                          ),

                        ],
                      ),


                      Visibility(
                        visible: mother_aadhar_visible,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text(AppTranslations.of(context)!.text("aadhar_number_mother"), style: style),
                        ),
                      ),

                      Visibility(
                        visible: mother_aadhar_visible,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: mother_aadhar_controller,
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
                                firstDate: DateTime(2000),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
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
                          hint:Text(_chosenValue == null ? AppTranslations.of(context)!.text("select_occupation") : _chosenValue!,
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
                          hint:Text(_chosenCategoryName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),

                          onChanged: (CastCategoryData? newVal) {
                            setState(() async {

                              _key_dropdown.currentState!.reset();

                              _chosenCategoryId = newVal!.id!;
                              _chosenCategoryName = newVal!.name!;

                              _cast_list = ApiService().getCastCategory(newVal.id.toString(), eng_lang);
                              cast_list = (await _cast_list)!;

                              setState(() {
                                cast_items = cast_list.map((item) {
                                  return DropdownMenuItem<CastCategoryDetailsData>(
                                    value: item,
                                    child: Text(item.name.toString()),
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

                            hint:Text(_chosenCaste!,
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
                            if (mother_aadhar_controller.text.isEmpty || mother_aadhar_controller.text.length != 12) {
                              Fluttertoast.showToast(msg: "Please enter the 12 Digit Mother's Aadhaar Number");
                              return;
                            } else if (aadhar_controller.text.isEmpty || aadhar_controller.text.length != 12) {
                              Fluttertoast.showToast(
                                  msg: "Please enter the 12 Digit  Aadhaar Number");
                              return;
                            } else {
                              print("+++++++++++>>>>>>>>>3");
                            }
                          }


                          if (name_controller.text.isEmpty) {
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
                          } else if (_chosenCategoryId.toString().isEmpty) {
                            Fluttertoast.showToast(msg: "Please select the Category");
                          } else if (_chosenCaste.toString().length == 0) {
                            Fluttertoast.showToast(msg: "Please select the Caste");
                          } else {

                            setState(() {
                              visible = true;
                            });

                            String? _loginResponse = await ApiService().updateChildDetails
                              (userId, name_controller.text, aadhar_controller.text, dob_controller.text, mother_aadhar_controller.text, father_controller.text,
                                mother_controller.text, number_controller.text, mother_associate.toString(),
                                gender.toString(),_chosenValue.toString(),minority.toString(),_chosenCategoryId.toString(), _chosenCaste.toString());

                            setState(() {
                              visible = false;
                            });

                            if(_loginResponse == "200") {
                              Alert(
                                context: context,
                                style: util().alertStyle,
                                type: AlertType.success,
                                title: "",
                                desc: "Children Data Update Successfully",
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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

                            print(_loginResponse);

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

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => SimpleDialog(
            title: Text(AppTranslations.of(context)!.text("add_photos")),

            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                child: const Text('Take photo'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                child: const Text('Choose from Gallery'),
              ),
            ]
        ));
  }


  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}