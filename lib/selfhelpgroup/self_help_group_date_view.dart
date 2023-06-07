import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../language/app_translations.dart';
import '../util/appcontants.dart';
import 'add_self_help_group.dart';
import 'details_of_lady_club.dart';

class ListViewBuilder extends StatelessWidget {

  List date_list = ["2-05-2023","5-05-2023","10-05-2023"];

  AppConstants api = AppConstants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: api.gradient(),
          ),
        ),
        title: Text("Meetings"),
        centerTitle: true,
      ),

      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LadiesGroupDetails("")));
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
                              leading: Image.asset('assets/images/self_help_group.png',height: 40,),

                              title: Text("${date_list[index]}"),

                              trailing: IconButton(
                                icon: Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.black,
                                    size: 30
                                ),
                                onPressed: () {
                                  _showAlertDialog(context);
                                },
                              ),


                            ),
                            SizedBox(height: 2),
                          ]),
                    ],
                  )),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => LadiesGroupDetails("")));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async   {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Delete Club'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this club?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}