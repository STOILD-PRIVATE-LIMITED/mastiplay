import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spinner_try/components/button.dart';
import 'package:spinner_try/components/textfield.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  bool pass = true;

  void visible() {
    setState(() {
      pass = !pass;
    });
  }

  // signIn method
  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Sign in process
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      Navigator.pop(context);
      // pop the loading circle
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      showMsg(context, e.toString());
      Navigator.pop(context);

      // Wrong Username
      if (e.code == 'user-not-found') {
        ErrorMessage("User Not Registered");
      }

      // Wrong Password
      else if (e.code == 'wrong-password') {
        ErrorMessage("Incorrect Password");
      }
    }
    // Lodding Circle
  }

  // Error Message
  void ErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red[800],
          title: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  // wrong Password Message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 95),

                // welcome back
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // username

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: Text(
                        "E-mail",
                        style: TextStyle(color: Colors.grey[700], fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: usernameController,
                  hintText: 'Your email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),
                // password
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 23),
                      child: Text(
                        "Password",
                        style: TextStyle(color: Colors.grey[700], fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: pass,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: visible,
                          child: pass == true
                              ? Icon(
                                  Icons.visibility,
                                  size: 25,
                                  color: Colors.grey[500],
                                )
                              : Icon(Icons.visibility_off,
                                  color: Colors.grey[500], size: 25),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 18)),
                  ),
                ),

                // forgot password

                const SizedBox(height: 20),

                // sign in button
                MyButton(
                  onTap: signIn,
                  text: "LOGIN",
                ),

                const SizedBox(height: 20),

                // not a member,Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                LoadingElevatedButton(
                  style: TextButton.styleFrom(
                    side: BorderSide.none,
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    usernameController.text = usernameController.text.trim();
                    String? err =
                        Validate.email(usernameController.text, required: true);
                    if (err != null) {
                      showMsg(context, err);
                      return;
                    }
                    if (await askUser(context, 'Send a password reset link for',
                            description: "${usernameController.text} ?",
                            yes: true,
                            no: true) ==
                        'yes') {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: usernameController.text);
                    }
                  },
                  icon: const Icon(Icons.lock_reset_rounded),
                  label: const Text('Reset password'),
                ),

                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 1.3,
                //           color: Colors.grey[500],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Sign up with',
                //           style: TextStyle(
                //               color: Colors.grey[700],
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 1.3,
                //           color: Colors.grey[500],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 10),

                // google + apple sign in button

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     // google
                //     SquareTile(
                //         onTap: () => {AuthServices().signInWithGoogle()},
                //         imagePath: 'lib/images/google.png'),
                //
                //     //  const SizedBox(width: 25),
                //
                //     // apple
                //     SquareTile(
                //         onTap: () => {}, imagePath: 'lib/images/facebook.png'),
                //   ],
                // ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
