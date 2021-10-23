import 'package:flutter/material.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/assets_address.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/size.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/texts.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/app_bar.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "home_page";
  static const _styleParagraph = TextStyle(fontSize: 15);
  @override
  Widget build(BuildContext context) {
    GlobalSize.initSize(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: appBar(title: 'Inicio'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: GlobalSize.width * 0.07,
              vertical: GlobalSize.heigth * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: homeItems(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: Offset(-0.5, 0.5),
                  spreadRadius: 1,
                  color: Color.fromRGBO(190, 190, 190, 3))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> homeItems() {
    return [
      Center(
        child: Container(
          width: GlobalSize.width * 0.85,
          height: GlobalSize.heigth * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(AssetsApp.homeImage))),
        ),
      ),
      Container(
          margin: EdgeInsets.symmetric(
            horizontal: GlobalSize.width * 0.05,
            vertical: GlobalSize.heigth * 0.03,
          ),
          child: Text(
            GlobalText.pharagraph,
            textAlign: TextAlign.justify,
            style: _styleParagraph,
          )),
    ];
  }
}
