import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int selectedOption = 0;
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
          "Account info",
          style: TextStyle(fontSize: height / 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 30,
              width: width,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                "Available times: 0/3. (MAX 3 times a month)",
                style: TextStyle(color: Colors.black, fontSize: height / 60),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 30),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: height / 40,
                      ),
                      title: Text(
                        "SR",
                        style: TextStyle(
                            fontSize: height / 40, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "ID: 123456789",
                        style: TextStyle(
                            fontSize: height / 60, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: height / 30),
                  Container(
                    height: height / 3.5,
                    width: width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 30, vertical: height / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verify Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height / 40,
                          ),
                        ),
                        SizedBox(height: height / 50),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Link Phone Number: ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: height / 50),
                              ),
                              TextSpan(
                                text: '0956767',
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: height /
                                        50 // Set the color to yellow for the second part
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Text(
                          "OTP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: height / 50,
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Container(
                          height: height / 15,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter OTP",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: height / 50,
                              ),
                              suffix: Container(
                                height: height / 20,
                                width: width / 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.pink,
                                ),
                                child: Center(
                                  child: Text(
                                    "Get OTP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height / 50,
                                    ),
                                  ),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: width / 30, vertical: height / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set a new password",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: height / 50,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'MIN 6 characters, MAX 16 characters',
                            style: TextStyle(
                              fontSize: height / 50,
                            ),
                          ),
                          leading: Radio(
                            value: 1,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Include atleast two: uppercase, lowercase, digits',
                            style: TextStyle(
                              fontSize: height / 50,
                            ),
                          ),
                          leading: Radio(
                            value: 2,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Text(
                          "New Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: height / 50,
                          ),
                        ),
                        SizedBox(height: height / 50),
                        Container(
                          height: height / 15,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter New Password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: height / 50,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 50,
                        ),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: height / 50,
                          ),
                        ),
                        Container(
                          height: height / 15,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: height / 50,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: width / 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 30),
                  Container(
                    height: height / 15,
                    width: width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink,
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height / 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
