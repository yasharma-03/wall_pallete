import 'package:flutter/material.dart';
import 'package:wall_pallete/Controller/ApiOper.dart';
import 'package:wall_pallete/View/Screen/fullScreen.dart';
import 'package:wall_pallete/View/Widgets/CostumAppBar.dart';
import 'package:wall_pallete/View/Widgets/SearchBar.dart';
import 'package:wall_pallete/View/Widgets/catBlock.dart';

import '../../Model/categoryModel.dart';
import '../../Model/photoModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotoModel> trendingWallList = [];
  late List<CategoryModel> CatModList;
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  getTrendingWallPaper() async {
    trendingWallList = await ApiOperations.GetTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    getTrendingWallPaper();
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: CatModList.length,
                          itemBuilder: ((context, index) => catBlock(
                                categoryImgSrc: CatModList[index].catImgUrl,
                                categoryName: CatModList[index].catName,
                              ))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 645,
                      child: RefreshIndicator(
                          onRefresh: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 17,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 350,
                            ),
                            itemCount: trendingWallList.length,
                            itemBuilder: ((context, index) => GridTile(
                                    child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FullScreen(
                                                imgUrl: trendingWallList[index]
                                                    .PhotoSrc)));
                                  },
                                  child: Hero(
                                    tag: trendingWallList[index].PhotoSrc,
                                    child: Container(
                                      height: 500,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            height: 500,
                                            width: 100,
                                            fit: BoxFit.cover,
                                            trendingWallList[index].PhotoSrc),
                                      ),
                                    ),
                                  ),
                                ))),
                          )
                      ),
                  )
                ],
              ),
            ),
    );
  }
}
