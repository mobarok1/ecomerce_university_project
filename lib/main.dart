import 'package:ecomerce/utils/theme_data.dart';
import 'package:ecomerce/view/pages/home_page.dart';
import 'package:ecomerce/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/pages/cart_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: mainColor,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}