import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoapp/controller/uploadController.dart';

class UploadScreen extends StatelessWidget {
  final UploadController _uploadController = Get.put(UploadController());
  @override
  Widget build(BuildContext context) {
    return GetX<UploadController>(
      builder:(controller){
        return Scaffold(
        appBar: AppBar(backgroundColor: Colors.grey),
          body:Stack(
            children: [
              Opacity(
                opacity: controller.uploading.value ? 0.5 : 1,
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                controller.fileName.value == "" ?
                GestureDetector(
                  onTap:(){
                    controller.chooseVideo();
                    },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Choose a file",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ):
                Image(
                  image: FileImage(controller.thumbnail.value),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: TextField(
                    
                    style: GoogleFonts.lato(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  child: TextField(
                    
                    style: GoogleFonts.lato(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:controller.fileName.value == "" || controller.uploading.value ? null:(){
                    controller.upload();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Upload",
                      style: GoogleFonts.lato(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                ]
                ),
              ),
              Opacity(
                opacity:controller.uploading.value?1:0,
                child:Center(child:CircularProgressIndicator())
              )
            ],
            ),
      );
      }
    );
        
      }
      
  }
