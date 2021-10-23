import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/home.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      HomePage.routeName: (BuildContext context) => const HomePage(),
    };
