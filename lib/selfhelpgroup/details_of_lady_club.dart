
import 'package:arya/children/add_new_children.dart';
import 'package:arya/children/growth_monitaring.dart';
import 'package:arya/children/nutrition_class.dart';
import 'package:arya/children/tika_vavaran.dart';
import 'package:arya/ladies/add_new_lady.dart';
import 'package:arya/ladies/lady_nutrition_process.dart';
import 'package:arya/model/self_help_group_model.dart';
import 'package:arya/selfhelpgroup/add_self_help_group.dart';
import 'package:arya/ladies/suckle_lady.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/get_child_gs.dart';
import '../model/self_help_group_view.dart';

class LadiesGroupDetails extends StatefulWidget {

  String? id;
  LadiesGroupDetails(this.id);

  @override
  _LadiesGroupDetailsState createState() => _LadiesGroupDetailsState(this.id);
}

class _LadiesGroupDetailsState extends State<LadiesGroupDetails> {

  String? id;
  _LadiesGroupDetailsState(this.id);

  AppConstants api = AppConstants();
  final format = DateFormat("dd-MM-yyyy");
  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);

  SelfHelpViewModelData? club_details;
  List<MemberDetails> _member_list = [];
  TextEditingController txt_date = TextEditingController(text:'');

  List<bool> _check_list = [];

  getDetails() async {
    club_details = await ApiService().getSelfHelpGroupDetails(id!);

    setState(() {
      _member_list = club_details!.memberDetails!;
      txt_date.text = club_details!.joiningClubDate.toString();

      _member_list.forEach((element) {_check_list.add(false); });
    });




  }

  @override
  void initState() {
    super.initState();
    getDetails();
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
                   controller: txt_date,
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
                        'बाल विवाह अधिनियम - 2006',
                        'दहेज़ निषेध अधिनियम - 1961',
                        'राजस्थान डायन-प्रताड़ना निवारण अधिनियम - 2013',
                        'गर्भधारण पूर्व एवं प्रसूति पूर्ण तकनीक अधिनियम - 1994',
                        'घरेलू हिंसा से महिलाओ का सरक्षण अधिनियम - 2005',
                        'महिलाओ का कार्यस्थल पर उत्पीड़न अधिनियम - 2013',
                        'अन्य'
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

                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _member_list.length,
                      itemBuilder: (context, index) {
                        return  Row(
                          children: [

                            Expanded(
                              flex:3,
                              child: Text(_member_list[index].name.toString(), style: style),
                            ),

                            Expanded(
                              flex:3,
                              child: Text(_member_list[index].designation.toString(), style: style),
                            ),

                            Expanded(
                              flex:3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlutterSwitch(
                                  value: _check_list[index],
                                  activeColor: Colors.green,
                                  width: 60.0,
                                  height: 30.0,
                                  onToggle: (val) {
                                    setState(() {
                                      _check_list[index] = val;
                                    });
                                  },
                                ),
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
                      const EdgeInsets.only(left: 40.0, right: 40,top: 50),
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
