
import 'package:arya/children/update_child_data.dart';
import 'package:arya/model/particular_child_data_gs.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../libary/api_service.dart';
import '../model/caste_category.dart';


class ViewChildrenData extends StatefulWidget {

  String? userId;
  ViewChildrenData(this.userId);

  @override
  _ViewChildrenDataState createState() => new _ViewChildrenDataState(userId);
}


class _ViewChildrenDataState extends State<ViewChildrenData> {

  String? userId;
  _ViewChildrenDataState(this.userId);

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = AppConstants();

  final format = DateFormat("dd-MM-yyyy");
  List<CastCategoryData> list=[];
  late Future<List<CastCategoryData>?> _category_list;

  String name ="";
  String aadhar_card="";
  String number="";
  String mother_aadhar_card="";
  String fatherName="";
  String motherName="";
  String dob="";
  String father_occ="";
  String _chosenCategoryName ="";
  String gender = "";
  String _chosenCaste = "";

  String minority = "";
  String? mother_associate;

  String? do_have_aadhar = "No";

  bool visible = true;

  late SingleChildData? _childData;

  _getDetails() async {

    _childData = await ApiService().getSingleChildDetails(userId);

    _category_list = ApiService().getCategory();
    list = (await _category_list)!;

    String date = _childData!.data!.dOB.toString().toString().substring(0,10);
    var data = format.format(DateTime.parse(date));
    dob = data.toString();

    setState(() {

      name = _childData!.data!.name.toString();
      aadhar_card = _childData!.data!.aadhar.toString();
      mother_aadhar_card = _childData!.data!.motherAdhar.toString();
      motherName = _childData!.data!.motherName.toString();
      fatherName = _childData!.data!.fatherName.toString();
      number = _childData!.data!.mobileNumber.toString();
      gender = _childData!.data!.gender.toString();
      father_occ = _childData!.data!.fatherOccupation.toString();
      _chosenCaste = _childData!.data!.cast.toString();

      if(_childData!.data!.hasAadhar == true) {
        do_have_aadhar = "Yes";
      } else {
        do_have_aadhar = "No";
      }

      if(_childData!.data!.isReligiousMinority == true) {
        minority = "Yes";
      } else {
        minority = "No";
      }



      for (var i = 0; i < list.length; i++) {

        if(list[i].id.toString() == _childData!.data!.categoryId.toString()) {
          _chosenCategoryName = list[i].name.toString();
        }
      }

    });


    setState(()  {
      visible =false;
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

                               Text("Gender : ",style: style2),

                               Text("$gender",style: style1)

                             ],
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Text("Mother Aadhar Number : ",style: style2),

                               Text("$mother_aadhar_card",style: style1)

                             ],
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Text("Father Name : ",style: style2),

                               Text("$fatherName",style: style1)

                             ],
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Text("Mother Name : ",style: style2),

                               Text("$motherName",style: style1)

                             ],
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Text("Father Occupation : ",style: style2),

                               Text("$father_occ",style: style1)

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

                       ],



                      ),
                    ),
                  )),


              visible ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Container()

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateChildren(userId)));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),


    );
  }
}