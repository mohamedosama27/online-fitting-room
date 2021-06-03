import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_fitting_room/provider/auth.dart';
import 'package:virtual_fitting_room/provider/brand.dart';
import 'package:virtual_fitting_room/provider/cart.dart';
import 'package:virtual_fitting_room/provider/cloth.dart';
import 'package:virtual_fitting_room/provider/measurement.dart';
import 'package:virtual_fitting_room/provider/Users.dart';
import 'package:virtual_fitting_room/screens/home.dart';
import 'package:virtual_fitting_room/screens/welcome.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<Users>(
          create: (_) => Users(),
        ),
        ChangeNotifierProvider<measurement>(
          create: (_) => measurement(),
        ),
        ChangeNotifierProvider<brand>(
          create: (_) => brand(),
        ),
        ChangeNotifierProvider<cloth>(
          create: (_) => cloth(),
        ),
        ChangeNotifierProvider<cart>(
          create: (_) => cart(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, value, _) => MaterialApp(
          title: "virtual Fitting Room",
          debugShowCheckedModeBanner: false,
          home: welcome()),
    );
  }
}
