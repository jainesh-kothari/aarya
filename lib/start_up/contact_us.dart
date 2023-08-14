import 'package:arya/language/app_translations.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => new _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  AppConstants api = AppConstants();

  @override
  void initState() {
    super.initState();
  }


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
            child: Center(
              child: Column(
                children: [

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Mission ARYA", style: TextStyle(
                          fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("NODAL OFFICER:", style: TextStyle(
                          fontSize:16, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("DR. DHARAMVEER D.D. ICDS DAUSA", style: TextStyle(
                          fontSize:12, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("OFFICE OF DEPUITY DIRECTOR ,", style: TextStyle(
                        fontSize:12, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("INTEGRATED CHILD DEVELOPMENT SERVICES NEAR CMHO", style: TextStyle(
                        fontSize:12, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("OFFICE, DAUSA -303303", style: TextStyle(
                        fontSize:12, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Phone: +91 7597648847", style: TextStyle(
                        fontSize:15, color: Colors.black,
                      )),
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Email: missionarya.dausa@gmail.com", style: TextStyle(
                        fontSize:15, color: Colors.black,
                      )),
                    ),
                  ),

                ],
              ),
            ),
          )),
    );
  }
}