import 'package:flutter/material.dart';

class HelpForm extends StatefulWidget {
  const HelpForm({super.key});

  @override
  State<HelpForm> createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> {
  TextEditingController describeIssueController = TextEditingController();
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
          "Help Form",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: height / 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  'Feeback Type',
                  style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height / 15,
                  width: width / 2.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pink[100],
                      border: Border.all(color: Colors.pink, width: 1.5)),
                  child: Center(
                    child: Text(
                      'General Issue\n    Feedback',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height / 60,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height / 15,
                  width: width / 2.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Text(
                      'Cashout/ \nWithdrawal Issue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height / 60,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 40),
            Container(
              height: height / 15,
              width: width / 2.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Center(
                child: Text(
                  'Recharge Issue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 30),
            Row(
              children: [
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: height / 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  'Brifely explain the problem/issue',
                  style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 30),
            // Text("Describe issue in brief",
            //     style: TextStyle(
            //       fontSize: height / 60,
            //       color: Colors.grey,
            //     )),
            TextField(
              controller: describeIssueController,
              decoration: InputDecoration(
                hintText: "Describe issue in brief",
                hintStyle: TextStyle(
                  fontSize: height / 60,
                  height: height / 80,
                  color: Colors.grey,
                ),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 30),
            Row(
              children: [
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: height / 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  'Upload Screenshot',
                  style: TextStyle(
                    fontSize: height / 60,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 30),
            Container(
              height: height / 10,
              width: width / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: const Center(child: Icon(Icons.add)),
            ),
            SizedBox(height: height / 8),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: height / 15,
                width: width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink,
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: height / 40,
                      color: Colors.white,
                    ),
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
