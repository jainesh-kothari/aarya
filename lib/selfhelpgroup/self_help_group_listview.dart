import 'package:arya/selfhelpgroup/add_self_help_group.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/self_help_group_list_view.dart';
import 'package:arya/selfhelpgroup/edit_self_help_group.dart';
import 'package:arya/selfhelpgroup/meeting_listview.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class LadiesSelfHelpListview extends StatefulWidget {
  @override
  _LadiesSelfHelpListviewState createState() => _LadiesSelfHelpListviewState();
}

class _LadiesSelfHelpListviewState extends State<LadiesSelfHelpListview> {

  AppConstants api = AppConstants();

  late Future<List<SelfHelpGroupListViewModelData>?> _club_list;
  List<SelfHelpGroupListViewModelData>? list = [];

  int list_size = 0;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  getDetails() async {
    _club_list = ApiService().getSelfHelpGroupListViewModel();
     list = await _club_list;
     setState(() {
       list_size = list!.length;
     });
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
        title: Text("Self Help Group"),
        centerTitle: true,
      ),

      body: SafeArea(
          child: Column(
              children: [


                Expanded(
                  child: FutureBuilder<List<SelfHelpGroupListViewModelData>?>(
                    future: _club_list,
                    builder: (context, snapshot) {

                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child:  CircularProgressIndicator());
                      }

                      if(!snapshot.hasData) {
                        return Center(child: Text("No Data Found"));
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context,index) {

                              var todo = snapshot.data?[index];
                              return InkWell(
                                onTap: () {
                                 // Navigator.push(context, MaterialPageRoute(builder: (context) => LadiesGroupDetails(todo?.id)));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingListView(todo?.id)));
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
                                                leading: Image.asset('assets/images/self_help_group.png',height: 40,),

                                                title: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child:  RichText(
                                                      text: TextSpan(
                                                        text: AppTranslations.of(context)!.text("name"),
                                                        style: DefaultTextStyle.of(context).style,
                                                        children: <TextSpan>[
                                                          const TextSpan(text: " : "),
                                                          TextSpan(text: todo?.ladyClubName),
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
                                                            TextSpan(text: todo?.joiningClubDate.toString()),
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

      floatingActionButton: _getFAB(),
    );
  }

  Widget _getFAB() {
    if (list_size == 0) {
      return FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddSelfHelpGroup()));
          });
    } else {
      return FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditSelfHelpGroup(list![0].id.toString())));
          });
    }
  }
}
