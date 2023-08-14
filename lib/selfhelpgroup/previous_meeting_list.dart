import 'package:arya/model/self_help_group_metting_list_gs.dart';
import 'package:arya/selfhelpgroup/details_of_lady_club.dart';
import 'package:arya/selfhelpgroup/previous_meeting_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../libary/api_service.dart';
import '../util/appcontants.dart';
import 'add_meeting_self_help_group.dart';

class PreviousMeetingListView extends StatefulWidget {

  List<SelfHelpGroupMeeting>? selfHelpGroupMeeting;
  PreviousMeetingListView(this.selfHelpGroupMeeting);

  @override
  _PreviousMeetingListViewState createState() => _PreviousMeetingListViewState(this.selfHelpGroupMeeting);
}

class _PreviousMeetingListViewState extends State<PreviousMeetingListView> {

  List<SelfHelpGroupMeeting>? selfHelpGroupMeeting;
  _PreviousMeetingListViewState(this.selfHelpGroupMeeting);

  AppConstants api = AppConstants();
  
  List<SelfHelpGroupMeeting>? prv_meeting_list =[];
  int list_size = 0;

  _getData() async {
    setState(() {
      for(int i=0;i<selfHelpGroupMeeting!.length; i++) {
        if (!selfHelpGroupMeeting![i].memberDetails!.isEmpty) {
          prv_meeting_list?.add(selfHelpGroupMeeting![i]);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
        title: Text("Previous Meetings"),
        centerTitle: true,
      ),

      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: prv_meeting_list!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousMeetingDetails(
                          prv_meeting_list![index].id, prv_meeting_list![index].memberDetails,
                          prv_meeting_list![index]!.topicOfMeeting, prv_meeting_list![index]!.dateOfMetting)));
                    },
                    child: Card(
                        elevation: 8,
                        shadowColor: Colors.blueAccent,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey,width: 0.3),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(

                          children: [

                            Column  (
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[

                                  const SizedBox(height: 5),

                                  ListTile(
                                    leading: Image.asset('assets/images/meeting.png',height: 40,),

                                    title: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child:  RichText(
                                          text: TextSpan(
                                            text: "Topic : ",
                                            style: DefaultTextStyle.of(context).style,
                                            children: <TextSpan>[
                                              const TextSpan(text: " : "),
                                              TextSpan(text: prv_meeting_list![index].topicOfMeeting),
                                            ],
                                          ),
                                        )
                                    ),

                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5),

                                          RichText(
                                            text: TextSpan(
                                              text: "Date : ",
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                const TextSpan(text: " : "),
                                                TextSpan(text: prv_meeting_list![index].dateOfMetting.toString()),
                                              ],
                                            ),
                                          ),



                                          SizedBox(height: 10),


                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                ]),
                          ],
                        )),
                  );
                }),
          ),
      )
    );
  }
}