import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/webRTC/web_rtc.dart';

/*
  usage: Create an object of WebRTCRoom
  first make sure to call, connectToServer
  and then call builder to get the widget
*/

class WebRTCRoom {
  final String roomId;
  late Socket socket;
  final Function()? onConnect;
  final Function()? onConnectError;
  final Function()? onLocalStreamAdded;
  final Function()? onRemoteStreamAdded;
  final Function()? onRemoteRemoved;
  final Function()? onDisconnect;
  final Function()? onExit;

  final Widget Function(
    BuildContext context,
    String roomId,
    List<dynamic> usersData,
    List<RTCVideoView> videoViews,
    dynamic myUserData,
    RTCVideoView myVideoView,
    Widget controls,
  ) builder;

  WebRTCRoom({
    required this.builder,
    required this.roomId,
    this.onConnect,
    this.onDisconnect,
    this.onConnectError,
    this.onLocalStreamAdded,
    this.onRemoteStreamAdded,
    this.onRemoteRemoved,
    this.onExit,
  });

  final Map<String, dynamic> _peersData = {};
  final _localRTCVideoRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  final Map<String, RTCPeerConnection> _peers = {};
  final Map<String, RTCVideoRenderer> _remoteRTCVideoRenderers = {};
  bool _isAudioOn = true, _isVideoOn = true, _isFrontCameraSelected = true;

  Future<void> connectToServer() async {
    log("Connecting to socket on $websocketUrl");
    socket = io(
        websocketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.onConnect(_onConnect);

    socket.on('disconnect', (data) => disconnect());

    socket.onConnectError((data) {
      log("Connect Error $data");
      onConnectError?.call();
    });

    socket.connect();
  }

  void _onConnect(data) {
    log("Socket connected | data: $data");
    _localRTCVideoRenderer.initialize().then((value) => _initLocalStream());
    onConnect?.call();
  }

  Future<void> _initLocalStream() async {
    log("Initializing local stream");
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': _isAudioOn,
      'video': _isVideoOn
          ? {'facingMode': _isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });
    _localRTCVideoRenderer.srcObject = _localStream;
    onLocalStreamAdded?.call();
    await _join();
    log("Joining Complete!");
    socket.on(
      'addPeer',
      (config) {
        log("Got a new peer request from ${config['peer_id']} with userdata: ${config['userdata']}");
        try {
          _addPeer(
            peerId: config['peer_id'],
            should_create_offer: config['should_create_offer'],
            userdata: config['userdata'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: addPeer: $e");
        }
      },
    );
    socket.on(
      'sessionDescription',
      (config) {
        try {
          sessionDescription(
            peerId: config['peer_id'],
            session_description: config['session_description'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: sessionDescription: $e");
        }
      },
    );
    socket.on(
      'iceCandidate',
      (config) {
        try {
          iceCandidate(
            config['peer_id'],
            config['ice_candidate'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: iceCandidate: $e");
        }
      },
    );
    socket.on(
      'removePeer',
      (config) {
        try {
          removePeer(
            config['peer_id'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: removePeer: $e");
        }
      },
    );
  }

  Future<void> _join() async {
    log("Emiting Join room $roomId");
    socket.emit('join', {
      'userdata': currentUser,
      'channel': roomId,
    });
  }

  destroyRoom() {
    for (final peerId in _peers.keys) {
      socket.emit('part', {
        "channel": roomId,
        "peer_id": peerId,
      });
    }
    disconnect();
    socket.disconnect();
    socket.close();
    _localRTCVideoRenderer.dispose();
    for (final peerId in _remoteRTCVideoRenderers.entries) {
      _remoteRTCVideoRenderers[peerId.key]!.dispose();
    }
    _remoteRTCVideoRenderers.clear();
    for (final peerId in _peers.entries) {
      _peers[peerId.key]!.close();
    }
    _peers.clear();
  }

  Widget buildWidget(BuildContext context) {
    final List<dynamic> usersData = [];
    final List<RTCVideoView> videoViews = [];
    // [
    //   for (final peer in _remoteRTCVideoRenderers.entries)
    //     RTCVideoView(
    //       _remoteRTCVideoRenderers[peer.key]!,
    //       objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    //     ),
    // ];
    for (final peer in _peersData.keys) {
      usersData.add(_peersData[peer] ?? {});
      if (_remoteRTCVideoRenderers[peer] != null) {
        videoViews.add(RTCVideoView(
          _remoteRTCVideoRenderers[peer]!,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ));
      }
    }
    return WillPopScope(
      onWillPop: () async {
        if (await askUser(context, 'Do you really want to exit the room?',
                yes: true, no: true) !=
            'yes') {
          return true;
        }
        await onExit?.call();
        socket.disconnect();
        socket.close();
        return true;
      },
      child: builder(
        context,
        roomId,
        usersData,
        videoViews,
        currentUser,
        RTCVideoView(
          _localRTCVideoRenderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          mirror: true,
        ),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                _isVideoOn ? Icons.videocam : Icons.videocam_off,
              ),
              onPressed: () {
                _isVideoOn = !_isVideoOn;
                _toggleCamera(_isVideoOn);
              },
            ),
            IconButton(
              icon: Icon(
                _isAudioOn ? Icons.mic : Icons.mic_off,
              ),
              onPressed: () {
                _isAudioOn = !_isAudioOn;
                _toggleMic(_isAudioOn);
              },
            ),
            IconButton(
              icon: Icon(
                _isFrontCameraSelected ? Icons.camera_front : Icons.camera_rear,
              ),
              onPressed: () {
                _isFrontCameraSelected = !_isFrontCameraSelected;
                _switchCamera(_isFrontCameraSelected);
              },
            ),
            IconButton(
              onPressed: () {
                socket.disconnect();
                socket.close();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.call_end_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addPeer({
    required String peerId,
    required bool should_create_offer,
    required Map<String, dynamic> userdata,
  }) async {
    log("Adding peer: $peerId");
    if (_peers.containsKey(peerId)) {
      log("Already have a connection with id: $peerId");
      return;
    }
    _peers.addEntries(
      [
        MapEntry(
          peerId,
          (await createPeerConnection({
            'iceServers': [
              {
                'urls': [
                  'stun:stun1.l.google.com:19302',
                  // 'stun:stun2.l.google.com:19302'
                ]
              }
            ]
          })),
        ),
      ],
    );
    _peersData.addAll({peerId: userdata});

    log("Created local peer connection object peerId: $peerId");
    _peers[peerId]!.onIceCandidate = (RTCIceCandidate candidate) {
      socket.emit('relayICECandidate', {
        'peer_id': peerId,
        'ice_candidate': {
          'sdpMLineIndex': candidate.sdpMLineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate
        }
      });
    };

    _peers[peerId]!.onTrack = (event) async {
      log("onTrack Called from peerId: $peerId");
      if (!_remoteRTCVideoRenderers.containsKey(peerId)) {
        _remoteRTCVideoRenderers.addAll({
          peerId: RTCVideoRenderer(),
        });
        await _remoteRTCVideoRenderers[peerId]!.initialize().then((value) {
          _remoteRTCVideoRenderers[peerId]!.srcObject = event.streams[0];
        });
      } else {
        _remoteRTCVideoRenderers[peerId]!.srcObject = event.streams[0];
      }
      onRemoteStreamAdded?.call();
    };

    _localStream!.getTracks().forEach((track) {
      _peers[peerId]!.addTrack(track, _localStream!);
    });

    if (should_create_offer) {
      log("Creating RTC offer to $peerId");
      RTCSessionDescription offer = await _peers[peerId]!.createOffer();
      log("Local offer description is: $offer");
      await _peers[peerId]!.setLocalDescription(offer);
      log("sending this offer: ${offer.toMap()}");
      socket.emit('relaySessionDescription',
          {'peer_id': peerId, 'session_description': offer.toMap()});
      log("Offer setLocalDescription succeeded");
    }
  }

  Future<void> sessionDescription(
      {required peerId, required dynamic session_description}) async {
    final peer = _peers[peerId]!;
    final remoteDescription = session_description;
    // log("got session_description = ${session_description} for $peer_id");
    final desc = RTCSessionDescription(
        remoteDescription['sdp'], remoteDescription['type']);
    await peer.setRemoteDescription(desc);
    log("setRemoteDescription succeeded");

    if (remoteDescription['type'] == "offer") {
      log("Creating answer");
      RTCSessionDescription answer = await peer.createAnswer();
      log("Answer description is: $answer");
      await peer.setLocalDescription(answer);
      log("Sending SDP answer");
      socket.emit('relaySessionDescription',
          {'peer_id': peerId, 'session_description': answer.toMap()});
      log("Answer setLocalDescription succeeded");
    }
    log("Description Object: $desc");
    log("Session Description succeeded");
  }

  Future<void> iceCandidate(String peerId, iceCandidate) async {
    final peer = _peers[peerId]!;
    log("sending ice_candidate = $iceCandidate");
    await peer.addCandidate(
      // Yahan hai error
      RTCIceCandidate(
        iceCandidate['candidate'],
        iceCandidate['sdpMid'],
        iceCandidate['sdpMLineIndex'],
      ),
    );
    log("addIceCandidate succeeded");
  }

  Future<void> removePeer(String peerId) async {
    log("Removing peer: $peerId");
    if (_remoteRTCVideoRenderers.containsKey(peerId)) {
      _remoteRTCVideoRenderers[peerId]!.dispose();
      _remoteRTCVideoRenderers.remove(peerId);
    }
    if (_peers.containsKey(peerId)) {
      _peers[peerId]!.close();
      _peers.remove(peerId);
    }
    if (_peersData.containsKey(peerId)) {
      _peersData.remove(peerId);
    }
    onRemoteRemoved?.call();
    log("Removing peer succeeded");
  }

  _toggleMic(bool value) {
    _isAudioOn = value;
    log("Audio set to $value");
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = _isAudioOn;
    });
  }

  _toggleCamera(bool value) {
    _isVideoOn = value;
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = _isVideoOn;
    });
  }

  _switchCamera(bool value) {
    _isFrontCameraSelected = value;
    _localStream?.getVideoTracks().forEach((track) {
      track.switchCamera();
    });
  }

  void disconnect() async {
    log("Disconnected from signaling server");
    for (final peerId in _peers.entries) {
      _peers[peerId.key]!.close();
    }
    _peers.clear();
    for (final peerId in _remoteRTCVideoRenderers.entries) {
      _remoteRTCVideoRenderers[peerId.key]!.dispose();
    }
    _remoteRTCVideoRenderers.clear();
    onDisconnect?.call();
  }
}
