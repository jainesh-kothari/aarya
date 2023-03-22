import 'package:arya/util/appcontants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import '../language/app_translations.dart';

class SuckleLady extends StatefulWidget {
  @override
  _SuckleLadyState createState() => _SuckleLadyState();
}

class _SuckleLadyState extends State<SuckleLady> {

  final format = DateFormat("DD/MM/yyyy");
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;

  AppConstants api = new AppConstants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(AppTranslations.of(context)!.text("stanpan_karne_wali_ma")),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 8.0),
              child: Text(AppTranslations.of(context)!.text ("parsangic"), style: TextStyle(
                  fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
              )),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 12.0),
                      child: Text(AppTranslations.of(context)!.text ("do_garbhpat"), style: TextStyle(
                          fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
                      )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                      child: Text(AppTranslations.of(context)!.text ("grabhpat_20"), style: TextStyle(
                        fontSize: 13, color: Colors.grey,
                      )),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterSwitch(
                    value: status1,
                    activeColor: Colors.green,
                    width: 60.0,
                    height: 30.0,
                    onToggle: (val) {
                      setState(() {
                        status1 = val;
                      });
                    },
                  ),
                )
              ],
            ),

            Padding(
              padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Divider(color: Colors.grey[350]),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                      child: Text(AppTranslations.of(context)!.text ("do_garbhpat"), style: TextStyle(
                          fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
                      )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                      child: Text(AppTranslations.of(context)!.text ("grabhpat_after_20"), style: TextStyle(
                        fontSize: 13, color: Colors.grey,
                      )),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterSwitch(
                    value: status2,
                    activeColor: Colors.green,
                    width: 60.0,
                    height: 30.0,
                    onToggle: (val) {
                      setState(() {
                        status2 = val;
                      });
                    },
                  ),
                )
              ],
            ),



            Padding(
              padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Divider(color: Colors.grey[350]),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                  child: Text(AppTranslations.of(context)!.text ("mruthjanam"), style: TextStyle(
                      fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
                  )),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterSwitch(
                    value: status3,
                    activeColor: Colors.green,
                    width: 60.0,
                    height: 30.0,
                    onToggle: (val) {
                      setState(() {
                        status3 = val;
                      });
                    },
                  ),
                )
              ],
            ),

            Padding(
              padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Divider(color: Colors.grey[350]),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 8.0),
                  child: Text(AppTranslations.of(context)!.text ("garbhpat"), style: TextStyle(
                      fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
                  )),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterSwitch(
                    value: status4,
                    activeColor: Colors.green,
                    width: 60.0,
                    height: 30.0,
                    onToggle: (val) {
                      setState(() {
                        status4 = val;
                      });
                    },
                  ),
                )
              ],
            ),

            Padding(
              padding:  const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Divider(color: Colors.grey[350]),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 12.0,top: 8.0),
              child: Text(AppTranslations.of(context)!.text ("deliviery_date"), style: TextStyle(
                  fontSize: 16, color: Colors.black,fontWeight: FontWeight.bold
              )),
            ),

            Padding(
              padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
              child: DateTimeField(
                format: format,
                // controller: txt_date,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color:  Color(AppConstants.GRAY_COLOR[4]))
                  ),
                ),
                onShowPicker: (context, currentValue) async {
                  DateTime? picked = await showDatePicker(
                      context: context,
                      builder: (BuildContext? context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: Color(AppConstants.BLUE_COLOR[0]),
                              onPrimary: Colors.white,
                              surface: Color(AppConstants.BLUE_COLOR[0]),
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor:Colors.white,
                          ),
                          child: child!,
                        );
                      },
                      firstDate: DateTime(2000),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now());
                  return picked;
                },
              ),
            ),


            InkWell(
              onTap: () {

              },
              child: Padding(
                padding:
                const EdgeInsets.only(left: 40.0, right: 40),
                child: Container(
                  height: 50,
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
                      AppTranslations.of(context)!.text("visthapith"),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),



          ],



        ),
      ),
    );
  }


}