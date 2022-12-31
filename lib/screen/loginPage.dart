import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanishka_consultancy/screen/homepage.dart';
import 'package:kanishka_consultancy/screen/signupPage.dart';

import '../controller.dart';
import '../model/model.dart';
import '../widgets/bottom_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String name = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MyController myController = Get.put(MyController());
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Attendance App",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 45),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumber,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: password,
                    obscureText: _passwordVisible,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  //
                  ElevatedButton(
                    onPressed: () async {
                      if (password.text.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password is not filled'),
                          ),
                        );
                      } else if (phoneNumber.text.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Phone number is not filled'),
                          ),
                        );
                      }
                      if (password.text.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password is not filled'),
                          ),
                        );
                      } else if (phoneNumber.text.toString() !=
                              database[0].number ||
                          password.text.toString() != database[0].password) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Wrong Data'),
                          ),
                        );
                      } else {
                        myController.username = phoneNumber.text.toString();
                        Navigator.pushReplacementNamed(
                          context,
                          HomePageScreen.name,
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                  //
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Forget your login details?"),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Contact us"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomBar(
            buttonText: "Sign up",
            text: "Don't have an account?",
            page: SignUpScreen.name,
          ),
        ],
      ),
    );
  }
}
