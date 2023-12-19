import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/widgets/another_tab_view.dart';

class TrendingList extends StatefulWidget {
  int selectedTab = 0;

  TrendingList({super.key});
  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList>
    with TickerProviderStateMixin {
  final _pageView = PageController();
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: AnotherView(
            defaultSelected: widget.selectedTab,
            onTap: (index) {
              _pageView.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            key: UniqueKey(),
            items: [
              Text(
                'Rich',
                style: TextStyle(
                  fontSize: height / 60,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Creators',
                style: TextStyle(
                  fontSize: height / 60,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Room',
                style: TextStyle(
                  fontSize: height / 60,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Agency',
                style: TextStyle(
                  fontSize: height / 60,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ],
            selectedItems: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Rich',
                    style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 30),
                    height: height / 200,
                    width: width / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Creators',
                    style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 30),
                    height: height / 200,
                    width: width / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Room',
                    style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 30),
                    height: height / 200,
                    width: width / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Agency',
                    style: TextStyle(
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 30),
                    height: height / 200,
                    width: width / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: const [Icon(Icons.question_mark_rounded)],
        ),
        body: PageView(
          children: [
            Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    child: Text("Daily"),
                  ),
                  Tab(
                    child: Text("Weekly"),
                  ),
                ]),
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "This week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.blue[100],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Time")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height / 30,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: height / 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$index",
                                style: TextStyle(fontSize: height / 50),
                              ),
                              SizedBox(
                                width: width / 70,
                              ),
                              Icon(
                                Icons.person,
                                size: height / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: height / 50,
                                    ),
                                  ),
                                  Text(
                                    "Subtitle",
                                    style: TextStyle(
                                      fontSize: height / 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.diamond,
                                    color: Colors.red,
                                    size: height / 50,
                                  ),
                                ),
                                TextSpan(
                                  text: " 12334",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 50,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    child: Text("Daily"),
                  ),
                  Tab(
                    child: Text("Weekly"),
                  ),
                ]),
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "This week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.blue[100],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Time")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height / 30,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: height / 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$index",
                                style: TextStyle(fontSize: height / 50),
                              ),
                              SizedBox(
                                width: width / 70,
                              ),
                              Icon(
                                Icons.person,
                                size: height / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: height / 50,
                                    ),
                                  ),
                                  Text(
                                    "Subtitle",
                                    style: TextStyle(
                                      fontSize: height / 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.diamond,
                                    color: Colors.red,
                                    size: height / 50,
                                  ),
                                ),
                                TextSpan(
                                  text: " 12334",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 50,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    child: Text("Daily"),
                  ),
                  Tab(
                    child: Text("Weekly"),
                  ),
                ]),
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "This week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.blue[100],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Time")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height / 30,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: height / 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$index",
                                style: TextStyle(fontSize: height / 50),
                              ),
                              SizedBox(
                                width: width / 70,
                              ),
                              Icon(
                                Icons.person,
                                size: height / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: height / 50,
                                    ),
                                  ),
                                  Text(
                                    "Subtitle",
                                    style: TextStyle(
                                      fontSize: height / 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.diamond,
                                    color: Colors.red,
                                    size: height / 50,
                                  ),
                                ),
                                TextSpan(
                                  text: " 12334",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 50,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "This week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.blue[100],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 50,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Last week",
                            style: TextStyle(
                              fontSize: height / 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text("Time")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height / 30,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width / 3.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 20,
                        vertical: height / 100,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pink,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: height / 20,
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            "\$982.16",
                            style: TextStyle(
                                fontSize: height / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Container(
                          width: width / 3.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 20,
                            vertical: height / 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink,
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: height / 20,
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: height / 100,
                              ),
                              Text(
                                "\$982.16",
                                style: TextStyle(
                                    fontSize: height / 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$index",
                                style: TextStyle(fontSize: height / 50),
                              ),
                              SizedBox(
                                width: width / 70,
                              ),
                              Icon(
                                Icons.person,
                                size: height / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: height / 50,
                                    ),
                                  ),
                                  Text(
                                    "Subtitle",
                                    style: TextStyle(
                                      fontSize: height / 60,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.diamond,
                                    color: Colors.red,
                                    size: height / 50,
                                  ),
                                ),
                                TextSpan(
                                  text: " 12334",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height / 50,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
