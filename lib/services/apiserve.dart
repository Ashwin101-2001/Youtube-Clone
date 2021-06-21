import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:ytube_search/models/Curl.dart';
import 'package:ytube_search/models/Items.dart';
import 'package:ytube_search/models/Playlists.dart';
import 'package:ytube_search/models/channel.dart';
import 'package:ytube_search/models/video.dart';
import 'package:ytube_search/services/Databasehelper.dart';
import 'package:ytube_search/utilities/functions.dart';

import 'package:ytube_search/utilities/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();
  DatabaseHelper dbh;
  Database db;

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<List<Item>> fetchResult({String query}) async {
    dbh = DatabaseHelper();
    db = await dbh.database;
    List<Curl> curls = await dbh.getcurlList();

    query = getquerywithoutspace(query);

    SharedPreferences myPrefs = await SharedPreferences.getInstance(); //changed
    bool debug = myPrefs.getBool("debug");
    int max = debug != null ? (debug == true ? 5 : 10) : 10;

    print('fetching results of srch');

    var response = await http.get(
        'https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=$max&q=$query&type=video,playlist,channel&key=$API_KEY');
    if (response.statusCode == 200) {
      print('got result');

      //declaration
      List<Item> items = List<Item>();
      Item item2;
      int i = 0;
      String channelString;
      Map<String, String> channels = Map<String, String>();

      int k = (json.decode(response.body))['pageInfo']['totalResults'];
      int m = (json.decode(response.body))['pageInfo']['resultsPerPage'];

      while (i < (k < m ? k : m)) {
        Map<String, dynamic> data = (json.decode(response.body))['items'][i];

        String cid = data['snippet']['channelId'].toString();

        String cUrl;

        if (curlGivenCid(curls, cid) == null) //changed
        {
          print("not already searched");
          channels[cid] = "n";

          if (channelString == null) {
            channelString = "&id=$cid";
            cUrl = "nul";
          } else {
            channelString = channelString + "&id=$cid";
            cUrl = "nul";
          }
        } else {
          print("ALREADY SEARCHED");
          cUrl = curlGivenCid(curls, cid).URL;
          curlGivenCid(curls, cid).updateSearches(query); //is query already there
          curlGivenCid(curls, cid).recentDate=DateTime.now().toString();
          dbh.insertCurl(curlGivenCid(curls, cid));
          print("CID:$cUrl");
        }

        item2 = (Item.fromMap(data, cUrl));
        //print(item2.videoTitle);
        items.add(item2);
        //print('k');

        i++;
      }

      if (channelString != null) {
        String re =
            "https://youtube.googleapis.com/youtube/v3/channels?part=snippet&part=statistics&maxResults=20$channelString&key=$API_KEY";
        // print(re);
        var response1 = await http.get(re);
        if (response1.statusCode == 200) {
          int k = (json.decode(response1.body))['pageInfo']['totalResults'];
          //********Results per page
          for (int j = 0; j < k ; j++) {  //K<20?k:20
            //print( j );
            Map<String, dynamic> data1 =
                (json.decode(response1.body))['items'][j];
            // print(data1.toString());
            String id = data1['id'];
            String t=(json.decode(response1.body))['items'][j]['snippet']
            ['thumbnails']['high']['url'];
             if(t==null)
               { print("ERROR");
                 print(re);
                print((json.decode(response1.body))['items'][j]['snippet']
                ['title']);


               }

            channels[id] = t;
            Curl c=Curl(id,channels[id],DateTime.now().toString(),DateTime.now().toString(),query);
             dbh.insertCurl(c);
          }

          for (Item i in items) {
            if (i.channel.profilePicture.url == "nul") {
              print("url:${channels[i.channel.id]}");
              i.channel.profilePicture = NetworkImage(channels[i.channel.id]);
            }
          }
        } else {

          print("error in http:"
              "$re");
        }
      }

      return items;
    } else {
      print('no result');
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Item>> fetchvideos({String p, String x}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance(); //changed
    bool debug = myPrefs.getBool("debug");
    int max = debug != null ? (debug == true ? 3 : 15) : 15;
    print('fetching videos from playlist');

    var response = await http.get(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=$max&playlistId=$p&key=$API_KEY');
    if (response.statusCode == 200) {
      print('got result');
      List<Item> items = List<Item>();
      Item item2;
      int i = 0;
      int k = (json.decode(response.body))['pageInfo']['totalResults'];
      int m = (json.decode(response.body))['pageInfo']['resultsPerPage'];
      while (i < (k < m ? k : m)) {
        Map<String, dynamic> data = (json.decode(response.body))['items'][i];

        if (data['snippet']['title'] != 'Private video') {
          item2 = (Item.fromMap2(data, x));
          items.add(item2);
        }

        i++;
      }
      return items;
    } else {
      print('error no result');
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Playlist>> fetchplaylists({String cid}) async {
    print('fetching playlist of ch');
    SharedPreferences myPrefs = await SharedPreferences.getInstance(); //changed
    bool debug = myPrefs.getBool("debug");
    int max = debug != null ? (debug == true ? 3 : 15) : 15;

    var response = await http.get(
        'https://youtube.googleapis.com/youtube/v3/playlists?part=snippet&part=contentDetails&maxResults=$max&channelId=$cid&key=$API_KEY');
    if (response.statusCode == 200) {
      print('got result');
      List<Playlist> items = List<Playlist>();
      Playlist item2;
      int i = 0;
      int k = (json.decode(response.body))['pageInfo']['totalResults'];
      int m = (json.decode(response.body))['pageInfo']['resultsPerPage'];
      while (i < (k < m ? k : m)) {
        //print(i);
        Map<String, dynamic> data = (json.decode(response.body))['items'][i];

        //print('k');
        item2 = (Playlist.fromMap(data));
        items.add(item2);
        //print('k');

        i++;
      }
      return items;
    } else {
      print('no result');
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Item>> fetchVideosFromChannel({String cid, String x}) async {
    print('fetching videos of ch');
    SharedPreferences myPrefs = await SharedPreferences.getInstance(); //changed
    bool debug = myPrefs.getBool("debug");
    int max = debug != null ? (debug == true ? 3 : 15) : 15;

    String re =
        "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=$max&channelId=$cid&type=video&key=$API_KEY";
    print(re);
    var response = await http.get(re);
    if (response.statusCode == 200) {
      print('got result');
      List<Item> items = List<Item>();
      Item item2;
      int i = 0;
      int k = (json.decode(response.body))['pageInfo']['totalResults'];
      int m = (json.decode(response.body))['pageInfo']['resultsPerPage'];
      while (i < (k < m ? k : m)) {
        //print(i);
        Map<String, dynamic> data = (json.decode(response.body))['items'][i];

        //print('k');
        item2 = (Item.fromMap(data, x));
        items.add(item2);
        //print('k');

        i++;
      }
      return items;
    } else {
      print('no result');
      throw json.decode(response.body)['error']['message'];
    }
  }

/*Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  } */
  Future<List<String>> fetchsuggestions() async {
    var response = await http.get(
        'http://suggestqueries.google.com/complete/search?client=youtube&ds=yt&client=firefox&q=ash&hjson=t&cp=1');

    return null;
  }
}
