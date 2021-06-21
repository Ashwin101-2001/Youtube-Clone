import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Search.dart';
import 'home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedPreferences myPrefs;
  String voice;
  bool justVoiced;
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading=true;
    init();

  }
  void init () async
  {  myPrefs= await SharedPreferences.getInstance();
     voice=myPrefs.getString("speech");
     justVoiced= myPrefs.getBool("justVoiced");
     if(justVoiced==null)
       { justVoiced= false;
       myPrefs.setBool("justVoiced",false);
       }

     if(justVoiced==true)
       myPrefs.setBool("justVoiced",false);
     setState(() {
       loading=false;
     });



  }


  @override
  Widget build(BuildContext context) {
    if(loading==false)
      { if(justVoiced)
        return Search(voice,'search');
      else
        return Home();
      }
    else{
      return Scaffold(

        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme
                  .of(context)
                  .primaryColor, // Red
            ),
          ),
        ),
      );


    }


  }
}

