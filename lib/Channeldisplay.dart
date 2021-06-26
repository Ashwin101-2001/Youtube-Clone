import 'package:flutter/material.dart';
import 'package:ytube_search/Views/Loading.dart';
import 'package:ytube_search/Views/horizontalPlaylistCard.dart';
import 'package:ytube_search/Views/horizontalVideoCard.dart';
import 'package:ytube_search/home.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/Playlists.dart';
import 'package:ytube_search/services/apiserve.dart';
import 'Views/playlist_card.dart';


import 'Views/channel_avatar.dart';
import 'Views/play_card.dart';
import 'Views/suggestions_tab.dart';
import 'Views/video2.dart';
import 'Views/video_card.dart';
import 'models/channel.dart';
import 'models/colors.dart';
import 'models/textstyles.dart';
import 'models/video.dart';
const  String x='';

class DisplayChannel extends StatefulWidget {
  Channel q;
  DisplayChannel({this.q});
  @override
  DisplayChannelState createState() =>  DisplayChannelState(q:q);
}

class  DisplayChannelState extends State< DisplayChannel> {
  Channel q;
  DisplayChannelState({this.q});
  //SearchState({this.q});
  Map data={};
  List<Playlist> items1;
  List<Item> items2;




  @override
  void initState()
  { print('init playscreen');
  super.initState();
  _initResult();
  }




  _initResult() async {

    List<Playlist> play= await APIService.instance
        .fetchplaylists(cid:this.q.id);
    List<Item> items=await APIService.instance
        .fetchVideosFromChannel(cid:this.q.id,x:this.q.profilePicture.url);
    print('fetch playlist  done');
    setState(() {
      items1 = play;
      items2=items;
    });
  }







  @override
  Widget build(BuildContext context) {
    print('building playlist screen');
    // This trailing comma makes auto-formatting nicer for build methods.
    // data =  ModalRoute.of(context).settings.arguments;
    // this.q=data['q'];
    if(items1!=null)
    { return OrientationBuilder(
        builder: (context, orientation) {
          return DefaultTabController(
            length: 3,
            child: new Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  Container(
                    child: Row(children: <Widget>[
                      Container(
                        width: 30,

                        child: Image(image: AssetImage("android/assets/aky.png"),),
                      ),
                      Text("YouTube", style: youtube,),
                    ],),),
                  Container(
                      padding: EdgeInsets.only(left: 40, bottom: 15),
                      width: 260,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.cast),
                            GestureDetector(child: Icon(Icons.search,color: Colors.white,),
                                onTap:(){
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => Home()),
                                          (Route<dynamic> route) => false);}
                            ),
                            Container(
                              height: 30,
                              width: 30,

                              child: CircleAvatar(
                                  backgroundColor:Colors.black12,
                                  backgroundImage: AssetImage('android/assets/youtube_logo.png')),
                            )
                          ],
                        ),
                      )
                  ),
                ],
                backgroundColor: tabBarColor,
                bottom:new TabBar(
                  labelStyle: tabTextStyle,
                  tabs: tabList,
                  labelColor: tabBarSelectedIconsColor,
                  unselectedLabelColor: tabBarUnselectedIconsColor,
                  indicatorColor: Colors.transparent,

                ),
              ),
              body:
              TabBarView(
                children: [
                  Column(
                      children:[Container(
                        margin:EdgeInsets.only(left: 50.0),
                        height: 100,
                        child: ListTile(
                          leading:  CircleAvatar(backgroundImage:q.profilePicture),
                          title: Container(
                            padding:EdgeInsets.only(left:60),
                            child:Text(q.channelName,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),),
                          subtitle: Container(
                            padding:EdgeInsets.only(left:60),
                            child:Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('100 subscribers',style: TextStyle(fontSize: 15,color: Colors.grey),),

                                Text('100 videos',style: TextStyle(fontSize: 15,color: Colors.grey),)],
                            ),),

                        ),
                      ),
                        Container(

                        )
                      ]
                  ),

                  Container(
                    color: backgroundColor,
                    child: ListView(children: getplaylists(orientation),),),
                  Container(
                    color: backgroundColor,
                    child: ListView(children: getVideos(orientation),),),


                ],
              ),

              backgroundColor: tabBarColor,

            ),
          );
        }

    );}
    else{
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              child: Row(children: <Widget>[
                Container(
                    width: 30,
                    //child: Image(image: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Flogos-world.net%2Fyoutube-logo%2F&psig=AOvVaw3vdfSAjgEWZiSXZGRvrsxB&ust=1616180102071000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODe_JjCuu8CFQAAAAAdAAAAABAD"),),
                    child:Image(image: AssetImage('android/assets/aky.png'),)
                ),
                SizedBox(width:10),
                Text("YouTube", style: youtube,),
              ],),),
            Container(
                padding: EdgeInsets.only(left: 40, bottom: 15),
                width: 260,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.cast),
                      GestureDetector(child: Icon(Icons.search,color: Colors.white,),
                          onTap:(){   Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                                  (Route<dynamic> route) => false);}
                      ),


                      Container(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                            // backgroundImage: NetworkImage('data:image/png;base64,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')),
                            backgroundColor: Colors.black12,
                            backgroundImage:AssetImage('android/assets/youtube_logo.png'),
                          )),
                    ],
                  ),
                )
            ),
          ],
          backgroundColor: tabBarColor,

        ),
        body:Loader(),
      );

    }
  }





  List<Widget> getplaylists(Orientation o) {
    List<Widget> cards = [];

    for  (Playlist item in items1) {
      //print('looping');
      item.cname=this.q.channelName;
      item.cthumbnail=this.q.profilePicture;
      //cards.add(PlayCard(play:item,y:this.q.profilePicture.url));
      if(o==Orientation.portrait)
      cards.add(ListCard(null,item));
      else
        { cards.add(hPlayCard(null,item));

        }

    }
    print(cards.toString());
    return cards;
  }
  List<Widget> getVideos(Orientation o) {
    List<Widget> cards = [];


    /*  cards.add(Container(
      margin: EdgeInsets.only(top:10.0,bottom:20.0),
      child: Center(
        child: Text(
          ' VIDEOS',
          style:TextStyle(color: Colors.yellow[800],fontWeight: FontWeight.bold,fontSize: 25,decoration:TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,) ,
        ),
      ),
    ));*/

    for  (Item item in items2) {
      //print('looping');
      if(o==Orientation.portrait)
      cards.add(VideoCard2(item:item));
      else
        cards.add(Hcard(item: item,));
    }
    print(cards.toString());
    return cards;
  }



  List<Widget> tabList = [
    Tab(
      icon: new Icon(Icons.home),
      text: "Home",
    ),
    Tab(

      icon: new Icon(Icons.video_collection_sharp),
      text: "Playlists",
    ),
    Tab(
      icon: new Icon(Icons.slow_motion_video),
      text: "Videos",
    ),

  ];
}


