
import 'package:arya/children/add_new_children.dart';
import 'package:arya/children/growth_monitaring.dart';
import 'package:arya/children/nutrition_class.dart';
import 'package:arya/children/tika_vavaran.dart';
import 'package:arya/ladies/add_new_lady.dart';
import 'package:arya/ladies/lady_nutrition_process.dart';
import 'package:arya/ladies/self_help_group.dart';
import 'package:arya/ladies/suckle_lady.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/get_child_gs.dart';
import 'details_of_lady_club.dart';

class LadiesSelfHelpListview extends StatefulWidget {
  @override
  _LadiesSelfHelpListviewState createState() => _LadiesSelfHelpListviewState();
}

class _LadiesSelfHelpListviewState extends State<LadiesSelfHelpListview> {

  AppConstants api = AppConstants();

  late Future<List<ChildData>?> _child_list;


  @override
  void initState() {
    super.initState();
    _child_list = ApiService().getChildList();
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
          child: Column(children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  labelText: "Search...",
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<ChildData>?>(
                future: _child_list,
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if(!snapshot.hasData) {
                    return const Center(child: Text("No Child Found"));
                  }

                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        int itemCount = 2;
                        int reversedIndex = index;
                        var todo = snapshot.data?[reversedIndex];

                        return InkWell(
                          onTap: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                            child: Card(
                                elevation: 8,
                                shadowColor: Colors.blueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey,width: 0.3),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(

                                    children: [

                                      Column  (
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[

                                            const SizedBox(height: 5),

                                            ListTile(
                                              leading:
                                              ImageIcon(
                                                NetworkImage("https://static.thenounproject.com/png/803996-200.png"),
                                                color: Colors.black,size: 35,
                                              ),
                                              title: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child:  RichText(
                                                    text: TextSpan(
                                                      text: "Club Name",
                                                      style: DefaultTextStyle.of(context).style,
                                                      children: <TextSpan>[
                                                        const TextSpan(text: " : XYZ"),
                                                      ],
                                                    ),
                                                  )
                                              ),

                                              trailing: IconButton(
                                                icon: Icon(
                                                  Icons.more_vert_rounded,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  showBottomSheetOnClick(context);
                                                },
                                              ),

                                              subtitle: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5),

                                                    RichText(
                                                      text: TextSpan(
                                                        text: "Date",
                                                        style: DefaultTextStyle.of(context).style,
                                                        children: <TextSpan>[
                                                          const TextSpan(text: " : 22-02-2022 "),

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
                                  ),
                                )),
                          ),
                        );
                      },
                      separatorBuilder: (context,index) {
                        return Container();
                      },
                      itemCount: 2);
                },
              ),
            ),
          ])),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SelfHelpGroup()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  showBottomSheetOnClick(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                SizedBox(height: 40),

                Center(child: Text("Club Name",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black))),

                SizedBox(height: 5),

                Center(child: Text("Date : 2-July-2022",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.black))),

                SizedBox(height: 10),

                Divider(color: Colors.grey),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 30,
                    child: TextButton.icon(

                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SelfHelpGroup()));

                      },
                      icon: Icon(
                        Icons.person,color: Colors.black,
                        size: 25.0,
                      ),
                      label: Text(AppTranslations.of(context)!.text ("profile_update"),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 30,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadiesGroupDetails()));
                      },
                      icon: Icon(
                        Icons.stacked_line_chart,color: Colors.black,
                        size: 22.0,
                      ),
                      label: Text("Details of the monthly meeting of the women's club",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 10),

              ],
            ),
          );
        });
  }

}
