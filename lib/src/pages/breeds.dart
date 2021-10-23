import 'package:alejandro_giraldo_1_2021_2_p1/src/models/breeds_model.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/breed_detail.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/pages/home.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/providers/breed_provider.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/assets_address.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/app_bar.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/drawer.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/widgets/loading_indicator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class BreedsPage extends StatefulWidget {
  const BreedsPage({Key? key}) : super(key: key);
  static const String routeName = "breeds_page";

  @override
  _BreedsPageState createState() => _BreedsPageState();
}

class _BreedsPageState extends State<BreedsPage> {
  final BreedProvider _breedProvider = BreedProvider();
  final ScrollController _scrollController = ScrollController();
  List<Breed> _breeds = [];
  bool _loading = false;

  Icon actionIcon = Icon(Icons.search);
  Widget appBarTitle = Text("Razas");
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBreeds();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchBreeds();
      }
    });

    controller.addListener(() {
      if (controller.text.isEmpty) {
        fetchBreeds();
      } else {
        List<Breed> filteredList = [];
        for (var breed in _breeds) {
          if (breed.breed
              .toLowerCase()
              .contains(controller.text.toLowerCase())) {
            filteredList.add(breed);
          }
        }
        setState(() {
          _breeds = filteredList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: 'Razas',
        ),
        drawer: NavDrawer(),
        body: Stack(
          children: [
            _showImage(),
            _listBuilder(context),
            LoadingIndicatorCustom(
              loading: _loading,
            )
          ],
        ));
  }

  AppBar appBar({required String title}) {
    return AppBar(
      elevation: 0.1,
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon = const Icon(Icons.close);
                appBarTitle = TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  autofocus: true,
                  cursorColor: Colors.white,
                );
              } else {
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Razas");
                controller.clear();
                fetchBreeds();
              }
            });
          },
        ),
      ],
    );
  }

  Future fetchBreeds() async {
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
    _breeds += await _breedProvider.getBreeds();
    _loading = false;
    setState(() {});
    _scrollController.animateTo(_scrollController.position.pixels + 50,
        duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
  }

  Widget _listBuilder(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _breeds.length,
        itemBuilder: (BuildContext context, int index) {
          return EpisodeCard(
            breed: _breeds[index],
          );
        });
  }

  Widget EpisodeCard({required Breed breed}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BreedDetail.routeName,
            arguments: {"name": breed.breed});
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: GlobalSize.heigth * 0.02,
                  bottom: GlobalSize.heigth * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Raza de perro: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis),
                        Text(breed.breed, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    return (Center(
      child: Container(
        width: GlobalSize.width,
        height: GlobalSize.heigth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AssetsApp.breedImage))),
      ),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
