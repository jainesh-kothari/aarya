
import 'package:arya/children/tika_vavaran.dart';
import 'package:arya/ladies/add_new_lady.dart';
import 'package:arya/ladies/lady_nutrition_process.dart';
import 'package:arya/ladies/lady_vaccination.dart';
import 'package:arya/ladies/suckle_lady.dart';
import 'package:arya/ladies/update_lady_profile.dart';
import 'package:arya/language/app_translations.dart';
import 'package:arya/libary/api_service.dart';
import 'package:arya/model/ladies_list_model.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../model/get_child_gs.dart';
import 'ladiesviewdata.dart';

class LadiesListview extends StatefulWidget {
  String id;
  bool flag;
  LadiesListview(this.id, this.flag);

  @override
  _LadiesListviewState createState() => new _LadiesListviewState(this.id, this.flag);
}

class _LadiesListviewState extends State<LadiesListview> {

  String refid;
  bool flag;
  _LadiesListviewState(this.refid,this.flag);

  AppConstants api = AppConstants();

  late Future<List<LadiesListviewModelData>?> _women_list;


  @override
  void initState() {
    super.initState();
    _women_list = ApiService().getWomenList(refid);
    print(refid);
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

            Expanded(
              child: FutureBuilder<List<LadiesListviewModelData>?>(
                future: _women_list,
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if(!snapshot.hasData) {
                    return const Center(child: Text("No Ladies Found"));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          int itemCount = snapshot.data?.length ?? 0;
                          int reversedIndex = itemCount - 1 - index;
                          var todo = snapshot.data?[reversedIndex];

                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewLadiesData(todo, refid)));
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
                                            leading: Image.asset('assets/images/lady_iocn.png',height: 40,),

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
                                                //showBottomSheetOnClick(context, todo!.name, todo!.husbandName,  todo!.id, todo!.mobileNumber.toString());
                                                showBottomSheetOnClick(context, todo!, refid);
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
                                                      text: AppTranslations.of(context)!.text("mobile_number"),
                                                      style: DefaultTextStyle.of(context).style,
                                                      children: <TextSpan>[
                                                        const TextSpan(text: " : "),
                                                        TextSpan(text: todo?.mobileNumber.toString()),
                                                      ],
                                                    ),
                                                  ),



                                                  SizedBox(height: 10),


                                                  RichText(
                                                    text: TextSpan(
                                                      text: AppTranslations.of(context)!.text("svastha_id"),
                                                      style: DefaultTextStyle.of(context).style,
                                                      children: <TextSpan>[
                                                        const TextSpan(text: " : "),
                                                        TextSpan(text: todo?.svasthaId),
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
                                        color: Colors.green,
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
                        itemCount: snapshot.data?.length ?? 0),
                  );
              },
              ),
            ),
          ])),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => AddNewladies(refid)));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }


  showBottomSheetOnClick(BuildContext context, LadiesListviewModelData todo, String refid) {

    String name = todo!.name.toString();
    String husbandName = todo!.husbandName.toString();
    String mobileNumber = todo!.mobileNumber.toString();

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

                Center(child: Text("$name S/o $husbandName",style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black))),

                SizedBox(height: 5),

                Center(child: Text("$mobileNumber", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.black))),

                SizedBox(height: 5),

                Divider(color: Colors.grey),

                Padding(
                  padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                  child: SizedBox(
                    height: 40,
                    child: TextButton.icon(

                      onPressed: () {
                        Navigator.pop(context);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNewladies(todo, refid))).then((_) {
                          setState(() {
                            _women_list = ApiService().getWomenList(refid);
                          });
                        });
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

                Visibility(
                  visible: flag,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13.0, top: 3.0),
                    child: SizedBox(
                      height: 40,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SuckleLady(todo.id)));
                        },
                        icon: const Icon(
                          Icons.stacked_line_chart,color: Colors.black,
                          size: 22.0,
                        ),
                        label: Text(AppTranslations.of(context)!.text ("stanpan_karne_wali_ma"),
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.black)),
                      ),
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadyNutritionProcess(todo.id.toString())));
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LadyVaccination(todo.id.toString())));
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
