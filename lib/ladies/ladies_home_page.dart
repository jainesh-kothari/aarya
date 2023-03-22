import 'package:arya/language/app_translations.dart';
import 'package:arya/registration/list_view.dart';
import 'package:arya/start_up/change_language.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LadiesHomePage extends StatefulWidget {
  @override
  _LadiesHomePageState createState() => new _LadiesHomePageState();
}

class _LadiesHomePageState extends State<LadiesHomePage> {

 late DateTime currentBackPressTime;
 AppConstants api = new AppConstants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppConstants.GRAY_COLOR[4]),
      appBar: AppBar(
        title: Text(AppTranslations.of(context)!.text("app_name")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
              gradient: api.gradient(),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                        height: 170,
                        child: Card(
                            color: Color(AppConstants.GRAY_COLOR[4]),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey,width: 0.3,),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserListview(0)));
                              },
                              child: Column(

                                children: [

                                  Center(

                                    child: Container(

                                        decoration: BoxDecoration(
                                            gradient: api.gradient(),
                                            borderRadius: BorderRadius.circular(45.0)),

                                        child: Image.asset(
                                            'assets/images/w1.jpg',
                                            height: 130,
                                            width: 300,
                                            fit:BoxFit.fill

                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(AppTranslations.of(context)!.text("pargent_lady"), style: TextStyle(
                                        fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                    )),
                                  )


                                ],
                              ),
                            )),
                      )

                  ),

                  Expanded(
                      child: Container(
                        height: 170,
                        child: Card(
                            color: Color(AppConstants.GRAY_COLOR[4]),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey,width: 0.3,),
                                borderRadius: BorderRadius.circular(15.0)),

                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserListview(0)));
                              },
                              child: Column(

                                children: [

                                  Center(
                                    child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0)),
                                        child: Image.asset('assets/images/ch1.png',height: 130, width: 300,fit:BoxFit.cover)),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(AppTranslations.of(context)!.text("children"), style: TextStyle(
                                        fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                    )),
                                  )


                                ],
                              ),
                            )),
                      )

                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                        height: 170,
                        child: Card(
                            color: Color(AppConstants.GRAY_COLOR[4]),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey,width: 0.3,),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserListview(0)));
                              },
                              child: Column(

                                children: [

                                  Center(

                                    child: Container(

                                        decoration: BoxDecoration(
                                            gradient: api.gradient(),
                                            borderRadius: BorderRadius.circular(45.0)),

                                        child: Image.asset(
                                            'assets/images/w1.jpg',
                                            height: 130,
                                            width: 300,
                                            fit:BoxFit.fill

                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(AppTranslations.of(context)!.text("pargent_lady"), style: TextStyle(
                                        fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                    )),
                                  )


                                ],
                              ),
                            )),
                      )

                  ),

                  Expanded(
                      child: Container(
                        height: 170,
                        child: Card(
                            color: Color(AppConstants.GRAY_COLOR[4]),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey,width: 0.3,),
                                borderRadius: BorderRadius.circular(15.0)),

                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserListview(0)));
                              },
                              child: Column(

                                children: [

                                  Center(
                                    child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0)),
                                        child: Image.asset('assets/images/ch1.png',height: 130, width: 300,fit:BoxFit.cover)),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(AppTranslations.of(context)!.text("children"), style: TextStyle(
                                        fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                                    )),
                                  )


                                ],
                              ),
                            )),
                      )

                  ),
                ],
              ),


            ],
          ),


        )),
    );
  }
}