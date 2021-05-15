import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:videoapp/screens/inListVideoPlayer.dart';

class Description extends StatefulWidget {
  final String description;
  final String title;
  final String url;
  final VideoPlayerController videoPlayerController;

  Description({Key key, @required this.description, @required this.title, @required this.url, @required this.videoPlayerController});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(13, 12, 15, 1),
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(13, 12, 15, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InListVideoPlayer(
            description: widget.description, 
            title: widget.title, 
            videoPlayerController: widget.videoPlayerController, 
            url: widget.url),
        ],
      ),
    );
  }
}
