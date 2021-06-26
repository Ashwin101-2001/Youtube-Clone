import 'package:flutter/material.dart';
import 'package:ytube_search/constanst/constants.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/utilities/functions.dart';
import 'package:ytube_search/utilities/screens_size.dart';

class Hcard extends StatelessWidget {
  Hcard({this.item});

  final Item item;
  @override
  Widget build(BuildContext context) {
    print('building VideoCard');
    double width = Responsive.width(100, context);
    double height = Responsive.height(100, context);

    return Container(
        padding: EdgeInsets.only(bottom: horizontalCardsBpadding),
      height: height/3,
        child: Row(
          children: [
            GestureDetector(
              onTap: (){launchvid(item.vid);},
              child: Container(
                width:width/4,
                decoration:  BoxDecoration(

                    image: DecorationImage(image: item.thumbnail,
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding:  EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: (){launchvid(item.vid);},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Align(
                     alignment: Alignment.topLeft,
                       child: ( Text(removeAndFromTitles(item.title), style: videoTitleStyle))),



                     Align(
                       alignment: Alignment.topLeft,
                       child: Wrap(

                           runSpacing: 0.0,
                           children:<Widget>[
                             Text(item.channel.channelName!=null?item.channel.channelName:'default', style: videoInfoStyle,),
                             Text(" ∙ ", style: videoInfoStyle,),
                             Text(item.getViewCount() + " views", style: videoInfoStyle,),
                             Text(" ∙ ", style: videoInfoStyle,),
                             Text(item.getTimeSinceUpload() + " ago", style: videoInfoStyle,),]),
                     ),

                   Align(
                     alignment: Alignment.topLeft,
                     child: GestureDetector(
                       onTap: (){
                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                               builder: (context) => DisplayChannel(q:item.channel)),
                         );

                       },
                       child: CircleAvatar(
                       backgroundImage: item.channel.profilePicture,
                       ),
                     ),
                   )
          ],
         ),
                ),
              )
          ),
          ],


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
  await launch('https://www.youtube.com/watch?v=$vid');
}