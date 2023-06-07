import 'package:arya/selfhelpgroup/details_of_lady_club.dart';
import 'package:arya/selfhelpgroup/add_self_help_group.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/self_help_group_list_view.dart';
import 'package:arya/selfhelpgroup/self_help_group_date_view.dart';
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

  @override
  void initState() {
    super.initState();
    _club_list = ApiService().getSelfHelpGroupListViewModel();
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewBuilder()));
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
                            itemCount: snapshot.data!.length),
                      );
                    },
                  ),
                ),
              ])),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddSelfHelpGroup()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Delete Club'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this club?'),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
