import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/chat/widgets/indicative_message.dart';
import 'package:spinner_try/chat/widgets/message.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';

// ignore: must_be_immutable
class MessageList extends StatefulWidget {
  ChatData chat;
  MessageList({super.key, required this.chat});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  late StreamSubscription<RemoteMessage> subscription;
  @override
  void initState() {
    super.initState();
    subscription = FirebaseMessaging.onMessage.listen(addMsg);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void addMsg(RemoteMessage message) {
    log("FCM foreground message received: ${message.data}");
    final messageData = message.data['message'];
    final msg = MessageData.fromJson(jsonDecode(messageData));
    if (msg.chatId == widget.chat.id) {
      widget.chat.messages.insert(0, msg);
      if (context.mounted) {
        setState(() {});
      }
    }
  }

  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    // TODO: add more functionality like edit a message and send messages in reference to other messages
    return FutureBuilder(
      key: ValueKey('messageList: ${widget.chat.id}'),
      future: _loaded
          ? () async {
              return widget.chat.messages;
            }()
          : fetchMessages(widget.chat.id, null, null),
      builder: (context, snapshot) {
        log("Message list was rebuilt");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicatorRainbow());
        }

        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Send your first message',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        widget.chat.messages = snapshot.data!.map((e) => e).toList();
        _loaded = true;
        // widget.chat.messages = widget.chat.messages.reversed.toList();
        for (final msg in widget.chat.messages) {
          if (msg.readBy.contains(currentUser.id)) break;
          addMeInReadBy(widget.chat, msg);
        }
        return ListView.separated(
          reverse: true,
          shrinkWrap: true,
          separatorBuilder: (ctx, index) {
            if (index == widget.chat.messages.length - 1) return Container();
            final msg = widget.chat.messages[index];
            DateTime createdAt = msg.createdAt;
            final nextMsg = widget.chat.messages[index + 1];

            if (!_sameDay(nextMsg.createdAt, msg.createdAt)) {
              return _dateWidget(createdAt);
            }

            return SizedBox(
              height: nextMsg.from != msg.from ||
                      !_sameDay(msg.createdAt, nextMsg.createdAt)
                  ? 10
                  : 1,
            );
          },
          itemBuilder: (ctx, index) {
            if (index == widget.chat.messages.length) {
              final msg = widget.chat.messages[index - 1];
              DateTime createdAt = msg.createdAt;
              return _dateWidget(createdAt);
            }
            final msg = widget.chat.messages[index];
            final nextMsg = index == widget.chat.messages.length - 1
                ? null
                : widget.chat.messages[index + 1];
            final preMsg = index == 0 ? null : widget.chat.messages[index - 1];
            final first = nextMsg == null ||
                nextMsg.from != msg.from ||
                !_sameDay(msg.createdAt, nextMsg.createdAt);
            return Message(
              chat: widget.chat,
              msg: msg,
              last: preMsg == null ||
                  preMsg.from != msg.from ||
                  !_sameDay(msg.createdAt, preMsg.createdAt),
              first: first,
              msgAlignment: msg.from == currentUser.id,
            );
          },
          itemCount: widget.chat.messages.length + 1,
        );
      },
    );
  }

  bool _sameDay(DateTime a, DateTime b) {
    return !(a.day != b.day || a.month != b.month || a.year != b.year);
  }

  Widget _dateWidget(DateTime createdAt) {
    return IndicativeMessage(txt: ddmmyyyy(createdAt));
  }
}
