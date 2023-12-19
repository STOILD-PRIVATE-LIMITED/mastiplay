import 'package:flutter/material.dart';

class AgencyDetail extends StatefulWidget {
  const AgencyDetail({super.key});

  @override
  State<AgencyDetail> createState() => _AgencyDetailState();
}

class _AgencyDetailState extends State<AgencyDetail> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Change Agency',
                    style: TextStyle(
                        fontSize: height / 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 25),
                    height: height / 200,
                    width: width / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: height / 20,
                      width: width / 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFecaae8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Agency Name",
                        style: TextStyle(
                          fontSize: height / 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: width / 30),
                    Image.asset(
                      "assets/union-1.png",
                      height: height / 30,
                    )
                  ],
                ),
                Text(
                  "TOTAL",
                  style: TextStyle(
                    fontSize: height / 60,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "7897",
                      style: TextStyle(
                        fontSize: height / 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      "assets/Vector.png",
                      height: height / 30,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height / 30),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height / 10,
                      width: width / 3,
                      decoration: BoxDecoration(
                        color: const Color(0xFFecaae8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          "Sub_agent commission",
                          style: TextStyle(
                            fontSize: height / 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Time",
                          style: TextStyle(
                            fontSize: height / 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: SizedBox(
                          width: width / 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1",
                                style: TextStyle(fontSize: height / 50),
                              ),
                              Image.asset(
                                "assets/Vector.png",
                                height: height / 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
