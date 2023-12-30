import 'package:flutter/material.dart';
import 'package:wall_pallete/Controller/ApiOper.dart';
import 'package:wall_pallete/View/Widgets/CostumAppBar.dart';
import 'package:wall_pallete/View/Widgets/SearchBar.dart';
import 'package:wall_pallete/View/Widgets/catBlock.dart';
import 'package:wall_pallete/Model/photoModel.dart';

import 'fullScreen.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotoModel> searchResults = [];
  bool isLoading = true;
  getSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CostumAppBar(),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: searchBar()),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //height: MediaQuery.of(context).size.height,
                      height: 645,
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 350,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imgUrl: searchResults[index]
                                                .PhotoSrc)));
                              },
                              child: Hero(
                                tag: searchResults[index].PhotoSrc,
                                child: Container(
                                  height: 500,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        height: 500,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        searchResults[index].PhotoSrc),
                                  ),
                                ),
                              ),
                            ))),
                      ))
                ],
              ),
            ),
    );
  }
}
