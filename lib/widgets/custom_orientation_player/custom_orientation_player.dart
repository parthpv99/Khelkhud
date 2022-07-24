import 'package:SportsAcademy/pages/VideoPlayerScreen.dart';

import 'controls.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:video_player/video_player.dart';

import 'data_manager.dart';

class CustomOrientationPlayer extends StatefulWidget {
  dynamic playlistjson, videoindex;
  CustomOrientationPlayer(
      {@required this.playlistjson, @required this.videoindex});

  @override
  _CustomOrientationPlayerState createState() =>
      _CustomOrientationPlayerState();
}

class _CustomOrientationPlayerState extends State<CustomOrientationPlayer> {
  FlickManager flickManager;
  DataManager dataManager;


  @override
  void initState() {
    super.initState();
    dynamic urls = widget.playlistjson["playlist_video"];
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
          urls[widget.videoindex]["video_link"],
//          'https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true',
        ),
        onVideoEnd: () {
          int val = dataManager.skipToNextVideo(Duration(seconds: 5));
          if (val == 1) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                    playlistjson: widget.playlistjson,
                    videoindex: widget.videoindex + 1)));
          }
        });

    dataManager = DataManager(
        flickManager: flickManager,
        urls: urls,
        currentPlaying: widget.videoindex);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  skipToVideo(dynamic url) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
            playlistjson: widget.playlistjson,
            videoindex: widget.videoindex + 1)));
//    flickManager
//        .handleChangeVideo(VideoPlayerController.network(url["video_link"]));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager.autoResume();
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: FlickVideoPlayer(
              flickManager: flickManager,
              preferredDeviceOrientationFullscreen: [
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              flickVideoWithControls: FlickVideoWithControls(
                controls: CustomOrientationControls(dataManager: dataManager),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                videoFit: BoxFit.fitWidth,
                controls: CustomOrientationControls(dataManager: dataManager),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
