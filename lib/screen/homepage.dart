import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanishka_consultancy/screen/photoClick.dart';

import '../controller.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);
  static String name = '/HomeScreen';
  final MyController _instance = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).padding.top + kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_instance.attendanceMarked == false) {
                  Navigator.pushNamed(context, PhotoChooser.name);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Attendance already marked at ${_instance.data.position?.timestamp?.hour}:${_instance.data.position?.timestamp?.minute}')));
                }
              },
              child: const SizedBox(
                width: 120,
                child: Center(
                  child: Text("Mark Attendance"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: const SizedBox(
                width: 120,
                child: Center(child: Text("Sign off")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
