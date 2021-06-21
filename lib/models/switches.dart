import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ytube_search/utilities/functions.dart';

import '../home.dart';

class Switchclass extends StatefulWidget {
  String ch;
  Switchclass({this.ch});
  @override
  SwitchclassState createState() => SwitchclassState(ch:ch);
}

class SwitchclassState extends State<Switchclass> {
  String ch;

  SwitchclassState({this.ch});

  bool toggle;
  bool debug;
  SharedPreferences pref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    pref = await getmyPref();
    bool x = pref.getBool("toggle");
    toggle=(x!= null ? x : true);
    pref.setBool("toggle",toggle);

    x = pref.getBool("debug");
    debug=(x!= null ? x : false);
    pref.setBool("debug", debug);

  }

  @override
  Widget build(BuildContext context) {
    switch (ch) {
      case "toggle":
        {
          return SwitchListTile(
            title: Text("History", style: TextStyle(
                color: Colors.lightBlue[500], fontWeight: FontWeight.bold,fontSize: 25),),
            subtitle: Text("on/off ? ", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15),),
            secondary: Icon(Icons.history, color: Colors.pink[500],),
            value: toggle!=null?toggle:true,
            onChanged: (value) {
              pref.setBool("toggle", value);
              setState(() {
                toggle = value;
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