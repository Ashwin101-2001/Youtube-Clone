import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';

class ChannelCard2 extends StatelessWidget {
  ChannelCard2({this.item});

  final Item item;
  @override
  Widget build(BuildContext context) {
    print('building ListCard');

    return GestureDetector(

      onTap: (){Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  DisplayChannel(q:item.channel,)),
      );},
      child: Container(
        margin:EdgeInsets.only(left:50.0,bottom: 20.0),

        child: ListTile(
          leading:  CircleAvatar(backgroundImage:item.channel.profilePicture),
          title: Container(
            padding:EdgeInsets.only(left:60),
            child:Text(item.title,style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold),),),
          subtitle: Container(
           padding:EdgeInsets.only(left:60),
           child:Wrap(
            direction: Axis.vertical,
            children: [
                 Text('100 subscribers',style: TextStyle(fontSize: 18,color: Colors.grey),),

                 Text('100 videos',style: TextStyle(fontSize: 18,color: Colors.grey),)],
          ),),

        ),
      )
    );

  }
}

launchchannel(String cid) async {
  //const  url = 'https://www.youtube.com/results?search_query=$search';
  //if (await canLaunch(url)) {
  await launch('https://www.youtube.com/channel/$cid');
  //await launch('https://www.youtube.com/watch?v=HAPQ3oUGgnE&list=PLlxmoA0rQ-Lw6tAs2fGFuXGP13-dWdKsB&index=3');
  /*else {
    throw 'Could not launch $url';
  }*/
}
launchvid(String vid)async {
  await launch('https://www.youtube.com/watch?v=$vid');}
