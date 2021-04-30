import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/provider/measurement.dart';
import 'package:virtual_fitting_room/screens/home.dart';
import 'package:virtual_fitting_room/screens/home_page.dart';
import 'package:virtual_fitting_room/screens/welcome.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<measurement>(
          create: (_) => measurement(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "virtual Fitting Room",
      debugShowCheckedModeBanner: false,
      home: welcome(),
    );
  }
}
