import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spinner_try/chat/widgets/message_input_field.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';
import 'package:spinner_try/shivanshu/models/momets/post.dart';
import 'package:spinner_try/shivanshu/models/momets/tag.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/image.dart';
import 'package:spinner_try/shivanshu/utils/profile_image.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class EditPost extends StatefulWidget {
  final Post post;
  final Future<void> Function(Post post) onPost;
  const EditPost({super.key, required this.post, required this.onPost});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController mindCotroller = TextEditingController();
  File? img;

  List<String> chosenTags = [];

  String searchValue = "";

  bool showAddButton = false;

  final TextEditingController _tagController = TextEditingController();

  final _titleController = TextEditingController();

  bool chooseUser = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
    // TODO: add a taging feature
    // mindCotroller.addListener(() {
    //   if (mindCotroller.text.isNotEmpty &&
    //       mindCotroller.text.lastIndexOf('@') ==
    //           mindCotroller.text.length - 1) {
    //     setState(() {
    //       chooseUser = true;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    mindCotroller.clear();
    super.dispose();
  }

  Future<void> submit() async {
    if (mindCotroller.text.isEmpty) {
      showMsg(context, 'Please enter some text');
      return;
    }
    widget.post.description = mindCotroller.text;
    widget.post.tags = chosenTags;
    widget.post.title = _titleController.text;
    widget.post.imgUrl = await uploadImage(context, img, "posts",
        "${DateTime.now()}${Random().nextInt(100000)}.jpg");
    try {
      await widget.onPost(widget.post);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: height / 20, left: width / 20, right: width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Share Moments',
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                          InkWell(
                            onTap: submit,
                            child: Container(
                              margin: EdgeInsets.only(top: height / 25),
                              height: height / 200,
                              width: width / 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Post'),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: height / 100, horizontal: width / 20),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Colors.black,
                  //   ),
                  //   child: Text(
                  //     'Post',
                  //     style: TextStyle(
                  //         fontSize: height / 70,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //         letterSpacing: 2),
                  //   ),
                  // )
                ],
              ),
              // TextField(
              //   controller: _titleController,
              //   onChanged: (value) {
              //     widget.post.title = value.trim();
              //   },
              //   decoration: InputDecoration(
              //     prefixText: "#",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(
              //       horizontal: 15,
              //       vertical: 15,
              //     ),
              //     hintText: "Title",
              //   ),
              // ),
              SizedBox(height: height / 50),
              InkWell(
                onTap: () async {
                  final String? source = await askUser(
                      context, 'Where to take your photo from?',
                      custom: {
                        'gallery': const Icon(Icons.photo_rounded),
                        'camera': const Icon(Icons.photo_camera_rounded),
                      });
                  if (source == null) return;
                  ImagePicker()
                      .pickImage(
                    source: source == 'camera'
                        ? ImageSource.camera
                        : ImageSource.gallery,
                    preferredCameraDevice: CameraDevice.front,
                  )
                      .then((value) async {
                    if (value == null) return;
                    final file = await cropImage(context, File(value.path));
                    setState(() => img = file == null ? null : File(file.path));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[400],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: img != null
                      ? Image.file(img!, fit: BoxFit.cover)
                      : widget.post.imgUrl != null
                          ? Image.network(widget.post.imgUrl!,
                              fit: BoxFit.cover)
                          : SizedBox(
                              height: width / 4,
                              width: width / 4,
                              child: Icon(
                                Icons.add_a_photo,
                                size: height / 40,
                              ),
                            ),
                ),
              ),
              SizedBox(height: height / 50),
              if (chooseUser)
                Container(
                  // padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      height: 40,
                      width: 40,
                      child: ProfileImage(user: currentUser),
                    ),
                    title: Text(
                      'Shivanshu Gupta',
                      style: textTheme(context).bodyMedium,
                    ),
                  ),
                ),
              MessageInputField(
                minLines: 5,
                hintText: "What is on your mind?",
                showImage: false,
                showSend: false,
                initialValue: widget.post.description,
                controller: mindCotroller,
                onSubmit: (msg) async {
                  await submit();
                },
              ),
              // TextField(
              //   controller: mindCotroller,
              //   decoration: InputDecoration(
              //     hintText: 'What\'s on your mind?',
              //     hintStyle: TextStyle(
              //       fontSize: height / 50,
              //       color: Colors.black45,
              //     ),
              //     contentPadding: EdgeInsets.symmetric(
              //       horizontal: width / 30,
              //       vertical: height / 10,
              //     ),
              //   ),
              //   minLines: 1,
              //   maxLines: 5,
              // ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Add #tag',
              //         style: TextStyle(
              //           fontSize: height / 50,
              //           color: Colors.black45,
              //         ),
              //       ),
              //       TextSpan(
              //         text: 'Add @mention',
              //         style: TextStyle(
              //           fontSize: height / 50,
              //           color: Colors.black45,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: height / 50),
              // Container(
              //   width: width / 2.3,
              //   padding: EdgeInsets.symmetric(
              //       vertical: height / 100, horizontal: width / 20),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: Colors.black12,
              //   ),
              //   alignment: Alignment.center,
              //   child: RichText(
              //     text: TextSpan(
              //       children: [
              //         WidgetSpan(
              //           child: Icon(
              //             Icons.add_location,
              //             size: height / 80,
              //           ),
              //         ),
              //         TextSpan(
              //           text: '  Do not show location',
              //           style: TextStyle(
              //             fontSize: height / 80,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: height / 50,
              // ),
              // const Divider(
              //   color: Colors.grey,
              // ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Icon(
              //       OctIcons.hash_16,
              //       color: Colors.grey,
              //     ),
              //     Icon(OctIcons.alert_16, color: Colors.grey),
              //     Icon(Icons.image, color: Colors.grey),
              //   ],
              // ),
              // SizedBox(
              //   height: height / 50,
              // ),
              // const ListTile(
              //   leading: Icon(Icons.search),
              //   title: Text('More hot topics'),
              //   subtitle: Text("Subtitle of this hot topics will be added"),
              //   trailing: Icon(Icons.arrow_forward_ios),
              // ),
              SizedBox(height: height / 50),
              // Center(
              //   child: Text(
              //     "Tags",
              //     style: textTheme(context).titleLarge,
              //   ),
              // ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceAround,
                spacing: 5,
                runSpacing: 5,
                children: chosenTags
                    .map(
                      (tag) => GestureDetector(
                        onTap: () {
                          setState(() {
                            chosenTags.remove(tag);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1,
                          ),
                          child: Text(
                            tag.toString(),
                            style: textTheme(context)
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              // SizedBox(height: height / 50),
              TextField(
                controller: _tagController,
                onChanged: (value) {
                  value = value.trim();
                  value = value.replaceAll(' ', '');
                  value = value.replaceAll('#', '');
                  // _tagController.text = value;
                  searchValue = value;
                },
                onEditingComplete: () {
                  _tagController.text = _tagController.text.trim();
                  _tagController.text = _tagController.text.replaceAll(' ', '');
                  _tagController.text = _tagController.text.replaceAll('#', '');
                  searchValue = _tagController.text;
                  setState(() {
                    showAddButton = false;
                  });
                },
                decoration: InputDecoration(
                  prefixText: "#",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  hintText: "Search a tag",
                ),
              ),
              if (showAddButton && searchValue.isNotEmpty)
                TextButton(
                    key: ValueKey("create:$searchValue"),
                    onPressed: () {
                      toggleTag("#$searchValue");
                    },
                    child: Text('Create a new tag: \'$searchValue\'')),
              SizedBox(
                height: 300,
                child: ScrollBuilder2<Tag>(
                  key: ValueKey("search:$searchValue"),
                  loader: (start, Tag? lastTag) async {
                    final list = await getTags(lastTag?.createdAt);
                    list.removeWhere(
                        (element) => !element.tag.contains(searchValue));
                    setState(() {
                      if (lastTag == null) {
                        showAddButton = true;
                      } else {
                        showAddButton = true;
                      }
                    });
                    return list;
                  },
                  itemBuilder: (context, item) {
                    return ListTile(
                      onTap: () {
                        toggleTag(item.tag);
                      },
                      leading: const Icon(OctIcons.hash_16),
                      title: Text(item.tag.substring(1)),
                      trailing: chosenTags.contains(item.tag)
                          ? const Icon(Icons.check_circle_rounded)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleTag(String tag) {
    if (chosenTags.contains(tag)) {
      chosenTags.remove(tag);
    } else {
      chosenTags.add(tag);
    }
    setState(() {});
  }
}
