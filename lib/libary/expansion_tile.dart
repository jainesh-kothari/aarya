import 'package:arya/util/appcontants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemExpandedTile extends StatelessWidget {

  TextStyle style = const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

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
    );
  }
}