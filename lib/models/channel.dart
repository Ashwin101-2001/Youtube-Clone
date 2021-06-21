import 'package:flutter/material.dart';

class Channel {
  String channelName;
  NetworkImage  profilePicture;
  String id;

  Channel(String channelName, NetworkImage profilePic,String id) {
    this.channelName = channelName;
    this.profilePicture = profilePic;
    this.id=id;

  }
}