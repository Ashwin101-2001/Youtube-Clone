import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  VideoCard({this.item});

  final Item item;
  @override
  Widget build(BuildContext context) {
    print('building VideoCard');

    return Container(



      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 210,
              decoration:  BoxDecoration(

                  image: DecorationImage(image: item.thumbnail,
                      fit: BoxFit.cover
                  )
              ),
            ),
            onTap: (){launchvid(item.vid);},

          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 20),
            child: Row(
              //direction: Axis.horizontal,
              children: <Widget> [
                Column(
                  children: <Widget>[
                    GestureDetector(

                     child: Container(

                        height: 35,
                       child: CircleAvatar(backgroundImage: item.channel.profilePicture,),
                      /*  child: Container(
                          height: 35,
                          decoration:  BoxDecoration(

                              image: DecorationImage(image: item.channel.profilePicture,
                                  fit: BoxFit.cover
                              )
                          ),
                        ),*/

                      ),
                      onTap:(){launchchannel(item.channel.id);} ,
                    ),



                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Wrap(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Text(item.getVideoTitle(), style: videoTitleStyle),
                      Container(
                        child: Wrap(

                          //alignment: WrapAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                                child: Container(

                                  child: Wrap(
                                       children:<Widget>[
                                         Text(item.channel.channelName!=null?item.channel.channelName:'default', style: videoInfoStyle,),
                                         Text(" ∙ ", style: videoInfoStyle,),
                                         Text(item.getViewCount() + " views", style: videoInfoStyle,),
                                         Text(" ∙ ", style: videoInfoStyle,),
                                         Text(item.getTimeSinceUpload() + " ago", style: videoInfoStyle,),]),
                                ),

                              onTap: (){ Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DisplayChannel(q:item.channel,)),
                              );}
                              ,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]
            ),
          )
        ],
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
  await launch('https://www.youtube.com/watch?v=$vid');
}