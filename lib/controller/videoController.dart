import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:videoapp/models/videoModel.dart';
import 'package:videoapp/repository/firebaseRepository.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {

  FirebaseRepository _firebaseRepo = FirebaseRepository();

  RxList<VideoModel> video = List<VideoModel>.empty().obs;

  @override
  void onInit(){
    video.bindStream(_firebaseRepo.getVideos());
    super.onInit();
  }

}