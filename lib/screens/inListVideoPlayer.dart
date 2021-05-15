import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class InListVideoPlayer extends StatefulWidget {
  
  final String title;
  final String description;
  final String url;
  final VideoPlayerController videoPlayerController;
  final bool looping;

  InListVideoPlayer({Key key,
  @required this.description,
  @required this.title,
  @required this.videoPlayerController,
  this.looping,
  @required this.url}):super(key: key);

  @override
  _InListVideoPlayerState createState() => _InListVideoPlayerState();
}

class _InListVideoPlayerState extends State<InListVideoPlayer> {

  ChewieController _chewieController;
  Future<void> _future;


    Future<void> initVideoPlayer() async {
      await widget.videoPlayerController.initialize();
      setState(() {
        print(widget.videoPlayerController.value.aspectRatio);
        _chewieController = ChewieController(
          videoPlayerController: widget.videoPlayerController,
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          autoPlay: false,
          autoInitialize: true,
          looping: widget.looping,
          showControlsOnInitialize:false,
          deviceOrientationsOnEnterFullScreen: [DeviceOrientation.portraitUp],

        errorBuilder: (context,errorMessage) {
          return Center(
            child: Text(errorMessage,style: TextStyle(color:Colors.white),)
          );
        }
        );
      });
  }


  @override
    void initState() {
      
      _future = initVideoPlayer();
      super.initState();
    }
    
    @override
      void dispose() {
        widget.videoPlayerController.dispose();
        _chewieController.dispose();
        super.dispose();
      }

  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
     future:_future,
     builder: (context,snapShot){
       return widget.videoPlayerController.value.isInitialized? Container(
               margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: AspectRatio(
                        aspectRatio:widget.videoPlayerController.value.aspectRatio,
                        child: Chewie(
                          controller: _chewieController,),
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                widget.title,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                widget.description,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromRGBO(255, 77, 58, 1),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_circle_filled_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              Text(
                                widget.videoPlayerController.value.duration.inSeconds.toString()+"s",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ):Center(
                child: Container(
                margin: EdgeInsets.all(5),
                child: Center(child:CircularProgressIndicator())),
              );
     }
    
   );
  }
}