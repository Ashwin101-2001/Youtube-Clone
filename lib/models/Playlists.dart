import 'package:flutter/material.dart';

import 'channel.dart';

class Playlist {
  NetworkImage thumbnail;
  String playTitle;
  String id;
  int vidcount;
  String cname;
  NetworkImage cthumbnail;

  Playlist(
      {this.thumbnail, this.playTitle,this.id,this.vidcount});
   int index;
  String getplayTitle() {
    index = 0;
    if (this.playTitle.length > 29) {
      // fix title
      List wordList = this.playTitle.split(" ");
      String newTitle = "";
      while (index != wordList.length) {
        newTitle += makeTitleRow(wordList);
        if (wordList.length != index) {
          newTitle += "\n";
        }
      }
      return newTitle;
    } else {
      return this.playTitle;
    }
  }

  String makeTitleRow(List<String> wordList) {
    String newTitleRow = wordList[index];
    index += 1;
    while (newTitleRow.length < 29 && index != wordList.length) {
      newTitleRow += " " + wordList[index];
      index += 1;
    }
    if (newTitleRow.length > 29) {
      List<String> res = newTitleRow.split(" ");
      res.removeLast();
      for (int i = 0; i < res.length; i++) {
        if (i == 0) {
          newTitleRow = res[i];
        } else {
          newTitleRow += " " + res[i];
        }
      }
      index -= 1;
    }
    return newTitleRow;
  }


  factory Playlist.fromMap(Map<String, dynamic> map) {
    print('temb');
    return Playlist(
      playTitle: map['snippet']['title'],
      thumbnail: NetworkImage(map['snippet']['thumbnails']['high']['url']),
      //uploadDate:DateTime(map['snippet']['publishTime']),
      id:map['id'],
      vidcount:map['contentDetails']['itemCount'],



    );

  }
}