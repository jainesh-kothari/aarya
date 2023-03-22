
import 'package:arya/children/add_new_children.dart';
import 'package:arya/children/growth_monitaring.dart';
import 'package:arya/children/nutrition_class.dart';
import 'package:arya/children/tika_vavaran.dart';
import 'package:arya/children/update_child_data.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/get_child_gs.dart';

class ChildrenListView extends StatefulWidget {

  @override
  _ChildrenListViewState createState() => new _ChildrenListViewState();
}

class _ChildrenListViewState extends State<ChildrenListView> {

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

                  print(snapshot.hasData);

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if(!snapshot.hasData) {
                    return const Center(child: Text("No Child Found"));
                  }

                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        int itemCount = snapshot.data?.length ?? 0;
                        int reversedIndex = itemCount - 1 - index;
                        var todo = snapshot.data?[reversedIndex];

                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateChildren(todo?.id)));
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
                                          leading:
                                          ImageIcon(
                                            NetworkImage("https://static.thenounproject.com/png/1981721-200.png"),
                                            color: Colors.black,size: 35,
                                          ),
                                          title: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child:  RichText(
                                                text: TextSpan(
                                                  text: AppTranslations.of(context)!.text("name"),
                                                  style: DefaultTextStyle.of(context).style,
                                                  children: <TextSpan>[
                                                    const TextSpan(text: " : "),
                                                    TextSpan(text: todo?.name),
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
                                              showBottomSheetOnClick(context, todo!.name, todo!.fatherName,  todo!.id, todo!.mobileNumber.toString());
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
                                                    text: AppTranslations.of(context)!.text("age"),
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[

                                                      const TextSpan(text: " : "),
                                                      TextSpan(text: todo?.age!.totalMonths.toString()),
                                                      TextSpan(text: ' Month'),
                                                    ],
                                                  ),
                                                ),



                                                SizedBox(height: 10),


                                                RichText(
                                                  text: TextSpan(
                                                    text: AppTranslations.of(context)!.text("gender"),
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      const TextSpan(text: " : "),
                                                      TextSpan(text: todo?.gender),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                      ]),

                                  Positioned(
                                    right:0,
                                    bottom:0,
                                    child: Container(
                                      width: 60,
                                      color: todo!.isVerified != true ?  Colors.green : Colors.red,
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text("  Verified", style: TextStyle(
                                            fontSize: 12,color: Colors.white
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context,index) {
                        return Container();
                      },
                      itemCount: snapshot.data?.length ?? 0);
                },
              ),
            ),
          ])),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AddNewChildren()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  showBottomSheetOnClick(BuildContext context, String? name, String? fatherName, String? id, String? number) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                SizedBox(height: 40),

                Center(child: Text("$name S/o $fatherName",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black))),

                SizedBox(height: 5),

                Center(child: Text("$number",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.black))),

                SizedBox(height: 5),

                Divider(color: Colors.grey),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 40,
                    child: TextButton.icon(

                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateChildren(id)));
                      },
                      icon: Icon(
                        Icons.person,color: Colors.black,
                        size: 25.0,
                      ),
                      label: Text(AppTranslations.of(context)!.text ("profile_update"),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 40,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => GrowthMonitoring("")));
                      },
                      icon: Icon(
                        Icons.stacked_line_chart,color: Colors.black,
                        size: 22.0,
                      ),
                      label: Text(AppTranslations.of(context)!.text ("growth_monitaring"),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 40,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NutritionProcess()));
                      },
                      icon: Icon(
                        Icons.info, color: Colors.black,
                        size: 22.0,
                      ),
                      label: Text(AppTranslations.of(context)!.text ("vikas_and_poshan_sambadhi"),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black)),
                    ),
                  ),
                ),

                SizedBox(height: 5),


                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 40,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TikaVivaran()));
                      },
                      icon: Icon(
                        Icons.vaccines,color: Colors.black,
                        size: 22.0,
                      ),
                      label: Text(AppTranslations.of(context)!.text ("tika_vivaran"),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

}