
import 'package:arya/model/self_help_group_edit_gs.dart';
import 'package:arya/model/self_help_group_model.dart';
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

class EditSelfHelpGroup extends StatefulWidget {

  String id;
  EditSelfHelpGroup(this.id);

  @override
  _EditSelfHelpGroupState createState() => new _EditSelfHelpGroupState(id);
}


class _EditSelfHelpGroupState extends State<EditSelfHelpGroup> {

  String id;
  _EditSelfHelpGroupState(this.id);
  late String _chosenValue;

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();
  final format = DateFormat("dd-MM-yyyy");

  TextEditingController club_name = TextEditingController(text:'');
  TextEditingController club_date = TextEditingController(text:'');

  List<Widget> _cardList = [];

  bool _expanded = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  bool _expanded4 = false;

  String? _president_id;
  String? _president_designation;
  TextEditingController _president_mobile = TextEditingController(text:'');
  TextEditingController _president_name = TextEditingController(text:'');

  String? _mentor_id;
  String? _mentor_designation;
  TextEditingController _mentor_mobile = TextEditingController(text:'');
  TextEditingController _mentor_name = TextEditingController(text:'');

  String? _secretary_designation;
  String? _secretary_id;
  TextEditingController _secretary_mobile = TextEditingController(text:'');
  TextEditingController _secretary_name = TextEditingController(text:'');

  List<SelfHelpGroupModelWithId> memberDetails = [];

  List<String> _member_id = [];
  List<String> _member_designation = [];
  List<TextEditingController> _member_mobile = [];
  List<TextEditingController> _member_name = [];

  bool visible = false;
  String center_id ="";
  late SelfHelpGroupGSData _selfHelpGroupGSData;
  late SharedPreferences _sharedPreferences;

  Widget _exsitsCard(int index, SelfHelpGroupGSMemberDetails member) {

    _member_id.add(member.id.toString());
    _member_designation.add(member.designation.toString());
    _member_mobile.add(TextEditingController(text:member.mobileNumber.toString()));
    _member_name.add(TextEditingController(text:member.name.toString()));

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(
                  padding: EdgeInsets.only(left: 8.0,top: 8.0),
                  child: Text("Designation", style: style)),

              // this is the close button
              Visibility(
                visible: index !=0 ? true : false,
                child: Padding(
                    padding: EdgeInsets.only(left: 8.0,top: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _showAlertDialog(context,_member_id[index].toString(),index);
                      },
                    )),
              ),
            ],
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
                'सुरक्षासखी',
                'ग्राम विकास अधिकारी',
                'पटवारी',
                'ANM',
                'महिला अध्यपाक',
                'आंगनवाड़ी कार्यकर्त्ता',
                'आंगनवाड़ी सहायिका',
                'आशा सहयोगिनी',
                'विधार्थी',
                'वार्डपंच',
                'राजकीय SHG की पदाधिकारी '
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style:TextStyle(color:Colors.black),),
                );
              }).toList(),
              hint:Text(_member_designation[index].toString().isEmpty ? "Select the topic" : _member_designation[index].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String? value) {
                setState(() {
                  _member_designation[index] = value!;
                });
              },
            ),
          ),


          Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text("Name", style: style)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _member_name[index],
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
            child: Text("Mobile Number", style: style),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _member_mobile[index],
              keyboardType: TextInputType.number,
              maxLength: 10,
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
        ],
      ),
    );
  }

  Widget _card(int index) {

    _member_designation.add("");
    _member_mobile.add(TextEditingController(text:''));
    _member_name.add(TextEditingController(text:''));

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text("Designation", style: style)),

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
                'सुरक्षासखी',
                'ग्राम विकास अधिकारी',
                'पटवारी',
                'ANM',
                'महिला अध्यपाक',
                'आंगनवाड़ी कार्यकर्त्ता',
                'आंगनवाड़ी सहायिका',
                'आशा सहयोगिनी',
                'विधार्थी',
                'वार्डपंच',
                'राजकीय SHG की पदाधिकारी '
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
                  _member_designation[index] = value!;
                });
              },
            ),
          ),


          Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text("Name", style: style)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _member_name[index],
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
            child: Text("Mobile Number", style: style),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _member_mobile[index],
              keyboardType: TextInputType.number,
              maxLength: 10,
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
        ],
      ),
    );
  }

  getDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _selfHelpGroupGSData = (await ApiService().getSelfHelpGroupData(id))!;

    setState(() {
      club_name.text = _selfHelpGroupGSData.ladyClubName!;
      club_date.text = _selfHelpGroupGSData.joiningClubDate!;
      center_id = _sharedPreferences.getString(AppConstants.CENTERID).toString();

      List<SelfHelpGroupGSMemberDetails>? memberDetails = _selfHelpGroupGSData.memberDetails;

      for (var k = 3; k < memberDetails!.length; k++) {
        var i = k - 3;
        _cardList.add(_exsitsCard(i,memberDetails[k]));
      }

      for (int i = 0; i < memberDetails!.length; i++) {

        if (memberDetails[i].memberType == 1) {
          _president_id = memberDetails![i].id;
          _president_designation = memberDetails![i].designation;
          _president_mobile.text = memberDetails![i].mobileNumber!.toString();
          _president_name.text = memberDetails![i].name!;
        }

        if (memberDetails[i].memberType == 2) {
          _mentor_id = memberDetails![i].id;
          _mentor_designation = memberDetails![i].designation;
          _mentor_mobile.text = memberDetails![i].mobileNumber!.toString();
          _mentor_name.text = memberDetails![i].name!;
        }

        if (memberDetails[i].memberType == 3) {
          _secretary_id = memberDetails![i].id;
          _secretary_designation = memberDetails![i].designation;
          _secretary_mobile.text = memberDetails![i].mobileNumber!.toString();
          _secretary_name.text = memberDetails![i].name!;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getDetails();

    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppConstants.BLUE_COLOR[0]),
        title: Text("Self Help Group"),
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
                          child: Text("Lady Club Name", style: style)),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: club_name,
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
                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text("Date of adding Lady club ", style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
                        child: DateTimeField(
                          format: format,
                          controller: club_date,
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
                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text("Details of Members", style: style)),


                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              children: <Widget>[

                                ListTile(
                                  title: (const Text(
                                    '1. President',
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                                  trailing: IconButton(
                                      icon: _expanded
                                          ? Icon(Icons.expand_less)
                                          : Icon(Icons.expand_more),
                                      onPressed: () {
                                        setState(() {
                                          _expanded = !_expanded;
                                        });
                                      }),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),

                                  height: _expanded ? 350 : 0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                    children: <Widget>[

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Designation", style: style)),

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
                                            'सरपंच',
                                            'वार्डपंच'
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style:TextStyle(color:Colors.black),),
                                            );
                                          }).toList(),
                                          hint:Text(_president_designation.toString().isEmpty ? "Select the topic" : _president_designation.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _president_designation = value;
                                            });
                                          },
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Name", style: style)),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _president_name,
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
                                        child: Text("Mobile Number", style: style),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _president_mobile,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
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


                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _expanded2 = !_expanded2;
                            });
                          },
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              children: <Widget>[

                                ListTile(
                                  title: (const Text(
                                    '2. Mentor',
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                                  trailing: IconButton(
                                      icon: _expanded2
                                          ? Icon(Icons.expand_less)
                                          : Icon(Icons.expand_more),
                                      onPressed: () {
                                        setState(() {
                                          _expanded2 = !_expanded2;
                                        });
                                      }),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),

                                  height: _expanded2
                                      ? 350
                                      : 0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                    children: <Widget>[

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Designation", style: style)),

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
                                            'सरपंच',
                                            'वार्डपंच'
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style:TextStyle(color:Colors.black),),
                                            );
                                          }).toList(),
                                          hint:Text(_mentor_designation.toString().isEmpty ? "Select the topic" : _mentor_designation.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _mentor_designation = value;
                                            });
                                          },
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Name", style: style)),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _mentor_name,
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
                                        child: Text("Mobile Number", style: style),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _mentor_mobile,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
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


                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _expanded3 = !_expanded3;
                            });
                          },
                          child: Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              children: <Widget>[

                                ListTile(
                                  title: (const Text(
                                    '3. Member secretary',
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                                  trailing: IconButton(
                                      icon: _expanded3
                                          ? Icon(Icons.expand_less)
                                          : Icon(Icons.expand_more),
                                      onPressed: () {
                                        setState(() {
                                          _expanded3 = !_expanded3;
                                        });
                                      }),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),

                                  height: _expanded3
                                      ? 350
                                      : 0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                    children: <Widget>[

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Designation", style: style)),

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
                                            'सरपंच',
                                            'AWW'
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style:TextStyle(color:Colors.black),),
                                            );
                                          }).toList(),
                                          hint:Text(_secretary_designation.toString().isEmpty ? "Select the topic" : _secretary_designation.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _secretary_designation = value;
                                            });
                                          },
                                        ),
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                          child: Text("Name", style: style)),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _secretary_name,
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
                                        child: Text("Mobile Number", style: style),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _secretary_mobile,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
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


                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _expanded4 = !_expanded4;
                            });
                          },
                         child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                title: (const Text(
                                  '4. Member',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                                trailing: IconButton(
                                    icon: _expanded4
                                        ? Icon(Icons.expand_less)
                                        : Icon(Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded4 = !_expanded4;
                                      });
                                    }),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),

                                height: _expanded4
                                    ? MediaQuery.of(context).size.height
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: _cardList.length,
                                      itemBuilder: (context, index) {
                                        return _cardList[index];
                                      },
                                    ),


                                    Visibility(
                                      visible: false,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:80.0,right: 80,top: 20,bottom: 20),
                                        child: ElevatedButton(
                                          child: Text('Add New Member'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _cardList.add(_card(_cardList.length));


                                            });
                                          },
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        )
                      ),

                      SizedBox(height: 50),

                      Center(
                        child: SizedBox(
                          width: 200.0,
                          child: ElevatedButton(
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed:() async {
                              setState(() {
                                memberDetails.clear();

                                if (club_name.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the club name");
                                  return;
                                }

                                if (club_date.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the club date");
                                  return;
                                }

                                if (_president_designation == null) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please select the president designation");
                                  return;
                                }

                                if (_secretary_designation == null) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please select the secretary designation");
                                  return;
                                }

                                if (_mentor_designation == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the mentor designation");
                                  return;
                                }

                                if (_president_mobile.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please select the president mobileNumber");
                                  return;
                                }

                                if (_president_name.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the president name");
                                  return;
                                }

                                if (_secretary_mobile.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please select the president mobileNumber");
                                  return;
                                }

                                if (_secretary_name.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the secretary name");
                                  return;
                                }

                                if (_mentor_mobile.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please select the secretary mobileNumber");
                                  return;
                                }

                                if (_mentor_name.text.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please select the mentor name");
                                  return;
                                }

                                SelfHelpGroupModelWithId first = SelfHelpGroupModelWithId();
                                first.sno = 1;
                                first.designation = _president_designation;
                                first.id = _president_id;
                                first.mobileNumber = _president_mobile.text;
                                first.name = _president_name.text;

                                SelfHelpGroupModelWithId second = SelfHelpGroupModelWithId();
                                second.sno = 2;
                                second.id = _mentor_id;
                                second.designation = _mentor_designation;
                                second.mobileNumber = _mentor_mobile.text;
                                second.name = _mentor_name.text;

                                SelfHelpGroupModelWithId third = SelfHelpGroupModelWithId();
                                third.sno = 3;
                                third.id = _secretary_id;
                                third.designation = _secretary_designation;
                                third.mobileNumber = _secretary_mobile.text;
                                third.name = _secretary_name.text;

                                memberDetails.add(first);
                                memberDetails.add(second);
                                memberDetails.add(third);
                              });

                              for (int i = 0; i < _member_designation.length; i++) {
                                SelfHelpGroupModelWithId fourth = SelfHelpGroupModelWithId();
                                fourth.sno = (i + 4);
                                fourth.id = _member_id[i];
                                fourth.designation = _member_designation[i];
                                fourth.mobileNumber = _member_mobile[i].text;
                                fourth.name = _member_name[i].text;
                                memberDetails.add(fourth);
                              }

                              setState(() {
                                visible = true;
                              });

                              String? response =  await ApiService().updateWomenSelfHelpGroup(center_id!, club_name.text,
                                  club_date.text, memberDetails, id);

                              setState(() {
                                visible = false;
                              });


                              if(response == "200"){
                                Alert(
                                  context: context,
                                  style: util().alertStyle,
                                  type: AlertType.success,
                                  title: "",
                                  desc: "Women Self help Group updated Successfully",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Okay",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                ).show();
                              } else {
                                Fluttertoast.showToast(msg: "$response");
                              }

                            },
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

        floatingActionButton: FloatingActionButton(
          onPressed: () {

            _showDecline();

          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        )
    );
  }

  Future<void> _showAlertDialog(BuildContext context, String id, int index) async   {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Delete Member'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this Member ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {

                ApiService().deleteSelfHelpGroupMember(id);

                setState(() {
                  _member_designation.removeAt(index);
                  _member_mobile.removeAt(index);
                  _member_name.removeAt(index);
                  _cardList.removeAt(index);
                });

                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }



  _showDecline() {
    TextEditingController name = new TextEditingController(text:'');
    TextEditingController number = new TextEditingController(text:'');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Center(child: new Text("Add New Member")),
              content:
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Padding(
                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text("Designation", style: style)),

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
                          'सुरक्षासखी',
                          'ग्राम विकास अधिकारी',
                          'पटवारी',
                          'ANM',
                          'महिला अध्यपाक',
                          'आंगनवाड़ी कार्यकर्त्ता',
                          'आंगनवाड़ी सहायिका',
                          'आशा सहयोगिनी',
                          'विधार्थी',
                          'वार्डपंच',
                          'राजकीय SHG की पदाधिकारी '
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
                            _chosenValue = value!;
                          });
                        },
                      ),
                    ),


                    Padding(
                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text("Name", style: style)),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                         controller: name,
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
                      child: Text("Mobile Number", style: style),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: number,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
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


                    Center(
                      child: ElevatedButton(
                        child: Text('Add New Member'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () async {

                          if (club_name.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Please select the club name");
                            return;
                          }

                          if (club_date.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Please select the club date");
                            return;
                          }

                          SelfHelpGroupModelWithId fifth = SelfHelpGroupModelWithId();
                          fifth.sno = (memberDetails.length + 1);
                          fifth.designation = _chosenValue;
                          fifth.mobileNumber = number.text;
                          fifth.name = name.text;

                          memberDetails.add(fifth);

                          print(memberDetails);
                          Navigator.pop(context);

                          String? response =  await ApiService().updateWomenSelfHelpGroup(center_id!, club_name.text,
                              club_date.text, memberDetails, id);


                          if(response == "200"){
                            Fluttertoast.showToast(msg: "user added successfully");
                          } else {
                            Fluttertoast.showToast(msg: "$response");
                          }

                        },
                      ),
                    )
                  ],
                ),
              ),

            );
          },
        );
      },
    );
  }

}