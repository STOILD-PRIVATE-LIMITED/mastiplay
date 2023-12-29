import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spinner_try/chat/models/message.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';

class MessageInputField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  late final TextEditingController controller;
  final int minLines;
  final bool showImage;
  final bool showSend;
  MessageInputField({
    super.key,
    required this.onSubmit,
    required this.initialValue,
    TextEditingController? controller,
    this.minLines = 1,
    this.showImage = true,
    this.showSend = true,
    this.hintText = "Enter your message here",
  }) {
    this.controller = controller ?? TextEditingController();
  }

  final Future<void> Function(MessageData msg) onSubmit;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final _formKey = GlobalKey<FormState>();

  String txt = "";

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
  }

  void submit(context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    widget.controller.text = "";
    txt = txt.replaceAll('\n', '\n\n');
    try {
      await widget.onSubmit(
        MessageData(
          chatId:
              "message_input_field.dart file mein chatID change nhi hui hai",
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          txt: txt,
          from: currentUser.id!,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      showMsg(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    const duration = Duration(milliseconds: 200);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: 10,
                  minLines: widget.minLines,
                  keyboardType: TextInputType.multiline,
                  contextMenuBuilder: contextMenuBuilder,
                  controller: widget.controller,
                  validator: Validate.text,
                  decoration: InputDecoration(
                    prefixIcon: !widget.showImage
                        ? null
                        : IconButton(
                            onPressed: () async {
                              final url = await getLocalImageOnCloud(context,
                                  fileName:
                                      "${DateTime.now().millisecondsSinceEpoch}.jpg");
                              if (url == null) return;
                              widget.controller.text = "![image]($url)";
                              // ignore: use_build_context_synchronously
                              submit(context);
                            },
                            icon:
                                const Icon(Icons.add_photo_alternate_outlined),
                            color: Theme.of(context).colorScheme.primary,
                          )
                            .animate()
                            .scaleXY(begin: 1.5, end: 1, duration: duration * 4)
                            .fade(duration: duration * 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    hintText: widget.hintText,
                  ),
                  onSaved: (value) => txt = value!.trim(),
                ).animate().fade(duration: duration * 4).then(),
              ),
              if (widget.showSend)
                IconButton(
                  onPressed: () => submit(context),
                  icon: const Icon(Icons.send_rounded),
                ).animate(delay: duration * 4).fade().slideX(
                      begin: -0.2,
                      end: 0,
                      duration: duration,
                    )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                IconButton(
                  onPressed: bold,
                  iconSize: 25,
                  icon: const Icon(Icons.format_bold_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: italic,
                  icon: const Icon(Icons.format_italic_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: makeTitle,
                  icon: const Icon(Icons.title_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: quote,
                  icon: const Icon(Icons.format_quote_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: codeBlock,
                  icon: const Icon(Icons.code_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: showLinkBox,
                  icon: const Icon(Icons.link_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: strikethrough,
                  icon: const Icon(Icons.format_strikethrough_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: addHrLine,
                  icon: const Icon(Icons.horizontal_rule_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: unorderedList,
                  icon: const Icon(Icons.format_list_bulleted_outlined)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
                IconButton(
                  onPressed: orderedList,
                  icon: const Icon(Icons.format_list_numbered_rounded)
                      .animate()
                      .then(delay: duration * i++)
                      .fade(duration: duration)
                      .slideY(
                          duration: duration,
                          curve: Curves.decelerate,
                          begin: -1,
                          end: 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      buttonItems.addAll(
        [
          ContextMenuButtonItem(
            label: 'Bold',
            onPressed: () {
              ContextMenuController.removeAny();
              bold();
            },
          ),
          ContextMenuButtonItem(
            label: 'Italic',
            onPressed: () {
              ContextMenuController.removeAny();
              italic();
            },
          ),
          ContextMenuButtonItem(
            label: 'Strikethrough',
            onPressed: () {
              ContextMenuController.removeAny();
              strikethrough();
            },
          ),
          ContextMenuButtonItem(
            label: 'Quote',
            onPressed: () {
              ContextMenuController.removeAny();
              quote();
            },
          ),
          ContextMenuButtonItem(
            label: 'Block',
            onPressed: () {
              ContextMenuController.removeAny();
              quote();
            },
          ),
          ContextMenuButtonItem(
            label: 'Make Title',
            onPressed: () {
              ContextMenuController.removeAny();
              makeTitle();
            },
          ),
        ],
      );
    }
    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: buttonItems,
    );
  }

  void bold() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}**${widget.controller.selection.textInside(widget.controller.text)}**${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void italic() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}*${widget.controller.selection.textInside(widget.controller.text)}*${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void strikethrough() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}~~${widget.controller.selection.textInside(widget.controller.text)}~~${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void unorderedList() {
    Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (ctx) => const AlertDialog(
          content: Text(
              "To make an unordered list, follow the below format:\n\n# Heading\n\n- List item 1.\n- List Item 2.\n- List Item 3.\n\n'-' can also be replaced by '*'"),
        ),
      ),
    );
  }

  void orderedList() {
    Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (ctx) => const AlertDialog(
          content: Text(
              'To make an ordered list, follow the below format:\n\n# Heading\n\n1. List item 1.\n1. List Item 2.\n1. List Item 3.'),
        ),
      ),
    );
  }

  void makeTitle() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}\n# ${widget.controller.selection.textInside(widget.controller.text)}\n${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void quote() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}\n> ${widget.controller.selection.textInside(widget.controller.text)}\n${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void codeBlock() {
    if (widget.controller.selection.end - widget.controller.selection.start >
        0) {
      widget.controller.text =
          "${widget.controller.selection.textBefore(widget.controller.text)}```${widget.controller.selection.textInside(widget.controller.text)}```${widget.controller.selection.textAfter(widget.controller.text)}";
    }
  }

  void showLinkBox() {
    Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (ctx) {
          String url = "";
          return AlertDialog(
            content: TextField(
              maxLines: null,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                  label: Text('Enter your link here'),
                  hintText: "https://www.google.com"),
              autocorrect: false,
              onChanged: (value) {
                url = value;
              },
              onSubmitted: (value) {
                addLink(value);
                Navigator.of(context).pop();
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  addLink(url);
                  Navigator.of(context).pop();
                },
                child: const Text('Insert'),
              ),
            ],
            titlePadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.only(bottom: 0, right: 20),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          );
        },
      ),
    );
  }

  void addLink(String url) {
    if (!url.startsWith("www.")) url = "www.$url";
    url = url.replaceAll(" ", '');
    var cursorPos = widget.controller.selection.base.offset;
    if (cursorPos == -1) {
      widget.controller.text = url;
      return;
    }
    String prefixText = widget.controller.text.substring(0, cursorPos);
    String suffixText = widget.controller.text.substring(cursorPos);
    int length = url.length + 2;
    widget.controller.text = "$prefixText $url $suffixText";

    widget.controller.selection = TextSelection(
      baseOffset: cursorPos + length,
      extentOffset: cursorPos + length,
    );
  }

  void addHrLine() {
    var cursorPos = widget.controller.selection.base.offset;
    if (cursorPos == -1) {
      widget.controller.text = "---\n";
      return;
    }
    String prefixText = widget.controller.text.substring(0, cursorPos);
    String suffixText = widget.controller.text.substring(cursorPos);
    String iCode = '\n---\n';
    int length = iCode.length;
    widget.controller.text = prefixText + iCode + suffixText;

    widget.controller.selection = TextSelection(
      baseOffset: cursorPos + length,
      extentOffset: cursorPos + length,
    );
  }
}
