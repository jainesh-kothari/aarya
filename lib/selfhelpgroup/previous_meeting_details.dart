
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

class PreviousMeetingDetails extends StatefulWidget {

  String? id;
  String? topic;
  String? date;
  List<MeetingMemberDetails>? member_list;
  PreviousMeetingDetails(this.id, this.member_list, this.topic, this.date);

  @override
  _PreviousMeetingDetailsState createState() => _PreviousMeetingDetailsState(this.id, this.member_list, topic, date);
}

class _PreviousMeetingDetailsState extends State<PreviousMeetingDetails> {

  String? id;
  String? topic;
  String? date;
  List<MeetingMemberDetails>? member_list;
  _PreviousMeetingDetailsState(this.id, this.member_list, this.topic, this.date);

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
                              padding: EdgeInsets.only(left: 8.0,top: 8.0),
                              child: Text("Details of the monthly meeting of the women's club", style: style)),
                        ),

                        const Divider(thickness: 1,color: Colors.grey,),


                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 10.0),
                            child: Text("Date of meeting : ${date}", style: style),
                          ),
                        ),


                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 20.0),
                            child: Text("Topic of Meeting : ${topic}", style: style),
                          ),
                        ),


                        SizedBox(height: 10,),

                        const Divider(thickness: 1,color: Colors.grey,),

                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 5.0),
                            child: Text("Present Member Details in meeting", style: style),
                          ),
                        ),



                        SizedBox(height: 10,),

                        const Divider(thickness: 1,color: Colors.grey,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [

                              Expanded(
                                flex:5,
                                child: Center(child: Text("Name", style: style)),
                              ),

                              Expanded(
                                flex:5,
                                child: Center(child: Text("Designation", style: style)),
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
                              return  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [

                                    Expanded(
                                      flex:5,
                                      child: Center(child: Text(_member_list[index].name.toString(), style: style)),
                                    ),

                                    Expanded(
                                      flex:5,
                                      child: Center(child: Text(_member_list[index].designation.toString(), style: style)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
              ]
          )),
    );
  }

}
