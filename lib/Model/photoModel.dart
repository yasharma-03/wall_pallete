import 'package:flutter/cupertino.dart';
//
// class PhotoModel{
//   String PhotoSrc;
//   String PhotoName;
//
//   PhotoModel({required this.PhotoSrc, required this.PhotoName})
//   static PhotoModel fromAPI2App(Map<String, dynamic> photoMap) {
//     return PhotoModel(
//         PhotoName: photoMap["photographer"],
//         PhotoSrc: (photoMap["src"])["portrait"]);
//   }
//
// }


class PhotoModel {
  String PhotoSrc;
  String PhotoName;

  PhotoModel({required this.PhotoName, required this.PhotoSrc});

  static PhotoModel fromAPI2App(Map<String, dynamic> photoMap) {
    return PhotoModel(
        PhotoName: photoMap["photographer"],
        PhotoSrc: (photoMap["src"])["portrait"]);
  }
}