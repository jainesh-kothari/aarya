
import 'package:arya/children/update_child_data.dart';
import 'package:arya/ladies/update_lady_profile.dart';
import 'package:arya/model/ladies_list_model.dart';
import 'package:arya/model/particular_child_data_gs.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../libary/api_service.dart';
import '../model/caste_category.dart';


class ViewLadiesData extends StatefulWidget {

  LadiesListviewModelData? user_details;
  String refid;
  ViewLadiesData(this.user_details, this.refid);

  @override
  _ViewLadiesDataState createState() => new _ViewLadiesDataState(user_details,refid);
}


class _ViewLadiesDataState extends State<ViewLadiesData> {

  LadiesListviewModelData? user_details;
  String refid;
  _ViewLadiesDataState(this.user_details, this.refid);

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  final format = DateFormat("dd-MM-yyyy");
  List<CastCategoryData> list=[];
  late Future<List<CastCategoryData>?> _category_list;

  String name ="";
  String aadhar_card="";
  String number="";
  String husband_name="";
  String swasthId="";
  String maritalStatus="";
  String lastMenstrulPeriod="";
  String dob="";

  String _chosenCategoryName ="";
  String _chosenCaste = "";

  String minority = "";

  String? first_pregnancy;
  String? pregnant;
  String? miscarriage;
  String? decceased;

  _getDetails() async {

    setState(() {

      lastMenstrulPeriod = user_details!.lastMenstrulPeriod.toString();
      _chosenCaste = user_details!.cast.toString();
      // _chosenCategoryId = user_details!.categoryId.toString();

     /* String date = user_details!.dOB.toString().toString().substring(0,10);
      var data = format.format(DateTime.parse(date));
      dob = data.toString();*/

      maritalStatus = user_details!.maritalStatus.toString();

      bool? is_minority = user_details!.isReligiousMinority;
      bool? is_first_pregnancy = user_details!.isFirstPregnancy;
      bool? is_pregnant = user_details!.areYouPregnant;
      bool? is_misscarraiage = user_details!.isAbortionBefore;
      bool? isbanficary = user_details!.isBeneficiary;

      minority = is_minority == true ? "Yes" : "No";
      first_pregnancy = is_first_pregnancy == true ? "Yes" : "No";
      pregnant = is_pregnant == true ? "Yes" : "No";
      miscarriage = is_misscarraiage == true ? "Yes" : "No";
      decceased = isbanficary == true ? "Yes" : "No";

      name = user_details!.name.toString();
      aadhar_card = user_details!.aadhar.toString();
      husband_name = user_details!.husbandName.toString();
      swasthId = user_details!.svasthaId.toString();
      number = user_details!.mobileNumber.toString();

      if(user_details!.isReligiousMinority == true) {
        minority = "Yes";
      } else {
        minority = "No";
      }
    });

    _category_list = ApiService().getCategory();
    list = (await _category_list)!;


    setState(() {
      for (var i = 0; i < list.length; i++) {

        if(list[i].id.toString() == user_details!.categoryId.toString()) {
          _chosenCategoryName = list[i].name.toString();
        }
      }
    });


  }

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    TextStyle style1 = const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black);
    TextStyle style2 = const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppConstants.BLUE_COLOR[0]),
        title: Text("Profile"),
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
          child: Stack(
            children: [

              SingleChildScrollView(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Basic Profile ",style: style1),


                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Name : " , style: style2),

                                Text("$name" , style: style1),

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Date Of birth : ",style: style2),

                                Text("$dob" , style: style1),

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Aadhar Card : ",style: style2),

                                Text("$aadhar_card",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Husband / Father  : ",style: style2),

                                Text("$husband_name",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Swasth id : ",style: style2),

                                Text("$swasthId",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Mobile Number : ",style: style2),

                                Text("$number",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Marital Status : ",style: style2),

                                Text("$maritalStatus",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Last Menstrual Period : ",style: style2),

                                Text("$lastMenstrulPeriod",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Belong Minority : ",style: style2),

                                Text("$minority",style: style1)

                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Category Name : ",style: style2),

                                Text("$_chosenCategoryName",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Caste : ",style: style2),

                                Text("$_chosenCaste",style: style1)

                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("First Pregnancy : ",style: style2),

                                Text("$first_pregnancy",style: style1)

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("Are you Pregnant: ",style: style2),

                                Text("$pregnant",style: style1)

                              ],
                            ),
                          ),

                        ],



                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdateNewladies(user_details,refid)));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),


    );
  }
}