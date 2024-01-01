import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart';
// import 'package:wakelock/wakelock.dart';

// import 'package:spinner_try/android_wakelock.dart';
import 'package:spinner_try/shivanshu/utils.dart';
// import 'wakelock/android_wake_lock.dart';

// TODO: set this to some global server
// The below represents the server address of the server running the socket.io server
const String websocketUrl = "https://3.7.66.245:8080";
// const String websocketUrl = "https://192.168.9.64:8080";
// const String websocketUrl = "https://v9nm4hsv-8080.asse.devtunnels.ms";
Socket? socket;

class WebRtcController {
  WebRtcController({
    bool audio = true,
    bool video = false,
    bool isFrontCameraSelected = true,
  }) {
    _audio.value = audio;
    _video.value = video;
    _isFrontCameraSelected.value = isFrontCameraSelected;
  }
  final ValueNotifier<bool> _audio = ValueNotifier(false);
  bool get audio {
    return _audio.value;
  }

  set audio(value) {
    _audio.value = value;
  }

  final ValueNotifier<bool> _video = ValueNotifier(false);
  bool get video {
    return _video.value;
  }

  set video(value) {
    _video.value = value;
  }

  final ValueNotifier<bool> _isFrontCameraSelected = ValueNotifier(false);
  bool get isFrontCameraSelected {
    return _isFrontCameraSelected.value;
  }

  set isFrontCameraSelected(value) {
    _isFrontCameraSelected.value = value;
  }
}

class WebRTCWidget extends StatefulWidget {
  final dynamic userData;
  final WebRtcController? controller;
  final String roomId;
  final Widget Function(
    BuildContext context,
    String roomId,
    List<dynamic> usersData,
    List<RTCVideoView> videoViews,
    dynamic myUserData,
    RTCVideoView myVideoView,
    Widget controls,
  ) builder;
  final Future<void> Function()? onExit;

  const WebRTCWidget({
    super.key,
    required this.userData,
    required this.roomId,
    // this.showControls = false,
    this.controller,
    this.onExit,
    required this.builder,
  });

  @override
  State<WebRTCWidget> createState() => _WebRTCWidgetState();
}

class _WebRTCWidgetState extends State<WebRTCWidget> {
  final Map<String, dynamic> peersData = {};
  final _localRTCVideoRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  final Map<String, RTCPeerConnection> peers = {};
  final Map<String, RTCVideoRenderer> _remoteRTCVideoRenderers = {};

  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  Future<void> connectToServer() async {
    log("Connecting to socket on $websocketUrl");
    socket = io(
        websocketUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            // .setExtraHeaders({'Content-Type': 'application/json'})
            .disableAutoConnect()
            .build());

    // listen onConnect event
    socket!.onConnect((data) {
      log("Socket connected !!");
      _localRTCVideoRenderer.initialize().then((value) => initLocalStream());
      // Wakelock.enable();
      // AndroidWakeLock.acquireWakeLock();
    });

    socket!.on('disconnect', (data) => disconnect());

    // listen onConnectError event
    socket!.onConnectError((data) {
      log("Connect Error $data");
      showMsg(context, "Can't connect to server: $data");
      // if (context.mounted) {
      Navigator.of(context).pop();
      // }
    });

    // connect socket
    socket!.connect();
  }

  @override
  void initState() {
    super.initState();
    assert(widget.roomId.isNotEmpty, "RoomId can't be empty");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (socket != null) {
        log("Socket is already connected. That is why we aren't doing it again.");
      } else {
        connectToServer();
      }
      if (widget.controller != null) {
        isAudioOn = widget.controller!.audio;
        isVideoOn = widget.controller!.video;
        isFrontCameraSelected = widget.controller!.isFrontCameraSelected;
        widget.controller!._audio.addListener(() {
          _toggleMic(widget.controller!._audio.value);
        });
        widget.controller!._video.addListener(() {
          _toggleCamera(widget.controller!._video.value);
        });
        widget.controller!._isFrontCameraSelected.addListener(() {
          _switchCamera(widget.controller!._isFrontCameraSelected.value);
        });
      }
    });
  }

  @override
  void dispose() {
    if (socket != null) {
      socket!.disconnect();
      socket!.close();
      socket = null;
    }
    widget.controller?._audio.removeListener(() {});
    widget.controller?._video.removeListener(() {});
    widget.controller?._isFrontCameraSelected.removeListener(() {});
    // _localRTCVideoRenderer.dispose();
    for (final peerId in _remoteRTCVideoRenderers.entries) {
      // _remoteRTCVideoRenderers[peerId.key]!.dispose();
    }
    _remoteRTCVideoRenderers.clear();
    for (final peerId in peers.entries) {
      peers[peerId.key]!.close();
    }
    peers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> usersData = []; // = peersData;
    final List<RTCVideoView> videoViews = []; // [
    //   for (final peer in _remoteRTCVideoRenderers.entries)
    //     RTCVideoView(
    //       _remoteRTCVideoRenderers[peer.key]!,
    //       objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    //     ),
    // ];
    for (final peer in peersData.keys) {
      usersData.add(peersData[peer] ?? {});
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
        // Wakelock.disable();
        // await AndroidWakeLock.releaseWakeLock();
        await widget.onExit?.call();
        if (socket != null) {
          socket!.disconnect();
          socket!.close();
          socket = null;
        }
        return true;
      },
      child: widget.builder(
        context,
        widget.roomId,
        usersData,
        videoViews,
        widget.userData,
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
                isVideoOn ? Icons.videocam : Icons.videocam_off,
              ),
              onPressed: () {
                isVideoOn = !isVideoOn;
                _toggleCamera(isVideoOn);
              },
            ),
            IconButton(
              icon: Icon(
                isAudioOn ? Icons.mic : Icons.mic_off,
              ),
              onPressed: () {
                isAudioOn = !isAudioOn;
                _toggleMic(isAudioOn);
              },
            ),
            IconButton(
              icon: Icon(
                isFrontCameraSelected ? Icons.camera_front : Icons.camera_rear,
              ),
              onPressed: () {
                isFrontCameraSelected = !isFrontCameraSelected;
                _switchCamera(isFrontCameraSelected);
              },
            ),
            IconButton(
              onPressed: () {
                socket!.disconnect();
                socket!.close();
                socket = null;
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.call_end_rounded),
            ),
          ],
        ),
      ),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     GridView.count(
      //       shrinkWrap: true,
      //       physics: const NeverScrollableScrollPhysics(),
      //       crossAxisCount: math.sqrt(peers.length + 1).ceilToDouble().toInt(),
      //       childAspectRatio: widget.childAspectRatio,
      //       children: [
      //         widget.meBuilder(
      //           context,
      //           videoView: RTCVideoView(
      //             _localRTCVideoRenderer,
      //             objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      //           ),
      //           userData: widget.userData,
      //           roomId: widget.roomId,
      //         ),
      //         for (final peer in _remoteRTCVideoRenderers.entries)
      //           widget.userTileBuilder(
      //             context,
      //             videoView: RTCVideoView(
      //               _remoteRTCVideoRenderers[peer.key]!,
      //               objectFit:
      //                   RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      //             ),
      //             userData: peersData[peer.key],
      //             roomId: widget.roomId,
      //           )
      //       ],
      //     ),
    );
  }

  Future<void> initLocalStream() async {
    log("Initializing local stream");
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });
    _localRTCVideoRenderer.srcObject = _localStream;
    if (context.mounted) setState(() {});
    await join();
    log("Joining Complete!");
    socket!.on(
      'addPeer',
      (config) {
        log("Got a new peer request from ${config['peer_id']} with userdata: ${config['userdata']}");
        try {
          addPeer(
            peerId: config['peer_id'],
            should_create_offer: config['should_create_offer'],
            userdata: config['userdata'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: addPeer: $e");
        }
      },
    );
    socket!.on(
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
    socket!.on(
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
    socket!.on(
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

  Future<void> join() async {
    log("Emiting Join room ${widget.roomId}");
    socket!.emit('join', {
      'userdata': widget.userData,
      'channel': widget.roomId,
    });
  }

  Future<void> addPeer({
    required String peerId,
    required bool should_create_offer,
    required Map<String, dynamic> userdata,
  }) async {
    log("Adding peer: $peerId");
    if (peers.containsKey(peerId)) {
      log("Already have a connection with id: $peerId");
      return;
    }
    peers.addEntries(
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
    peersData.addAll({peerId: userdata});

    log("Created local peer connection object peerId: $peerId");
    peers[peerId]!.onIceCandidate = (RTCIceCandidate candidate) {
      socket!.emit('relayICECandidate', {
        'peer_id': peerId,
        'ice_candidate': {
          'sdpMLineIndex': candidate.sdpMLineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate
        }
      });
    };

    peers[peerId]!.onTrack = (event) async {
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
      if (context.mounted) setState(() {});
    };

    _localStream!.getTracks().forEach((track) {
      peers[peerId]!.addTrack(track, _localStream!);
    });

    if (should_create_offer) {
      log("Creating RTC offer to $peerId");
      RTCSessionDescription offer = await peers[peerId]!.createOffer();
      log("Local offer description is: $offer");
      await peers[peerId]!.setLocalDescription(offer);
      log("sending this offer: ${offer.toMap()}");
      socket!.emit('relaySessionDescription',
          {'peer_id': peerId, 'session_description': offer.toMap()});
      log("Offer setLocalDescription succeeded");
    }
  }

  Future<void> sessionDescription(
      {required peerId, required dynamic session_description}) async {
    final peer = peers[peerId]!;
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
      socket!.emit('relaySessionDescription',
          {'peer_id': peerId, 'session_description': answer.toMap()});
      log("Answer setLocalDescription succeeded");
    }
    log("Description Object: $desc");
    log("Session Description succeeded");
  }

  Future<void> iceCandidate(String peerId, iceCandidate) async {
    final peer = peers[peerId]!;
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
    if (peers.containsKey(peerId)) {
      peers[peerId]!.close();
      peers.remove(peerId);
    }
    if (peersData.containsKey(peerId)) {
      peersData.remove(peerId);
    }
    if (context.mounted) setState(() {});
    log("Removing peer succeeded");
  }

  _toggleMic(bool value) {
    // change status
    isAudioOn = value;
    log("Audio set to $value");
    // enable or disable audio track
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    if (context.mounted) setState(() {});
  }

  _toggleCamera(bool value) {
    // change status
    isVideoOn = value;

    // enable or disable video track
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    if (context.mounted) setState(() {});
  }

  _switchCamera(bool value) {
    // change status
    isFrontCameraSelected = value;

    // switch camera
    _localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
    });
    if (context.mounted) setState(() {});
  }

  void disconnect() async {
    // Wakelock.disable();

    // await AndroidWakeLock.releaseWakeLock();
    log("Disconnected from signaling server");
    for (final peerId in peers.entries) {
      peers[peerId.key]!.close();
    }
    peers.clear();
    for (final peerId in _remoteRTCVideoRenderers.entries) {
      _remoteRTCVideoRenderers[peerId.key]!.dispose();
    }
    _remoteRTCVideoRenderers.clear();
  }

  Future<void> destroyRoom() async {
    for (final peerId in peers.keys) {
      socket!.emit('part', {
        "channel": widget.roomId,
        "peer_id": peerId,
      });
    }
    disconnect();
  }
}
