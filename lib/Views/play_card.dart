import 'package:flutter/material.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/Playlists.dart';
import 'package:ytube_search/models/textstyles.dart';
import 'package:ytube_search/models/video.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Search.dart';

class PlayCard extends StatelessWidget {
  PlayCard({this.play,this.y});
  String y;

  final Playlist play;
  @override
  Widget build(BuildContext context) {
    print('building PlayCard');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 200,
              decoration:  BoxDecoration(

                  image: DecorationImage(image: play.thumbnail,
                      fit: BoxFit.cover
                  )
              ),
            ),
            onTap: (){
              print('pressed playlist');
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search(null,play.id,'play',this.y ,play)),
            );},

          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
                children: <Widget> [

                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(child: Text(play.getplayTitle(), style: videoTitleStyle),
                          onPressed: (){
                            print('pressed playlist');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(null,play.id,'play',this.y,play)),
                              //SOS
                            );
                          },
                        ),

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
  await launch('https://www.youtube.com/channel/$cid');
  //await launch('https://www.instagram.com/direct/inbox/');


}
launchplay(String pid)async {
  await launch('https://www.youtube.com/playlist?list=$pid');
  //await launch('https://www.instagram.com/direct/inbox/');
}
