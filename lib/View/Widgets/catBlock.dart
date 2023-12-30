import 'package:flutter/material.dart';

import '../Screen/category.dart';

class catBlock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  catBlock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                      catImgUrl: categoryImgSrc, catName: categoryName)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                    height: 50, width: 100, fit: BoxFit.cover, categoryImgSrc),
              ),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(15)),
              ),
              Positioned(
                  left: 10,
                  top: 12,
                  child: Text(categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600))),
            ],
          ),
        ),);
  }
}
