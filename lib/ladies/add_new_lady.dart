import 'package:arya/ladies/add_new_lady_response.dart';
import 'package:arya/ladies/ladies_home_page.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/model/caste_category.dart';
import 'package:arya/model/category_of_cast.dart';
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
import '../model/login_gs.dart';

class AddNewladies extends StatefulWidget {

  String refid;
  AddNewladies(this.refid);

  @override
  _AddNewladiesState createState() => new _AddNewladiesState(this.refid);
}

class _AddNewladiesState extends State<AddNewladies> {

  String refid;
  _AddNewladiesState(this.refid);

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  final format = DateFormat("MM/dd/yyyy");
  String? first_pregnancy;
  String? pregnant;
  String? miscarriage;
  String? decceased;

  String? minority;
  String? _chosenValue;
  String _chosenCategoryName ="";
  String? _chosenCaste;
  String? _chosenCasteId;


  final GlobalKey<FormFieldState> _key_dropdown = GlobalKey<FormFieldState>();

  TextEditingController name_controller = new TextEditingController(text:'');
  TextEditingController aadhar_controller = new TextEditingController(text:'');
  TextEditingController number_controller = new TextEditingController(text:'');
  TextEditingController husband_controller = new TextEditingController(text:'');
  TextEditingController swastha_controller = new TextEditingController(text:'');
  TextEditingController dob_controller = new TextEditingController(text:'');
  TextEditingController time_controller = new TextEditingController(text:'');

  String? married;

  late SharedPreferences _sharedPreferences;


  late Future<List<CastCategoryData>?> _category_list;
  late Future<List<CastCategoryDetailsData>?> _cast_list;
  List<CastCategoryData> list=[];
  List<CastCategoryDetailsData> cast_list=[];
  late CastCategoryData _chosenCategory;
  var cast_items;
  bool eng_lang= false;
  bool married_visible = false;
  bool visible = false;

  _getDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if(_sharedPreferences.getString(AppConstants.SELECTED_LANGUAGE) == "English") {
      eng_lang = true;
    } else {
      eng_lang = false;
    }

    _category_list = ApiService().getCategory();
    list = (await _category_list)!;
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

        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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
                        controller: husband_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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
                        maxLength: 12,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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
                        controller: swastha_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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
                        controller: dob_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime.now());
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
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // prefixText: "+91",
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                      child: Text(AppTranslations.of(context)!.text("are_you_married"), style: style),
                    ),

                    Row(
                      children: [

                        Expanded(

                          child: RadioListTile(
                            title: const Text("Single"),
                            value: "Single",
                            groupValue: married,
                            onChanged: (value){
                              setState(() {
                                married = value.toString();
                                married_visible = false;
                              });
                            },
                          ),
                        ),

                        Expanded(

                          child: RadioListTile(
                            title: const Text("Married"),
                            value: "Married",
                            groupValue: married,
                            onChanged: (value){
                              setState(() {
                                married = value.toString();
                                married_visible =true;
                              });
                            },
                          ),
                        ),

                      ],
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



                  Visibility(
                    visible: married_visible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("first_pregnancy"), style: style),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: first_pregnancy,
                              onChanged: (value){
                                setState(() {
                                  first_pregnancy = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: first_pregnancy,
                              onChanged: (value){
                                setState(() {
                                  first_pregnancy = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("pregnancy_status"), style: style),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: pregnant,
                              onChanged: (value){
                                setState(() {
                                  pregnant = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: pregnant,
                              onChanged: (value){
                                setState(() {
                                  pregnant = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("garbhPath_before"), style: style),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: miscarriage,
                              onChanged: (value){
                                setState(() {
                                  miscarriage = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: miscarriage,
                              onChanged: (value){
                                setState(() {
                                  miscarriage = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text(AppTranslations.of(context)!.text("Labhahti_death"), style: style),
                      ),

                      Row(
                        children: [

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("yes"), style: style),
                              value: "Yes",
                              groupValue: decceased,
                              onChanged: (value){
                                setState(() {
                                  decceased = value.toString();
                                });
                              },
                            ),
                          ),

                          Expanded(

                            child: RadioListTile(
                              title: Text(AppTranslations.of(context)!.text("no"),style: style),
                              value: "No",
                              groupValue: decceased,
                              onChanged: (value){
                                setState(() {
                                  decceased = value.toString();
                                });
                              },
                            ),
                          ),
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
                        controller: time_controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[1]))
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

                    InkWell(
                      onTap: () async {

                        if (name_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter the children Name");
                        } else if (husband_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter the Father or husband Name");
                        } else if (aadhar_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter the aadhar Name");
                        } else if (dob_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Please enter the Date of birth");
                        }else if (_chosenValue.toString().length == 0) {
                          Fluttertoast.showToast(msg: "Please select the father occupation");
                        } else if (married.toString().isEmpty) {
                          Fluttertoast.showToast(msg: "Please select the Married Status");
                        } else if (minority.toString().isEmpty) {
                          Fluttertoast.showToast(msg: "Please select the Minority");
                        }else if (married.toString().isEmpty) {
                          Fluttertoast.showToast(msg: "Please select the married");
                        } else if (_chosenCategoryName.isEmpty) {
                          Fluttertoast.showToast(msg: "Please select the Category");
                        } else if (_chosenCaste.toString().length == 0) {
                          Fluttertoast.showToast(msg: "Please select the Caste");
                        } else {

                          setState(() {
                            visible = true;
                          });

                          bool isFirstPregnancy;
                          bool areYouPregnant;
                          bool isBeneficiary;
                          bool isAbortionBefore;

                          if(married == "Single") {
                            isFirstPregnancy = false;
                            areYouPregnant = false;
                            isBeneficiary = false;
                            isAbortionBefore = false;
                          } else{
                            areYouPregnant = pregnant == "Yes" ?  true: false;
                            isFirstPregnancy = first_pregnancy == "Yes" ?  true: false;
                            isBeneficiary =  decceased == "Yes" ?  true: false;
                            isAbortionBefore = miscarriage == "Yes" ?  true: false;
                          }


                          String? _loginResponse = await ApiService().addLadyDetails(
                              refid,
                              name_controller.text,
                              husband_controller.text,
                              aadhar_controller.text,
                              swastha_controller.text,
                              dob_controller.text,
                              number_controller.text,
                              _chosenCategory.id.toString(),
                              _chosenCaste.toString(),
                              minority == 'Yes' ? true : false,
                              married!,
                              time_controller.text,
                              isFirstPregnancy,
                              areYouPregnant,
                              isBeneficiary,
                              isAbortionBefore);

                          setState(() {
                            visible = false;
                          });


                          if(_loginResponse == "201") {
                            Alert(
                              context: context,
                              style: util().alertStyle,
                              type: AlertType.success,
                              title: "",
                              desc: "Women added Successfully",
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
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LadiesHomePage()));  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                  radius: BorderRadius.circular(0.0),
                                ),
                              ],
                            ).show();
                          } else {
                            Fluttertoast.showToast(msg: ""+_loginResponse!);
                          }
                        }

                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.all(20.0),
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

            visible ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }



}