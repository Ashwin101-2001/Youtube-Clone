import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';

class ChannelCard extends StatelessWidget {
  ChannelCard({this.item});

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
        height: 200,
          margin: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(

                  child: SizedBox(
                      child: CircleAvatar(backgroundImage:item.thumbnail,radius:50.0,)
                  ,height: 100,
                      width:40),
                ),
                Expanded(

                  child: Container(
                    margin: EdgeInsets.only( top: 10, bottom: 10),
                    child:Column(
                      children: <Widget> [
                        Text(item.title,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(height: 3,),
                        Text('100 subscribers',style: TextStyle(fontSize: 13,color: Colors.grey),),
                        SizedBox(height: 3,),
                        Text('100 videos',style: TextStyle(fontSize: 13,color: Colors.grey),),


                      ],
                    ),
                  ),
                ),
              ],),
          )
      ),
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
