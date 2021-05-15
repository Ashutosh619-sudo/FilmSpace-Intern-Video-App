import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videoapp/repository/firebaseRepository.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadController extends GetxController {
  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FirebaseRepository _firebaseRepo = FirebaseRepository();

  Rx<bool> uploading = false.obs;

  Rx<String> fileName = "".obs;

  Rx<File> thumbnail;

   getThumbnail()async{
    final uint8list = await VideoThumbnail.thumbnailData(
    video: fileName.value,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128, 
    quality: 25,
    );
    thumbnail.value = File.fromRawPath(uint8list);
  }

  chooseVideo()async{

    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,);
    
    if(pickedFile != null){
      fileName.value = pickedFile.path;
      await getThumbnail();
    }
  }

  upload()async{
    try {
      uploading.toggle();
      TaskSnapshot uploadTask = await firebase_storage.FirebaseStorage.instance
        .ref(fileName.value)
        .putFile(File(fileName.value));

      var url = await uploadTask.ref.getDownloadURL();
      

      String title = titleController.text.trim();
      String description = descriptionController.text.trim();

      var data = {
        "title": title,
        "description": description,
        "url":url
      }; 
      
      await _firebaseRepo.uploadVideo(data);

      uploading.toggle();
      fileName.value = "";  
    } on firebase_storage.FirebaseException catch (e){
      uploading.value = false;
      Get.snackbar(e.code, e.message);
    }
    
  }


}