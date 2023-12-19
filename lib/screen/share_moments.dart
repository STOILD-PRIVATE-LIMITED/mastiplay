import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

class ShareMoments extends StatefulWidget {
  const ShareMoments({super.key});

  @override
  State<ShareMoments> createState() => _ShareMomentsState();
}

class _ShareMomentsState extends State<ShareMoments> {
  TextEditingController mindCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: height / 20, horizontal: width / 20),
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
                        Container(
                          margin: EdgeInsets.only(top: height / 25),
                          height: height / 200,
                          width: width / 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height / 100, horizontal: width / 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                        fontSize: height / 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height / 10,
                width: width / 4,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: height / 100, horizontal: width / 20),
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Icon(
                  Icons.add,
                  size: height / 40,
                ),
              ),
            ),
            TextField(
              controller: mindCotroller,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                hintStyle: TextStyle(
                  fontSize: height / 50,
                  color: Colors.black45,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width / 30,
                  vertical: height / 10,
                ),
              ),
              minLines: 1,
              maxLines: 5,
            ),
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
            SizedBox(
              height: height / 50,
            ),
            Container(
              width: width / 2.3,
              padding: EdgeInsets.symmetric(
                  vertical: height / 100, horizontal: width / 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.add_location,
                        size: height / 80,
                      ),
                    ),
                    TextSpan(
                      text: '  Do not show location',
                      style: TextStyle(
                        fontSize: height / 80,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  OctIcons.hash_16,
                  color: Colors.grey,
                ),
                Icon(OctIcons.alert_16, color: Colors.grey),
                Icon(Icons.image, color: Colors.grey),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            const ListTile(
              leading: Icon(Icons.search),
              title: Text('More hot topics'),
              subtitle: Text("Subtitle of this hot topics will be added"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: Icon(OctIcons.hash_16),
                    title: Text('Topic'),
                    trailing: Icon(Icons.circle),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
