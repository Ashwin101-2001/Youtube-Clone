import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/Playlists.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/Channeldisplay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Search.dart';

class ListCard extends StatelessWidget {
  ListCard([this.item,this.play]);
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
  void initState()
  {

  }

  @override
  Widget build(BuildContext context) {
    print('init');
    print(item);
    print(play);

    if(this.item!=null)
    {    print('itemmmmm');
    id=item.vid;
    title=item.title;
    cname=item.channel.channelName;
    thumbnail=item.thumbnail;
    cthumbnail=item.channel.profilePicture;
    count="";
    }
    if(this.play!=null)
    {    print('playyy');
    id=play.id;
    title=play.playTitle;
    cname=play.cname;
    thumbnail=play.thumbnail;
    cthumbnail=play.cthumbnail;
    count=play.vidcount.toString()+" videos";
    }


    print('building ListCard');
    return GestureDetector(
      onTap: (){
        if(item!=null)
       {Playlist play1=Playlist(id: item.vid,playTitle: item.title,thumbnail: item.thumbnail);

       Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => Search(play1.id,'play',item.channel.profilePicture.url,play1)),
       );}
        else
          { Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Search(this.play.id,'play',this.play.cthumbnail.url,this.play)),
          );}},

      child: Container(
          padding: EdgeInsets.only(bottom: 30.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(

                height: 150,
                decoration:  BoxDecoration(

                    image: DecorationImage(image: thumbnail,
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text(title,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(height: 3,),
                      Text(cname,style: TextStyle(fontSize: 13,color: Colors.grey),),
                      SizedBox(height: 3,),
                      Text(count,style: TextStyle(fontSize: 13,color: Colors.grey),),


      ],
      ),
      ),
            ),
      ],)
      ),
    );

  }
}

