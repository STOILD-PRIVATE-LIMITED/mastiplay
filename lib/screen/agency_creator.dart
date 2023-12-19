import 'package:flutter/material.dart';

class AgencyCreator extends StatefulWidget {
  const AgencyCreator({super.key});

  @override
  State<AgencyCreator> createState() => _AgencyCreatorState();
}

class _AgencyCreatorState extends State<AgencyCreator> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf7f8fc),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 40,
          ),
        ),
        title: Text(
          "Agency Center",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.abc, size: height / 30),
              title: Text(
                "Creator application",
                style: TextStyle(
                  fontSize: height / 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Container(
                height: height / 20,
                width: width / 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      minRadius: 15,
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 70,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: height / 50,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Creators",
                    style: TextStyle(
                      // height: height / 50,
                      fontSize: height / 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: height / 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height / 5.5,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.abc, size: height / 20),
                            title: Text(
                              "SR",
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "ID: 123456789",
                              style: TextStyle(
                                fontSize: height / 60,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: const Icon(Icons.message),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text("My Commision"),
                                  Row(
                                    children: [
                                      Icon(Icons.abc),
                                      Text("000000"),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text("My Commision"),
                                  Row(
                                    children: [
                                      Icon(Icons.abc),
                                      Text("000000"),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
