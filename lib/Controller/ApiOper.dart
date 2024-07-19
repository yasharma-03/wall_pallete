import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wall_pallete/Model/photoModel.dart';

import 'dart:math';

import '../Model/categoryModel.dart';

class ApiOperations{
  static List<PhotoModel> trendingWallpapers = [];
  static List<PhotoModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<PhotoModel>> GetTrendingWallpapers () async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {
          "Authorization": "YOUR_AUTHORISATION_KEY"
        }).then((value) {
      //print("RESPONSE REPORT");
      //print(value.body);
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
       trendingWallpapers.add(PhotoModel.fromAPI2App(element));
      });
    });
    return trendingWallpapers;

}

  static Future<List<PhotoModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": "sVjh8j8EdklUKw31JWiCa1dxPsULLndQwtBBPb6H9BjhHaAHfKRBRMGD"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotoModel.fromAPI2App(element));
      });
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotoModel photoModel =
      (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.PhotoSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.PhotoSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
