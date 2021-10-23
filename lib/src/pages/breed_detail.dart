import 'package:alejandro_giraldo_1_2021_2_p1/src/models/breed_detail_model.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/models/breeds_model.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/home.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/providers/breed_provider.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/assets_address.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/size.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/app_bar.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class BreedDetail extends StatefulWidget {
  const BreedDetail({Key? key}) : super(key: key);
  static const String routeName = "breed_detail";

  @override
  _BreedDetailState createState() => _BreedDetailState();
}

class _BreedDetailState extends State<BreedDetail> {
  final BreedProvider _breedProvider = BreedProvider();
  bool _loading = false;
  List<BreedImages> _images = [];
  Map<String, dynamic> _params = {"name": ''};

  @override
  void initState() {
    super.initState();
    Future(() {
      _params =
          ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
      setState(() {});
      fetchImages(_params["name"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: _params["name"]),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _loading ? _params["name"].toUpperCase() : "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: GlobalSize.width * 0.08,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalSize.width * 0.01,
                      vertical: GlobalSize.heigth * 0.02),
                  child: Wrap(
                    runAlignment: WrapAlignment.end,
                    children: _createItems(_images, context),
                  ),
                )
              ],
            ),
            Center(
              child: Column(
                children: [
                  LoadingIndicatorCustom(loading: _loading),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future fetchImages(String name) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _loading = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
      return;
    }
    _loading = true;
    setState(() {});
    _images = await _breedProvider.getBreedImages(name: name);
    _loading = false;
    setState(() {});
  }

  List<Widget> _createItems(List<BreedImages> images, BuildContext context) {
    List<Widget> widgets = [];

    for (var image in images) {
      widgets.add(GestureDetector(
        onTap: () async {
          _loading = true;
          setState(() {});
          _loading = false;
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.all(GlobalSize.width * 0.02),
          width: GlobalSize.width * 0.19,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
                placeholder: AssetImage(AssetsApp.loadingGif),
                image: NetworkImage(image.image)),
          ),
        ),
      ));
    }
    return widgets;
  }
}
