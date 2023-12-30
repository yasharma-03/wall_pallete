import 'package:flutter/material.dart';
import 'package:wall_pallete/Controller/ApiOper.dart';
import 'package:wall_pallete/View/Widgets/CostumAppBar.dart';
import 'package:wall_pallete/View/Widgets/SearchBar.dart';
import 'package:wall_pallete/View/Widgets/catBlock.dart';

import '../../Model/photoModel.dart';
import 'fullScreen.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

  CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotoModel> categoryResults;
  bool isLoading  = true;
  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
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
      body: isLoading  ? Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    widget.catImgUrl),

                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),

                Positioned(
                  left: 140,
                  top: 35,
                  child: Column(
                    children: [
                      Text("Categry", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22,),),
                      Text(widget.catName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),),
                    ],
                  ),
                )

              ],
            ),

            SizedBox(height: 20,),
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
                  itemCount: categoryResults.length,
                  itemBuilder: ((context, index) => GridTile(


                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imgUrl:
                                    categoryResults[index].PhotoSrc)));
                      },

                      child: Hero(
                        tag: categoryResults[index].PhotoSrc,
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
                                categoryResults[index].PhotoSrc),
                          ),

                        ),
                      ),
                    ),
                  ))
                  ,)
            )],
        ),
      ),
    );
  }
}
