import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:videoapp/models/videoModel.dart';

class FirebaseRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<VideoModel>> getVideos(){
    try {
      return _firestore.collection("videos").snapshots().map((QuerySnapshot query) {
        List<VideoModel> rel = [];
        query.docs.forEach((doc){
           rel.add(VideoModel.fromDocumentSnapshot(doc));
        });
        print(rel);
        return rel;
      } );
    } catch (e) {
      print("Some Error Occured!");
    }
  }

  uploadVideo(data)async{

    try {
      await _firestore
      .collection("videos")
      .add(data);
    } on FirebaseException catch (e){
      Get.snackbar(e.code, e.message);
    }

  }

}