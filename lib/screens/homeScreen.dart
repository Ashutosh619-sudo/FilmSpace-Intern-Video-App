import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:videoapp/controller/uploadController.dart';
import 'package:videoapp/controller/videoController.dart';
import 'package:videoapp/screens/UploadScreen.dart';
import 'package:videoapp/screens/description.dart';
import 'package:videoapp/screens/inListVideoPlayer.dart';


class HomeScreen extends StatelessWidget {

  final VideoController _controller = Get.put(VideoController());
  final UploadController _uploadController = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Video App")

      ),
      backgroundColor: Color.fromRGBO(13, 12, 15, 1),
      body: GetX<VideoController>(
        builder:(controller){
          return ListView.builder(
          itemCount:controller.video.length,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context,index){
            
              return GestureDetector(
                onTap:(){
                Navigator.push(context, 
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds:500),
                  transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation,Widget child){

                    animation = CurvedAnimation(parent: animation,curve: Curves.easeOut);

                    return SlideTransition(
                      position: Tween(
                      begin: Offset(0.0, 1.0),
                      end: Offset(0.0, 0.0))
                                        .animate(animation),
                      child:child,
                    );
                  },
                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
                      return Description(
                        description: controller.video[index].description, 
                        title: controller.video[index].title, 
                        url: controller.video[index].url, 
                        videoPlayerController:VideoPlayerController.network(controller.video[index].url));
                    }));
              },
                child: InListVideoPlayer(
                videoPlayerController: VideoPlayerController.network(controller.video[index].url),
                looping:true,
                description:controller.video[index].description, 
                title: controller.video[index].title, 
                url: controller.video[index].url),
              );
  
          },
          );
        }
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return UploadScreen();
        }));
      },
      child:Icon(Icons.add,color:Colors.white)
      ),
    );
  }
}
