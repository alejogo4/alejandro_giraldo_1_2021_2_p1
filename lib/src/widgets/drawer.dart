import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/home.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/assets_address.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/colors.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/size.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/texts.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final TextStyle textStyle =
      TextStyle(color: Colors.black, fontSize: GlobalSize.width * 0.05);
  @override
  Widget build(BuildContext context) {
    print(GlobalSize.width * 0.05);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 1),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetsApp.drawerImage),
              ),
            ),
          ),
          navItem(
              callBack: () => Navigator.of(context)
                  .pushReplacementNamed(HomePage.routeName),
              title: GlobalText.home,
              iconData: Icons.home),
        ],
      ),
    );
  }

  ListTile navItem(
      {required String title,
      required IconData iconData,
      required VoidCallback callBack}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: CustomColors.blueLight,
      ),
      onTap: callBack,
      title: Text(
        title,
        style: textStyle,
      ),
    );
  }
}
