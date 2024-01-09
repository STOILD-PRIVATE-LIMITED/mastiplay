import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:spinner_try/shivanshu/models/momets/tag.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/screens/searched_posts.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/widgets/scroll_builder.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({super.key});

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  TextEditingController mindCotroller = TextEditingController();
  List<String> chosenTags = [];

  String searchValue = "";

  final TextEditingController _tagController = TextEditingController();

  bool chooseUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ElevatedBackButton(),
      ),
      body: Column(
        children: [
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
              setState(() {});
            },
            decoration: InputDecoration(
              prefixText: "#",
              suffixIcon: IconButton(
                onPressed: () {
                  navigatorPush(context, SearchedPosts(chosenTags: chosenTags));
                },
                icon: const Icon(Icons.search),
              ),
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
          Expanded(
            // height: 300,
            child: ScrollBuilder2<Tag>(
              key: ValueKey("search:$searchValue"),
              loader: (start, Tag? lastTag) async {
                final list = await getTags(lastTag?.createdAt);
                list.removeWhere(
                    (element) => !element.tag.contains(searchValue));
                setState(() {});
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
