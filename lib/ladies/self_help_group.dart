
import 'dart:io';
import 'package:arya/language/app_translations.dart';
import 'package:arya/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../libary/api_service.dart';
import '../libary/expansion_tile.dart';
import '../libary/util.dart';
import '../model/caste_category.dart';
import '../model/category_of_cast.dart';
import '../model/login_gs.dart';

class SelfHelpGroup extends StatefulWidget {
  @override
  _SelfHelpGroupState createState() => new _SelfHelpGroupState();
}


class _SelfHelpGroupState extends State<SelfHelpGroup> {

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);
  AppConstants api = new AppConstants();
  final format = DateFormat("dd-MM-yyyy");

  List<Widget> _cardList = [];

  bool _expanded = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  bool _expanded4 = false;


  Widget _card() {
    return Card(
      child: Column(
        children: [



          Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text("Designation", style: style)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              isExpanded: true,
              focusColor:Colors.white,
              // value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor:Colors.black,
              items: <String>[
                '1',
                '2',
                '3',
                '4',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style:TextStyle(color:Colors.black),),
                );
              }).toList(),
              hint:Text("Select the topic",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (String? value) {
                setState(() {
                  // _chosenValue = value;
                });
              },
            ),
          ),


          Padding(
              padding: EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text("Name", style: style)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // controller: name_controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 8.0),
            child: Text("Mobile Number", style: style),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // co//ntroller: aadhar_controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _cardList.add(_card());
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(AppConstants.BLUE_COLOR[0])));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppConstants.BLUE_COLOR[0]),
        title: Text("Self Help Group"),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text("Lady Club Name", style: style)),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                          ),
                        ),
                      ),

                       Padding(
                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                        child: Text("Date of adding Lady club ", style: TextStyle(
                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:5.0,left: 8.0,right: 10,bottom:8),
                        child: DateTimeField(
                          format: format,
                         // controller: dob_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
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
                                lastDate: DateTime(2100));
                            return picked;
                          },
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: 8.0,top: 8.0),
                          child: Text("Details of Members", style: style)),


                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                title: (const Text(
                                  '1. President',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                                trailing: IconButton(
                                    icon: _expanded
                                        ? Icon(Icons.expand_less)
                                        : Icon(Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded = !_expanded;
                                      });
                                    }),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),

                                height: _expanded
                                    ? 400
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  children: <Widget>[

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Designation", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        isExpanded: true,
                                        focusColor:Colors.white,
                                        // value: _chosenValue,
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.white),
                                        iconEnabledColor:Colors.black,
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style:TextStyle(color:Colors.black),),
                                          );
                                        }).toList(),
                                        hint:Text("Select the topic",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            // _chosenValue = value;
                                          });
                                        },
                                      ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Name", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // controller: name_controller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                      child: Text("Mobile Number", style: style),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // co//ntroller: aadhar_controller,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                title: (const Text(
                                  '2. Mentor',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                                trailing: IconButton(
                                    icon: _expanded2
                                        ? Icon(Icons.expand_less)
                                        : Icon(Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded2 = !_expanded2;
                                      });
                                    }),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),

                                height: _expanded2
                                    ? 400
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  children: <Widget>[

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Designation", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        isExpanded: true,
                                        focusColor:Colors.white,
                                        // value: _chosenValue,
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.white),
                                        iconEnabledColor:Colors.black,
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style:TextStyle(color:Colors.black),),
                                          );
                                        }).toList(),
                                        hint:Text("Select the topic",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            // _chosenValue = value;
                                          });
                                        },
                                      ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Name", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // controller: name_controller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                      child: Text("Mobile Number", style: style),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // co//ntroller: aadhar_controller,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                title: (const Text(
                                  '3. Member secretary',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                                trailing: IconButton(
                                    icon: _expanded3
                                        ? Icon(Icons.expand_less)
                                        : Icon(Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded3 = !_expanded3;
                                      });
                                    }),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),

                                height: _expanded3
                                    ? 400
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  children: <Widget>[

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Designation", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        isExpanded: true,
                                        focusColor:Colors.white,
                                        // value: _chosenValue,
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.white),
                                        iconEnabledColor:Colors.black,
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                        ].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,style:TextStyle(color:Colors.black),),
                                          );
                                        }).toList(),
                                        hint:Text("Select the topic",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            // _chosenValue = value;
                                          });
                                        },
                                      ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.only(left: 8.0,top: 8.0),
                                        child: Text("Name", style: style)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // controller: name_controller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                      child: Text("Mobile Number", style: style),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        // co//ntroller: aadhar_controller,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Color(AppConstants.GRAY_COLOR[1]))
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),


                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                title: (const Text(
                                  '4. Member',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                                trailing: IconButton(
                                    icon: _expanded4
                                        ? Icon(Icons.expand_less)
                                        : Icon(Icons.expand_more),
                                    onPressed: () {
                                      setState(() {
                                        _expanded4 = !_expanded4;
                                      });
                                    }),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),

                                height: _expanded4
                                    ? MediaQuery.of(context).size.height
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: _cardList.length,
                                      itemBuilder: (context, index) {
                                        return _cardList[index];
                                      },
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.only(left:80.0,right: 80,top: 20,bottom: 20),
                                      child: ElevatedButton(
                                        child: Text('Add New Member'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _cardList.add(_card());
                                          });
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 50),

                       Center(
                         child: SizedBox(
                          width: 200.0,
                          child: ElevatedButton(
                            child: Text('Save'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed:() {

                            },
                          ),
                      ),
                       ),



                    ],)),


            ],
          ),
        ),
      ),
    );
  }

}