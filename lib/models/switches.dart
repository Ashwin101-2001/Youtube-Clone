import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ytube_search/utilities/functions.dart';

import '../home.dart';

class Switchclass extends StatefulWidget {
  String ch;
  SharedPreferences pref;
  Switchclass({this.ch,this.pref});
  @override
  SwitchclassState createState() => SwitchclassState(ch:ch,pref:pref);
}

class SwitchclassState extends State<Switchclass> {
  String ch;

  SwitchclassState({this.ch,this.pref});

  bool history;
  bool debug;
  SharedPreferences pref;
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading =true;
    init();
  }

  void init() async {
    if(pref==null)
    pref = await SharedPreferences.getInstance();
    bool x = pref.getBool("history");
    history=(x!= null ? x : true);
    print("hist:$history");
    pref.setBool("history",history);

    x = pref.getBool("debug");
    debug=(x!= null ? x : false);
    print("debug:$debug");
    pref.setBool("debug", debug);
    setState(() {
      loading=false;
    });

  }

  @override
  Widget build(BuildContext context) {
    switch (ch) {
      case "history":
        {
          return SwitchListTile(
            title: Text("History", style: TextStyle(
                color: Colors.lightBlue[500], fontWeight: FontWeight.bold,fontSize: 25),),
            subtitle: Text("on/off ? ", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15),),
            secondary: Icon(Icons.history, color: Colors.pink[500],),
            value: history!=null?history:true,
            onChanged: (value) {
              pref.setBool("history", value);
              setState(() {
                history = value;
              });
            },

          );
        }


      case "debug":
        {
          return SwitchListTile(
            title: Text("Debug mode", style: TextStyle(
                color: Colors.pink[200], fontWeight: FontWeight.bold,fontSize: 25),),
            subtitle: Text("on/off ? ", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15),),
            secondary: Icon(Icons.settings_rounded, color: Colors.lightBlue[500],),
            value: debug!=null?debug:false,
            onChanged: (value) {
              pref.setBool("debug", value);
              setState(() {
                debug = value;
              });
            },

          );
        }
    }
  }
}