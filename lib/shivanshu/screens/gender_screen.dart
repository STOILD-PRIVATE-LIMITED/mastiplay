import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/screens/birthday_screen.dart';
import 'package:spinner_try/shivanshu/screens/family_room_page.dart';
import 'package:spinner_try/shivanshu/utils.dart';

class GenderScreen extends StatefulWidget {
  final String username;
  final String email;
  const GenderScreen({super.key, this.username = "", required this.email});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String name = "";
  int? selectedIndex;

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (selectedIndex == null) {
      showMsg(context, "Choose a gender please.");
      return;
    }
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    navigatorPush(
        context,
        BirthdayScreen(
          name: name,
          gender: selectedIndex == 0 ? 'Male' : 'Female',
          email: widget.email,
        ));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    name = widget.username;
    print(widget.email);
    print(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? ElevatedBackButton(
                onTap: () {
                  Navigator.pop(context);
                },
              )
            : null,
        title: const Text('Complete Information'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      // labelText: 'NickName',
                      hintText: 'NickName',
                      hintStyle: const TextStyle(color: Colors.black26),
                      fillColor: Colors.black12.withOpacity(0.05),
                      filled: true,
                      prefixIcon: const Icon(Icons.person_rounded),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: Validate.name,
                    onFieldSubmitted: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.black12.withOpacity(0.05),
                                  ),
                                  child: InkWell(
                                    child: Hero(
                                      tag: 'Male',
                                      child: Image.asset(
                                        'assets/male.jpg',
                                        fit: BoxFit.contain,
                                        width: 100,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                  ),
                                ),
                                Icon(Icons.check_circle,
                                    color: selectedIndex == 0
                                        ? Colors.green
                                        : Colors.transparent),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              'Male',
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? const Color.fromARGB(255, 59, 214, 168)
                                    : Colors.black26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.black12.withOpacity(0.05),
                                  ),
                                  child: InkWell(
                                    child: Hero(
                                      tag: 'Female',
                                      child: Image.asset(
                                        'assets/female.jpg',
                                        fit: BoxFit.contain,
                                        width: 100,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: selectedIndex == 1
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              'Female',
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? const Color.fromARGB(255, 59, 214, 168)
                                    : Colors.black26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.sp),
                  Hero(
                    tag: 'submit',
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          shaderWidget(
                            context,
                            colors: [
                              Colors.yellow.withOpacity(0.7),
                              Colors.blueAccent.withOpacity(0.7),
                            ],
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.8,
                                  vertical: 20,
                                ),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: _submitForm,
                              child: const Text(
                                '                  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _submitForm,
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
