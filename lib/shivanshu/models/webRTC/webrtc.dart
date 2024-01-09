import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/user_model.dart';

/*
  usage: Create an object of WebRTCRoom
  first make sure to call, connectToServer
  and then call builder to get the widget
*/

class WebRTCRoom {
  String? roomId;
  late Socket socket;
  Function()? onConnect;
  Function()? onConnectError;
  Function()? onLocalStreamAdded;
  Function()? onRemoteStreamAdded;
  Function()? onRemoteRemoved;
  Function()? onDisconnect;
  Function(dynamic data)? onReceiveMsg;
  Function()? onExit;
  Function(List<String?> seats)? onSeatsChanged;
  Function(List<UserModel> users)? onUsersChanged;

  Widget Function(
    BuildContext context,
    String roomId,
    List<dynamic> usersData,
    List<RTCVideoView> videoViews,
    dynamic myUserData,
    RTCVideoView myVideoView,
  )? builder;

  WebRTCRoom._();

  static final instance = WebRTCRoom._();

  final Map<String, dynamic> _peersData = {};
  final _localRTCVideoRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  final Map<String, RTCPeerConnection> _peers = {};
  final Map<String, RTCVideoRenderer> _remoteRTCVideoRenderers = {};
  bool isAudioOn = true, isVideoOn = true, isFrontCameraSelected = true;

  void connectToServer(
    String roomId,
  ) {
    this.roomId = roomId;
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

  void _onConnect(data) async {
    log("Socket connected | data: $data");
    await _localRTCVideoRenderer.initialize();
    await _initLocalStream();
    await onConnect?.call();
  }

  Future<void> _initLocalStream() async {
    log("Initializing local stream");
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
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
          _sessionDescription(
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
          _removePeer(
            config['peer_id'],
          );
        } catch (e) {
          log("ERRRROOOORRRR: removePeer: $e");
        }
      },
    );
    socket.on('broadcastMsg', _broadCastMsg);
    socket.on('seatsChanged', _onSeatsChanged);
    socket.on('receiveUsers', _onReceiveUsers);
  }

  Future<void> _join() async {
    log("Emiting Join room $roomId");
    socket.emit('join', {
      'userdata': currentUser.toJson(),
      'channel': roomId,
    });
  }

  Widget build(BuildContext context) {
    assert(roomId != null);
    assert(builder != null);
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
    return builder!.call(
      context,
      roomId!,
      usersData,
      videoViews,
      currentUser.toJson(),
      RTCVideoView(
        _localRTCVideoRenderer,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: true,
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
                  'stun:stun2.l.google.com:19302'
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
        await _remoteRTCVideoRenderers[peerId]!.initialize();
        log("event.streams.length: ${event.streams.length}");
        _remoteRTCVideoRenderers[peerId]!.srcObject = event.streams[0];
      } else {
        await _remoteRTCVideoRenderers[peerId]!.initialize();
        _remoteRTCVideoRenderers[peerId]!.srcObject = event.streams[0];
      }
      log("7-END");
      onRemoteStreamAdded?.call();
      log("8-END");
      log("isAudioOn($peerId) = ${_remoteRTCVideoRenderers[peerId]!.muted}");
    };

    _localStream!.getTracks().forEach((track) {
      _peers[peerId]!.addTrack(track, _localStream!);
    });

    if (should_create_offer) {
      log("Creating RTC offer to $peerId");
      await _peers[peerId]!.restartIce();
      RTCSessionDescription offer = await _peers[peerId]!.createOffer();
      log("Local offer description is: $offer");
      await _peers[peerId]!.setLocalDescription(offer);
      log("sending this offer: ${offer.toMap()}");
      socket.emit('relaySessionDescription',
          {'peer_id': peerId, 'session_description': offer.toMap()});
      log("Offer setLocalDescription succeeded");
    }
  }

  Future<void> _sessionDescription(
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

  Future<void> _removePeer(String peerId) async {
    log("Removing peer: $peerId");
    if (_remoteRTCVideoRenderers.containsKey(peerId)) {
      _remoteRTCVideoRenderers[peerId]!.dispose();
      _remoteRTCVideoRenderers.remove(peerId);
    }
    if (_peers.containsKey(peerId)) {
      _peers[peerId]!.close();
      _peers[peerId]!.dispose();
      _peers[peerId]!.restartIce();
      _peers.remove(peerId);
    }
    if (_peersData.containsKey(peerId)) {
      _peersData.remove(peerId);
    }
    onRemoteRemoved?.call();
    log("Removing peer succeeded");
  }

  toggleMic(bool value) {
    isAudioOn = value;
    log("Audio set to $value");
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    sendMessage("", roomId!, {'isAudioOn': isAudioOn});
  }

  toggleCamera(bool value) {
    isVideoOn = value;
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
  }

  switchCamera(bool value) {
    isFrontCameraSelected = value;
    _localStream?.getVideoTracks().forEach((track) {
      track.switchCamera();
    });
  }

  void sendMessage(String? msg, String roomId, [Map<String, dynamic>? data]) {
    log("Sending msg: $msg with roomID: $roomId with data: $data");
    socket.emit('message', {
      'channel': roomId,
      'message': msg,
      'data': json.encode(data),
    });
  }

  void _broadCastMsg(data) {
    log("Received a broadcast msg: $data");
    onReceiveMsg?.call(data);
    if (onReceiveMsg == null) {
      log("Warning: you received a broadcast msg, but there are no handlers to handle it. Use WebRTCRoom.instance.onReceiveMsg = (data) => {...} to handle it.");
    }
  }

  void disconnect() async {
    try {
      log("Disconnected from signaling server");
      _localStream?.getTracks().forEach((element) async {
        await element.stop();
      });
      await _localStream?.dispose();
      _localStream = null;
      _peers.clear();
      for (final entry in _remoteRTCVideoRenderers.entries) {
        entry.value.srcObject?.getTracks().forEach((track) {
          track.stop();
        });
      }
      for (final peerId in _peers.entries) {
        _peers[peerId.key]!.close();
      }
      roomId = null;
      socket.off('broadcastMsg', _broadCastMsg);
      socket.close();
      socket.onReconnect((data) {
        log("Socket was reconnected!");
      });
      for (final peerId in _peers.entries) {
        _peers[peerId.key]!.close();
        _peers[peerId.key]!.dispose();
        _peers[peerId.key]!.restartIce();
        _peers.remove(peerId);
        _remoteRTCVideoRenderers[peerId]?.dispose();
        _remoteRTCVideoRenderers.remove(peerId);
        _peersData.remove(peerId);
      }
      _remoteRTCVideoRenderers.clear();
      _peers.clear();
      onDisconnect?.call();
    } catch (e) {
      log("Error Disconnecting: $e");
    }
  }

  void inviteUser(String userId, int seat) async {
    assert(roomId != null && roomId!.isNotEmpty,
        "Id shouldn't be empty when inviting a user");
    assert(seat < 8 && seat >= 0);
    socket.emit('inviteUser', {
      'userId': userId,
      'channel': roomId,
      'seat': seat,
    });
  }

  void _onSeatsChanged(data) async {
    log("Seats changed: $data");
    final seats = data['seats'] == null
        ? List.generate(8, (index) => null)
        : List<String?>.from(data['seats']);
    onSeatsChanged?.call(seats);
  }

  void getSeats() {
    socket.emit('getSeats', {
      'channel': roomId,
    });
  }

  Completer<List<UserModel>> completer = Completer();

  Future<List<UserModel>> getUsers() async {
    completer = Completer();
    socket.emit('getUsers', {'channel': roomId});
    return completer.future;
  }

  void _onReceiveUsers(data) async {
    log("Received users: $data");
    final users = List<UserModel>.from(
        data['users'].map((e) => UserModel.fromJson(e)).toList());
    completer.complete(users);
    onUsersChanged?.call(users);
  }

  void addAudioStream(MediaStream mediaStream) {
    mediaStream.getTracks().forEach((track) {
      log("Adding Stream Track: $track");
      // _peers.forEach((key, value) {
      //   value.removeStream(_localStream!);
      // });
      // _localStream!.getAudioTracks().forEach((element) {
      //   _localStream!.removeTrack(element);
      // });
      // _localStream!.addTrack(track);
      mediaStream.getTracks().forEach((track) {
        _peers.forEach((key, value) {
          value.addTrack(track, mediaStream);
        });
      });
    });
  }
}
