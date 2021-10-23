import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/home.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/routes/routes.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getRoutes(),
      initialRoute: HomePage.routeName,
      theme: ThemeData(
        primaryColor: CustomColors.blueLight,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Comunidad perruna',
    );
  }
}
