
import 'dart:convert';
import 'package:arya/model/self_help_group_metting_list_gs.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../libary/util.dart';

class LadiesGroupDetails extends StatefulWidget {

  String? id;
  String? topic;
  String? date;
  List<SelfMemberDetails>? member_list;
  LadiesGroupDetails(this.id, this.member_list, this.topic, this.date);

  @override
  _LadiesGroupDetailsState createState() => _LadiesGroupDetailsState(this.id, this.member_list, topic, date);
}

class _LadiesGroupDetailsState extends State<LadiesGroupDetails> {

  String? id;
  String? topic;
  String? date;
  List<SelfMemberDetails>? member_list;
  _LadiesGroupDetailsState(this.id, this.member_list, this.topic, this.date);

  AppConstants api = AppConstants();
  final format = DateFormat("dd-MM-yyyy");
  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);

  List<MeetingMemberDetails> _member_list = [];
  bool visible = false;

  getDetails() async {

    setState(() {

      for(int i=0 ;i <member_list!.length;i++) {
        MeetingMemberDetails memberDetails = new MeetingMemberDetails();

        memberDetails.name = member_list![i].name;
        memberDetails.designation = member_list![i].designation;
        memberDetails.id = member_list![i].id;
        memberDetails.attendence = false;

        _member_list.add(memberDetails);
      }

    });
  }

  @override
  void initState() {
    super.initState();
    getDetails();

    print(id);
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
          child: Stack(
            children: [

             SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Padding(
                            padding: EdgeInsets.only(left: 8.0,top: 8.0,bottom: 10),
                            child: Text("Details of the monthly meeting of the women's club", style: style)),
                      ),

                      const Divider(thickness: 1,color: Colors.grey,),


                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 5.0),
                          child: Text("Date of meeting : ${date}", style: style),
                        ),
                      ),


                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 20.0),
                          child: Text("Topic of Meeting : ${topic}", style: style),
                        ),
                      ),


                      SizedBox(height: 20,),

                      const Divider(thickness: 1,color: Colors.grey,),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 5.0),
                          child: Text("Details of Member", style: style),
                        ),
                      ),

                      const Divider(thickness: 1,color: Colors.grey,),

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
                                      value: _member_list[index].attendence ?? false,
                                      activeColor: Colors.green,
                                      width: 60.0,
                                      height: 30.0,
                                      onToggle: (val) {
                                        setState(() {
                                          _member_list[index].attendence = val;
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
                        onTap: () async {

                          List<MeetingMemberDetails> present_member_list = [];

                          for(int k=0; k < _member_list!.length; k++) {

                            if(_member_list[k].attendence == true){
                              present_member_list.add(_member_list[k]);
                            }
                          }

                          List<Map<String, dynamic>> jsonList = present_member_list.map((member) => member.toJson()).toList();
                          String jsonString = jsonEncode(jsonList);

                          jsonString = jsonString.replaceAll('desination', 'designation');
                          jsonString = jsonString.replaceAll('attendence', 'attendance');

                          setState(() {
                            visible = true;
                          });

                          String? response = await ApiService().addSelfHelpGroupMeetingAttendance(id.toString(), jsonString);

                          setState(() {
                            visible = false;
                          });

                          if (response == "201") {
                            Alert(
                              context: context,
                              style: util().alertStyle,
                              type: AlertType.success,
                              title: "",
                              desc: "Meeting added Successfully",
                              buttons: [
                                DialogButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  color:
                                  Color.fromRGBO(0, 179, 134, 1.0),
                                  radius: BorderRadius.circular(0.0),
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ).show();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Something went wrong");
                          }

                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.all(50),
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
              ),

              visible ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Container()
            ]
          )),


    );
  }

}
