import 'dart:convert';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class VideoCallService {
  RTCVideoRenderer localVideoRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteVideoRenderer = RTCVideoRenderer();
  bool offer = false;
  RTCPeerConnection _peerConnection;
  MediaStream localStream, remoteStream;
  List candidates = List();

  VideoCallService() {
    _initRederers();
    _createPeerConnection().then((pc) {
      _peerConnection = pc;
    });
  }

  _initRederers() async {
    try {
      await localVideoRenderer.initialize();
      await remoteVideoRenderer.initialize();
    } catch (e) {
      print(e);
    }
  }

  getUserMedia() async {
    Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'}
    };

    try {
      MediaStream mediaStream = await navigator.getUserMedia(mediaConstraints);

      localVideoRenderer.srcObject = mediaStream;
      localVideoRenderer.mirror = true;

      return mediaStream;
    } catch (e) {
      print(e);
    }
  }

  _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"}
      ]
    };

    final Map<String, dynamic> offerConstraints = {
      "mandatory": {"OfferToReceiveAudio": true, "OfferToReceiveVideo": true},
      "optional": []
    };

    try {
      localStream = await getUserMedia();

      RTCPeerConnection rtcPeerConnection =
          await createPeerConnection(configuration, offerConstraints);

      rtcPeerConnection.addStream(localStream);

      rtcPeerConnection.onIceCandidate = (e) {
        if (e.candidate != null) {
          var candidate = json.encode({
            'candidate': e.candidate.toString(),
            'sdpMid': e.sdpMid.toString(),
            'sdpMlineIndex': e.sdpMlineIndex,
          });
          candidates.add(candidate);
          print('candidates : $candidates');
        }
      };

      rtcPeerConnection.onIceConnectionState = (e) {
        print('pcIceConnectionState : $e');
      };

      rtcPeerConnection.onAddStream = (stream) {
        print('add stream : ${stream.id}');
        remoteVideoRenderer.srcObject = stream;
      };

      return rtcPeerConnection;
    } catch (e) {
      print(e);
    }
  }

  createOffer() async {
    try {
      RTCSessionDescription rtcSessionDescription =
          await _peerConnection.createOffer({"OfferToReceiveVideo": true});
      var session = parse(rtcSessionDescription.sdp);
      var offerSessionBody = json.encode(session);
      print('createOffer sessionJsonBody : $offerSessionBody');
      // print('$offerSessionBody');

      offer = true;

      _peerConnection.setLocalDescription(rtcSessionDescription);

      return offerSessionBody;
    } catch (e) {
      print(e);
    }
  }

  setRemoteDescription(String remoteDescription) async {
    try {
      dynamic session = jsonDecode('$remoteDescription');

      String sdp = write(session, null);

      RTCSessionDescription sessionDescription =
          new RTCSessionDescription(sdp, offer ? 'answer' : 'offer');

      print('sessionDescription : ${sessionDescription.toMap()}');

      await _peerConnection.setRemoteDescription(sessionDescription);
    } catch (e) {
      print(e);
    }
  }

  setCandidate(String candidateDescription) async {
    try {
      dynamic session = jsonDecode('$candidateDescription');
      dynamic sessionCandidate = session['candidate'];
      print('sessionCandidate : $sessionCandidate');
      dynamic candidate = RTCIceCandidate(
          sessionCandidate, session['sdpMid'], session['sdpMlineIndex']);

      await _peerConnection.addCandidate(candidate);
    } catch (e) {
      print(e);
    }
  }

  createAnswer() async {
    try {
      RTCSessionDescription rtcSessionDescription =
          await _peerConnection.createAnswer({"OfferToReceiveVideo": true});
      var session = parse(rtcSessionDescription.sdp);
      var ansSessionBody = json.encode(session);
      print('createAnswer sessionJsonBody : $ansSessionBody');

      _peerConnection.setLocalDescription(rtcSessionDescription);

      return ansSessionBody;
    } catch (e) {
      print(e);
    }
  }

  disposeRenderers() {
    localVideoRenderer.dispose();
    remoteVideoRenderer.dispose();
  }
}
