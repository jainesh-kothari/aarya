import 'package:arya/model/self_help_group_metting_list_gs.dart';
import 'package:arya/selfhelpgroup/details_of_lady_club.dart';
import 'package:arya/selfhelpgroup/previous_meeting_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../libary/api_service.dart';
import '../util/appcontants.dart';
import 'add_meeting_self_help_group.dart';

class MeetingListView extends StatefulWidget {

  String? groupId;
  MeetingListView(this.groupId);

  @override
  _MeetingListViewState createState() => _MeetingListViewState(this.groupId);
}

class _MeetingListViewState extends State<MeetingListView> {

  String? groupId;
  _MeetingListViewState(this.groupId);

  AppConstants api = AppConstants();

  late Future<SelfHelpGroupMeetingGS?> selfhelpGroup;
  List<SelfMemberDetails>? _member_list = [];
  List<SelfHelpGroupMeeting> selfHelpGroupMeeting = [];
  List<SelfHelpGroupMeeting> pendingMeeting = [];
  int list_size = 0;

  _getData() async {

    setState(() {

      _member_list!.clear();
      selfHelpGroupMeeting.clear();
      pendingMeeting.clear();

      selfhelpGroup = ApiService().getSelfHelpGroupMeetingData(groupId.toString());
      selfhelpGroup.then((value) => {
            _member_list = value!.data!.memberDetails,
            list_size = value!.data!.selfHelpGroupMeeting!.length,
            selfHelpGroupMeeting = value!.data!.selfHelpGroupMeeting!,
            for (int i = 0; i < selfHelpGroupMeeting!.length; i++) {
                if (selfHelpGroupMeeting![i].memberDetails!.isEmpty)
                  {pendingMeeting.add(selfHelpGroupMeeting![i])}
              },

            list_size = pendingMeeting!.length
          });
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
        title: Text("Meetings"),
        centerTitle: true,
      ),

      body: SafeArea(
          child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                alignment: Alignment.topRight,
                  child: ElevatedButton(
                      child: const Text('Previous Meeting'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () async {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousMeetingListView(selfHelpGroupMeeting)));

                      },
                    )),
              ),

                Expanded(
                  child: FutureBuilder<SelfHelpGroupMeetingGS?>(
                    future: selfhelpGroup,
                    builder: (context, snapshot) {

                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child:  CircularProgressIndicator());
                      }

                      if(!snapshot.hasData) {
                        return Center(child: Text("No Meeting Found"));
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context,index) {

                              int itemCount = list_size ?? 0;
                              int reversedIndex = itemCount - 1 - index;
                              var todo = pendingMeeting[reversedIndex];

                              return InkWell(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LadiesGroupDetails(todo!.id, _member_list,
                                      todo!.topicOfMeeting, todo!.dateOfMetting))).then((value) => {
                                    _getData()
                                  });
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
                                                          TextSpan(text: pendingMeeting![reversedIndex].topicOfMeeting),
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
                                                            TextSpan(text: pendingMeeting[reversedIndex].dateOfMetting.toString()),
                                                          ],
                                                        ),
                                                      ),



                                                      SizedBox(height: 10),


                                                    ],
                                                  ),
                                                ),

                                                trailing: IconButton(
                                                  icon: Icon(
                                                      Icons.delete_forever_outlined,
                                                      color: Colors.black,
                                                      size: 30
                                                  ),
                                                  onPressed: () {
                                                    _showAlertDialog(context, todo!.id.toString());
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                            ]),
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder: (context,index) {
                              return Container();
                            },
                            itemCount: list_size),
                      );
                    },
                  ),
                ),
              ])),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSelfHelpGroupMeeting(groupId))).then((value) => {
          _getData()
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context, String id) async   {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Delete Club'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this Meeting ?'),
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

                ApiService().deleteSelfHelpGroupMeeting(id);
                _getData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}