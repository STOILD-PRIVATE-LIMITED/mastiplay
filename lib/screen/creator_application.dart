import 'package:flutter/material.dart';

class CreatorApplication extends StatefulWidget {
  const CreatorApplication({super.key});

  @override
  State<CreatorApplication> createState() => _CreatorApplicationState();
}

class _CreatorApplicationState extends State<CreatorApplication> {
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
            size: height / 50,
          ),
        ),
        title: Text(
          "Agency Center",
          style: TextStyle(fontSize: height / 50),
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
                        fontSize: height / 50,
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
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(
                '''Reminder:
If you agree, the creator will be removed from your agency and join another agency
If you refuse, the creator will stay in your agency, and she/he will not able to apply again within 1 months.
If you don't act within 7 days, the creator will be transferred automatically to desired agency''',
                style: TextStyle(
                  fontSize: height / 60,
                ),
              ),
            ),
            SizedBox(height: height / 30),
            Text(
              "Pending(0)",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: height / 50),
            ),
            SizedBox(height: height / 50),
            Text(
              "Completed",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: height / 50),
            ),
            SizedBox(height: height / 50),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Icon(Icons.abc, size: height / 30),
                title: Text(
                  "Name",
                  style: TextStyle(
                      fontSize: height / 50, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "ID: 123456789",
                  style: TextStyle(fontSize: height / 60, color: Colors.grey),
                ),
                trailing: Container(
                  height: height / 20,
                  width: width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 1),
                      Text(
                        "Accept",
                        style: TextStyle(
                            fontSize: height / 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
