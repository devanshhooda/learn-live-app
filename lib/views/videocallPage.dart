import 'package:flutter/material.dart';
import 'package:flutter_webrtc/webrtc.dart';
// import 'package:learn_live_app/services/userServices.dart';
import 'package:learn_live_app/services/videoCallService.dart';

class VideoCallPage extends StatefulWidget {
  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  // UserServices _userServices;
  VideoCallService videoCallService;
  RTCVideoRenderer _localVideoRenderer;
  RTCVideoRenderer _remoteVideoRenderer;
  String remoteDescription, candidateDescription;

  @override
  void initState() {
    videoCallService = VideoCallService();
    // _userServices = new UserServices();
    super.initState();
  }

  @override
  void dispose() {
    _localVideoRenderer.dispose();
    _remoteVideoRenderer.dispose();
    super.dispose();
  }

  Widget _localVideo() {
    _localVideoRenderer = videoCallService.localVideoRenderer;
    return Container(
      margin: EdgeInsets.only(top: 50, right: 200),
      height: 200,
      child: RTCVideoView(_localVideoRenderer),
    );
  }

  Widget _remoteVideo() {
    _remoteVideoRenderer = videoCallService.remoteVideoRenderer;
    return Container(
      child: RTCVideoView(_remoteVideoRenderer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _localVideo(),
          _remoteVideoRenderer != null
              ? _remoteVideo()
              : Center(
                  child: Text('Dialing...'),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.call_end),
          onPressed: () {
            videoCallService.disposeRenderers();
            Navigator.of(context).pop();
          }),
    );
  }
}
