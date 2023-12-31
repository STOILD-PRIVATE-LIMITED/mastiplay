import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:spinner_try/chat/models/chat.dart';
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/chat/screens/image_preview.dart';
import 'package:spinner_try/chat/widgets/indicative_message.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';
import 'package:spinner_try/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Message extends StatelessWidget {
  final MessageData msg;
  final ChatData chat;
  final bool first, last;
  final bool msgAlignment;

  const Message({
    super.key,
    required this.msg,
    required this.first,
    required this.last,
    required this.msgAlignment,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    double r = 13;
    final size = MediaQuery.of(context).size;

    return msg.indicative
        ? IndicativeMessage(
            txt: msg.txt,
          )
        : Wrap(
            alignment: !msgAlignment ? WrapAlignment.start : WrapAlignment.end,
            // mainAxisSize: MainAxisSize.min,
            children: [
              if (!msgAlignment)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FutureBuilder(
                    future: fetchUserWithId(msg.from),
                    builder: (ctx, snapshot) {
                      final userData =
                          !snapshot.hasData ? UserModel() : snapshot.data!;
                      return GestureDetector(
                        onTap: userData.photo.isEmpty
                            ? null
                            : () {
                                showUserPreview(context, userData);
                              },
                        child: CircleAvatar(
                          backgroundImage: userData.photo.isEmpty
                              ? null
                              : CachedNetworkImageProvider(userData.photo),
                          radius: 10,
                          child: userData.photo.isNotEmpty
                              ? null
                              : const Icon(
                                  Icons.person_rounded,
                                  size: 10,
                                ),
                        ),
                      );
                    },
                  ),
                ).animate().slideX(),
              GestureDetector(
                key: ValueKey(msg.id),
                onTap: () => showMsgInfo(context, msg),
                onLongPress: () => showInfo(context, msg),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 100,
                    maxWidth: size.width - 100,
                    // maxHeight: size.height * 0.5,
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(first && !msgAlignment ? 0 : r),
                      topRight: Radius.circular(first && msgAlignment ? 0 : r),
                      bottomLeft: Radius.circular(r),
                      bottomRight: Radius.circular(r),
                    ),
                    color: msgAlignment
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                        : Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (first && msg.from != currentUser.id)
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5.0, left: 1, top: 2),
                              child: FutureBuilder(
                                future: fetchUserWithId(msg.from),
                                builder: (context, snapshot) {
                                  final userData = !snapshot.hasData
                                      ? UserModel()
                                      : snapshot.data!;
                                  return GestureDetector(
                                    onTap: () {
                                      showUserPreview(context, userData);
                                    },
                                    child: Text(
                                      userData.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (msg.deletedAt == null)
                            MarkdownBody(
                              fitContent: true,
                              data: msg.txt,
                              selectable: true,
                              onTapText: () => showMsgInfo(context, msg),
                              onTapLink: (text, href, title) {
                                if (href != null) launchUrl(Uri.parse(href));
                              },
                              imageBuilder: (uri, title, alt) =>
                                  ImageBuilder(uri: uri, id: msg.id),
                            )
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.not_interested_rounded,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  msg.from == auth.currentUser!.email
                                      ? 'You deleted this message.'
                                      : 'This message was deleted.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20)
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                timeFrom(msg.createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              const SizedBox(width: 4),
                              if (msgAlignment)
                                Icon(
                                  msg.readBy.containsAll(chat.participants) &&
                                          msg.readBy.contains(currentUser.id!)
                                      ? Icons.done_all_rounded
                                      : Icons.done_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 15,
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ).animate().fade().slideX(
                      begin: msgAlignment ? 1 : -1,
                      end: 0,
                      curve: Curves.decelerate,
                    ),
              ),
            ],
          );
  }

  showMsgInfo(context, MessageData msg) {
    if (!isImage(msg) || msg.deletedAt != null) {
      showInfo(context, msg);
    } else {
      String url = msg.txt.split('(').last;
      url = url.substring(0, url.length - 1);
      navigatorPush(
        context,
        ImagePreview(
            image: ImageBuilder(uri: Uri.parse(url), id: msg.id),
            delete: (msg.from == auth.currentUser!.email) ? delMsg : null,
            copy: copyMsg,
            info: (context) => showInfo(context, msg)),
      );
    }
  }

  void showInfo(context, MessageData msg) {
    Navigator.of(context).push(
      DialogRoute<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          scrollable: true,
          actionsPadding: const EdgeInsets.only(bottom: 15, top: 10),
          contentPadding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          content: LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                MarkdownBody(
                  data: msg.txt,
                  imageBuilder: (uri, title, alt) => ImageBuilder(
                      uri: uri, id: msg.id, title: title, alt: alt),
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          "From:",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              // color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          msg.from,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          "Created At:",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              // color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          "${ddmmyyyy(msg.createdAt)} | ${timeFrom(msg.createdAt)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          "Read By:",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              // color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          msg.readBy.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (msg.updatedAt != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Text(
                            "Modified At:",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                // color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          Text(
                            "${ddmmyyyy(msg.updatedAt!)} | ${timeFrom(msg.updatedAt!)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (msg.deletedAt != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deleted At:",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.red,
                                    ),
                          ),
                          Text(
                            "${ddmmyyyy(msg.deletedAt!)} | ${timeFrom(msg.deletedAt!)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () => copyMsg(context),
              icon: const Icon(Icons.copy_rounded),
            ),
            if (msg.from == auth.currentUser!.email && msg.deletedAt == null)
              IconButton(
                iconSize: 30,
                onPressed: () async {
                  Navigator.of(context).pop();
                  showMsg(context,
                      "Editing is not allowed as per the rules of the institute.");
                },
                icon: const Icon(Icons.edit_rounded),
              ),
            if (msg.from == auth.currentUser!.email)
              IconButton(
                iconSize: 30,
                onPressed: () => delMsg(context),
                icon: Icon(
                  msg.deletedAt == null
                      ? Icons.delete_rounded
                      : Icons.restore_from_trash_rounded,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> delMsg(BuildContext context) async {
    final String? res = await askUser(
      context,
      "Do you really wish to ${msg.deletedAt == null ? 'delete' : 'restore'} this msg?",
      yes: true,
      no: true,
    );
    if (res == "yes") {
      try {
        await deleteMessage(chat, msg);
      } catch (e) {
        if (context.mounted) {
          showMsg(context, e.toString());
        }
        return;
      }
      if (context.mounted) {
        showMsg(context,
            "Message ${msg.deletedAt != null ? 'Deleted' : 'Restored'} Successfully");
      }
      if (msg.deletedAt != null) {
        try {
          bool isImg = isImage(msg);
          if (isImg && context.mounted) {
            String? ans = await askUser(
              context,
              "Do you want to delete the image from cloud as well?",
              yes: true,
              no: true,
            );
            if (ans == "yes") {
              String url = msg.txt.split('(').last;
              url = url.substring(0, url.length - 1);
              await storage.refFromURL(url).delete();
              if (context.mounted) {
                showMsg(
                    context, "Image was deleted successfully from the cloud");
              }
            }
          }
        } catch (e) {
          if (context.mounted) {
            showMsg(context, e.toString());
          }
        }
      }
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> copyMsg(context) async {
    await Clipboard.setData(
        ClipboardData(text: msg.txt.replaceAll('\n\n', '\n')));
    if (context.mounted) {
      Navigator.of(context).pop();
      showMsg(context, "Copied");
    }
  }
}

class ImageBuilder extends StatelessWidget {
  final Uri uri;
  final String id;
  final String? title;
  final String? alt;
  const ImageBuilder({
    super.key,
    required this.uri,
    required this.id,
    this.title,
    this.alt,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: CachedNetworkImage(
        fadeInCurve: Curves.decelerate,
        fadeOutDuration: const Duration(milliseconds: 0),
        imageUrl: uri.toString(),
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const Icon(
            Icons.image_not_supported_rounded,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
