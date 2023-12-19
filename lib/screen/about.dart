import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
          "About",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.abc,
              size: height / 30,
            ),
            SizedBox(
              height: height / 30,
            ),
            Text(
              'Baat',
              style: TextStyle(
                fontSize: height / 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height / 30),
            Text(
              'Current Version 1.0.0',
              style: TextStyle(
                fontSize: height / 40,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: height / 30),
            const Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              child: ListTile(
                title: Text("User Agreement"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              child: ListTile(
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: height / 2,
            ),
            Text(
              "Baat copyright",
              style: TextStyle(
                fontSize: height / 60,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
