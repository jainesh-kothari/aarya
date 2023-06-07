import 'package:arya/model/child_vaccination_gs.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../language/app_translations.dart';
import '../libary/api_service.dart';

class TikaVivaran extends StatefulWidget {

  String user_id;
  TikaVivaran(this.user_id);

  @override
  _TikaVivaranState createState() => _TikaVivaranState(this.user_id);
}

class _TikaVivaranState extends State<TikaVivaran> {

  String? user_id;
  _TikaVivaranState(this.user_id);

  late Future<List<VaccinationReference>?> _vaccination_list;
  late List<bool> _isChecked;
  AppConstants api = AppConstants();
  late int size =0;

  @override
  void initState() {
    super.initState();

    _vaccination_list = ApiService().getVaccinationList(user_id.toString());

    _vaccination_list.then((value) => {
    _isChecked = List<bool>.filled(value!.length, false)
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTranslations.of(context)!.text("tika_vivaran")),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<VaccinationReference>?>(
          future: _vaccination_list,
          builder: (context, snapshot) {

            print(snapshot.hasData);

            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if(!snapshot.hasData) {
              return const Center(child: Text("No Vaccination Found"));
            }

            return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index) {
                  var todo = snapshot.data?[index];
                  return CheckboxListTile(

                    title: Text(todo!.name.toString(),
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    value: _isChecked[index],
                    onChanged: (val) {
                      setState(
                            () {
                          _isChecked[index] = val!;
                        },
                      );
                    },
                  );;
                },
                separatorBuilder: (context,index) {
                  return Container();
                },
                itemCount: snapshot.data?.length ?? 0);
          },
        )


       /* ListView(
          children: [

            ListView.builder(
                itemCount: _texts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_texts[index],
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    value: _isChecked[index],
                    onChanged: (val) {
                      setState(
                            () {
                          _isChecked[index] = val!;
                        },
                      );
                    },
                  );
                }),

            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 15.0),
              child: Center(
                child: Text("Below is the guideline for vaccination of 6 Months - 3 Year children  ", style: TextStyle(
                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                )),
              ),
            ),

            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TimelineTile(



                      alignment: TimelineAlign.manual,
                      lineXY: 0.1,

                      indicatorStyle: IndicatorStyle(
                          width: 60, height: 60,
                          indicator: _IndicatorExample(number: index ==0 ? "9-12 Months" : "16-24 Months"),
                          drawGap: true),

                      beforeLineStyle: LineStyle(color: Color(AppConstants.GRAY_COLOR[4])),

                      endChild: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),

                            Text("Measeled Comntaing vaccination" , style: TextStyle(fontSize: 10)),
                            Text("Measeled vaccination" , style: TextStyle(fontSize: 10)),
                            Text("Comntaing vaccination" , style: TextStyle(fontSize: 10)),
                            Text("Measeled Comntaing vaccination" , style: TextStyle(fontSize: 10)),

                            SizedBox(height: 5),

                          ],
                        ),
                      ),
                    ),
                  );
                }),

          ],
        ),*/
      ),
    );
  }
}


class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
      child: Center(
        child: Text(number, textAlign : TextAlign.center,style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

