import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/utilities/screens_size.dart';

class VideoCard2 extends StatelessWidget {
  VideoCard2({this.item});

  final Item item;
  @override
  Widget build(BuildContext context) {
    print('building VideoCard');
    double width = Responsive.width(100, context);
    double height = Responsive.height(100, context);

    return Container(
      margin:EdgeInsets.only(bottom: 20),



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

              ListTile(

               leading:GestureDetector(
                   onTap: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) =>  DisplayChannel(q:item.channel,)),
                     );
                   },
                   child: CircleAvatar(backgroundImage: item.channel.profilePicture,)),
                title:  GestureDetector(
                    onTap: (){launchvid(item.vid);},
                    child: Container(
                      width: width/4*3,
                        child: Wrap(children:<Widget>[Text(item.getVideoTitle(), style: videoTitleStyle)]))),
               subtitle: GestureDetector(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>  DisplayChannel(q:item.channel,)),
                   );
                 },
                 child: Container(
                   width:  width/4*3,
                   child: Wrap(

                     runSpacing: 0.0,
                   children:<Widget>[
                    Text(item.channel.channelName!=null?item.channel.channelName:'default', style: videoInfoStyle,),
                      Text(" ∙ ", style: videoInfoStyle,),
                      Text(item.getViewCount() + " views", style: videoInfoStyle,),
                      Text(" ∙ ", style: videoInfoStyle,),
                      Text(item.getTimeSinceUpload() + " ago", style: videoInfoStyle,),]),
                 ),
               ),
            trailing:Container(width: 0.0,),
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