import 'package:flutter/material.dart';
import 'package:ytube_search/Search.dart';
import 'package:ytube_search/constanst/constants.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/Playlists.dart';
import 'package:ytube_search/models/channel.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/utilities/functions.dart';
import 'file:///D:/Ashwin/varnam_attendance/lib/utilities/screens_size.dart';

class hPlayCard extends StatelessWidget {

  hPlayCard([this.item,this.play]);
  //ListCard({this.item});

  final Item item;
  final Playlist play;
  String id;
  String title;
  String cname;
  NetworkImage thumbnail;
  NetworkImage cthumbnail;
  String  count;

  @override
  Widget build(BuildContext context) {

    print('building VideoCard');


    if(this.item!=null)
    {
    id=item.vid;
    title=item.title;
    cname=item.channel.channelName;
    thumbnail=item.thumbnail;
    cthumbnail=item.channel.profilePicture;
    count="";
    }
    if(this.play!=null)
    {
    id=play.id;
    title=play.playTitle;
    cname=play.cname;
    thumbnail=play.thumbnail;
    cthumbnail=play.cthumbnail;
    count=play.vidcount.toString()+" videos";
    }


    double width = Responsive.width(100, context);
    double height = Responsive.height(100, context);

    return GestureDetector(
      onTap: (){
        if(item!=null)
        {Playlist play1=Playlist(id: item.vid,playTitle: item.title,thumbnail: item.thumbnail);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Search(null,play1.id,'play',item.channel.profilePicture.url,play1)),
        );}
        else
        { Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Search(null,this.play.id,'play',this.play.cthumbnail.url,this.play)),
          //SOS
        );}},
      child: Container(
        padding: EdgeInsets.only(bottom: horizontalCardsBpadding),
          height: height/3,
          child: Row(
            children: [
              Container(
                width:width/4,
                decoration:  BoxDecoration(

                    image: DecorationImage(image: thumbnail,
                        fit: BoxFit.cover
                    )
                ),
              ),

              Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: ( Text(removeAndFromTitles(title), style: videoTitleStyle))),



                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text(cname,style: videoInfoStyle,),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(count,style: videoInfoStyle,),
                        )
                      ],
                    ),
                  )
              ),
            ],


          )
      ),
    );
  }
}