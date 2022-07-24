import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class DataManager {
  DataManager({this.flickManager, this.urls, this.currentPlaying});

  dynamic currentPlaying = 0; //ontap --{video index -->get index}
  final FlickManager flickManager;
  final dynamic urls;

  Timer videoChangeTimer;

  String getNextVideo() {
    currentPlaying++;
    return urls[currentPlaying]["video_link"];
  }

  bool hasNextVideo() {
    return currentPlaying != urls.length - 1;
  }

  bool hasPreviousVideo() {
    return currentPlaying != 0;
  }

  skipToNextVideo([Duration duration]) {
    if (hasNextVideo()) {
      flickManager.handleChangeVideo(
          VideoPlayerController.network(urls[currentPlaying + 1]["video_link"]),
          videoChangeDuration: duration);
      //TODO : animation for 5 sec delay...
      return 1;
//      currentPlaying++;
    } else
      return 0;
  }

  skipToPreviousVideo() {
    if (hasPreviousVideo()) {
      currentPlaying--;
      flickManager.handleChangeVideo(
          VideoPlayerController.network(urls[currentPlaying]["video_link"]));
    }
  }

  cancelVideoAutoPlayTimer({bool playNext}) {
    if (playNext != true) {
      currentPlaying--;
    }

    flickManager.flickVideoManager.cancelVideoAutoPlayTimer(playNext: playNext);
  }
}
