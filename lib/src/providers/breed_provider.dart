import 'package:alejandro_giraldo_1_2021_2_p1/src/models/breed_detail_model.dart';
import 'package:alejandro_giraldo_1_2021_2_p1/src/models/breeds_model.dart';

import 'base_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BreedProvider extends Provider {
  BreedProvider() {
    localPath = "/breeds/list/all";
  }

  Future<List<Breed>> getBreeds() async {
    var url = Uri.parse(baseUrl + localPath);
    http.Response response = await http.get(url);
    List<Breed> breeds = [];

    if (response.statusCode == 200) {
      Map mapData = await json.decode(response.body);
      var data = mapData["message"];
      for (String key in data.keys) {
        if (key != "") {
          Breed b = Breed(breed: key);
          breeds.add(b);
        }
      }
    }

    return breeds;
  }

  Future<List<BreedImages>> getBreedImages({required String name}) async {
    var url = Uri.parse("$baseUrl/breed/$name/images");
    http.Response response = await http.get(url);
    List<BreedImages> images = [];

    if (response.statusCode == 200) {
      Map mapData = await json.decode(response.body);
      var data = mapData["message"];
      for (String? value in data) {
        if (value != null || value != "") {
          BreedImages b = BreedImages(image: value!);
          images.add(b);
        }
      }
    }

    return images;
  }
}
