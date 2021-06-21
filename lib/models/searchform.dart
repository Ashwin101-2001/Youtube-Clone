
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ytube_search/services/Databasehelper.dart';
import 'package:ytube_search/utilities/functions.dart';

import '../Search.dart';
import '../home.dart';
import 'Curl.dart';

class MyCustomForm extends StatefulWidget {
  String voiceSearch;
  MyCustomForm({this.voiceSearch});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(voiceSearch: voiceSearch);
  }
}


class MyCustomFormState extends State<MyCustomForm> {
  String voiceSearch;

  MyCustomFormState({this.voiceSearch});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController scontroller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();
  AutoCompleteTextField searchTextField;
  SharedPreferences myPrefs;
  DatabaseHelper dbh;
  Database db;

  List<String> slist;
  List<Curl> clist;
  bool loading = true;


  bool nothing;

  @override
  void initState() {
    // TODO: implement initState
    print("vs:$voiceSearch");
    slist= List<String>();
    scontroller.text = voiceSearch;
    super.initState();
    init();
  }

  void init() async
  {
    //myPrefs = await SharedPreferences.getInstance();
    dbh = DatabaseHelper();
    db = await dbh.database;
    clist = await dbh.getcurlList();
    setSlist();


    print('init comp');

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('sdispose');
  }


  @override
  Widget build(BuildContext context) {
    print('build form');

      return Form(

        key: _formKey,
        child: loading
            ? CircularProgressIndicator()
            : searchTextField = AutoCompleteTextField<String>(
          controller: scontroller,
          suggestions: slist,
          clearOnSubmit: true,
          key: key1,


          textSubmitted: (item) async
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Search(item, 'search',)),
            );
          },


          itemFilter: (item, query) {
            return item
                .toLowerCase()
                .startsWith(query.toLowerCase());
          },
          //needs editing

          itemSorter: (a, b) {
            return a.compareTo(b);
          },

          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),


          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: () {
                setState(() {
                  scontroller.text = " ";
                });
              },
            ),


            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent, width: 2.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.7),
            ),
            hintText: '  Search youtube',
            hintStyle: TextStyle(color: Colors.black,),


            // labelText: '   Search youtube',
            // labelStyle: TextStyle(color:Colors.white)
          ),

          itemBuilder: (context, item) {
            print(' item builder ');
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search(item, 'search',)),
                );
              },

              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    border: Border.all(color: Colors.blueAccent, width: 2.0)
                ),
                //
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(

                  children: [
                    Expanded(flex: 1,
                        child: Icon(Icons.search, color: Colors.blue[800],)),
                    Expanded(flex: 1,
                      child: Container(),),
                    Expanded(flex: 10,
                        child: Text(item, style: TextStyle(
                            color: Colors.pink[800],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),)),

                    Expanded(flex: 2,
                        child: FlatButton(
                            onPressed: () async {
                              await deleteQuery(item);
                              Navigator.pushReplacementNamed(context, 'home');
                            },
                            child: Icon(Icons.delete, color: Colors.black,))),
                    Expanded(flex: 2,
                      child: Container(),),

                  ],
                ),
              ),
            );
          },

          /* validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              search =value;

              return null;
            },*/

        ),


      );


      }
    // Build a Form widget using the _formKey created above.
  void setSlist()
  {

    for(Curl c in clist)
    {
      for(String s in  c.searches.split("||"))
      { if(!slist.contains(s))
        slist.add(s);
      }

    }



  }


  void deleteQuery(String item)
  { for(Curl c in clist)
  { if(c.searches.contains(item))
  { if(c.searches.length==item.length)
    dbh.deleteCurl(c.id);  // only this search
  else {
    if (c.searches.startsWith(item)) {
      c.searches = c.searches.substring(item.length + 2);
      dbh.insertCurl(c);
    } else {
      int i = c.searches.indexOf(item);
      c.searches = c.searches.substring(i - 2, item.length + i);
      dbh.insertCurl(c);
    }
  }
  }





  }





  }
  }





