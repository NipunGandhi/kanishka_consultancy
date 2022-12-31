import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kanishka_consultancy/screen/homepage.dart';
import 'package:kanishka_consultancy/screen/loginPage.dart';
import 'package:kanishka_consultancy/screen/photoClick.dart';

import 'screen/signupPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        SignUpScreen.name: (context) => SignUpScreen(),
        // ForgetPasswordScreen.name: (context) => const ForgetPasswordScreen(),
        HomePageScreen.name: (context) => HomePageScreen(),
        PhotoChooser.name: (context) => const PhotoChooser(),
      },
    );
  }
}
