import 'package:flutter/material.dart';

import '../model/model.dart';
import '../widgets/bottom_bar_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String name = '/singUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                      } else if (password.text.toString().length < 7) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Length of password is less than 7'),
                          ),
                        );
                      } else {
                        database.add(
                          UserData(
                              number: phoneNumber.text.toString(),
                              password: password.text.toString()),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/",
                          (route) => false,
                        );
                      }
                    },
                    child: const Text("SignUp"),
                  ),
                  //
                ],
              ),
            ),
          ),
          BottomBar(
            buttonText: "Login",
            text: "Have an account?",
            page: '/',
          ),
        ],
      ),
    );
  }
}
