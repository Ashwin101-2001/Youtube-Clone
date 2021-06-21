import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ytube_search/Search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';


import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:ytube_search/utilities/functions.dart';

import 'models/searchform.dart';
import 'models/switches.dart';

    //String search='ashwin';
      //String x;
const platformMethodChannel =
const MethodChannel('ysearch');
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  NativeSharedPreferences prefs;
  bool loading;
  List<String> slist= List<String> ();
  String s;
  Map<String,String> smap;
  SharedPreferences myPrefs;
  Future<bool> _onWillPop() {

     return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?',style: TextStyle(fontWeight: FontWeight.bold),),
        content: Text('Do you want to exit Ytube Search ?',style: TextStyle(),),
        actions: <Widget>[ FlatButton(
          onPressed: () => exit(0),
          /*Navigator.of(context).pop(true)*/
          child: Text('Yes',style: TextStyle(),),
        ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(),),
          ),

        ],
      ),
    ) ??
        false;


  }

  @override
  void initState() {
    // TODO: implement initState
    loading=true;
    super.initState();
    _init();
  }
     _init ()async{
      // ignore: unnecessary_statements

       myPrefs=await getmyPref();
       smap=getsuggestions(myPrefs);
       smap.forEach((key, value) {slist.add(key);});
       prefs = await NativeSharedPreferences.getInstance();
       s="flutter.speech";
       s=prefs.get(s);
       if(slist.contains(s))
         {
           s="";
         }

       print(s);
      setState(() {
        loading =false;

      });



     }
  @override
  Widget build(BuildContext context) {
    print('build home');
    if(loading==false)
      {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: <Widget>[



                    Expanded(flex:2,
                        child: Container()),

                    Expanded(child: MyCustomForm(voiceSearch: this.s,),

                      flex:36,),


                    Expanded(
                      flex:4,
                      child: GestureDetector(
                        onDoubleTap: ()async {
                          launch("https://www.youtube.com/");
                        },
                        child: IconButton(

                            icon: Icon(Icons.mic_none_outlined,color:Colors.lightBlue[500],),
                            // color: Colors.,
                            //tooltip: "Save Todo and Retrun to List",
                            onPressed: () async {
                              await initPlatformState("voice search");


                            }
                        ),
                      ),
                    ),




                  ],
                ),
                body:Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("android/assets/ak123.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),

                  //color: Colors.black,
                  child:Column
                    (children:
                  [ SizedBox(height:30),
                    Container(
                        color:Colors.white,
                        //padding:EdgeInsets.only(bottom:50.0,top:20),
                        child: Switchclass(ch: "toggle",)),
                    SizedBox(height:30),
                    Container(
                        color:Colors.white,
                        child: Switchclass(ch: "debug",)),


                  ]),
                )

            ),
          );


      }
    else
      {  return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.white,



          ),
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme
                    .of(context)
                    .primaryColor, // Red
              ),
            ),
          ),
        ),
      );




      }

  }
}
  void initPlatformState(String s)async
   { final String result = await platformMethodChannel.invokeMethod(s);
     print(result);
   }




  Map<String,String> getsuggestions( SharedPreferences myPrefs )
  {
    Map<String,String> map= Map<String,String>();



   final keys = myPrefs.getKeys();

   for(String key in keys)
     { int l=key.length;
       if((l>=8)&&(l<=12))
       {
         String s=key.substring(0,7);
         String x="search#";
         if(s==x)
         {print("key:$key");
         //if(key.length>8)
         String no=key.substring(7);
         print(no);
         map[myPrefs.getString(key)]=no;

         }
       }


     }

  return map;


  }

