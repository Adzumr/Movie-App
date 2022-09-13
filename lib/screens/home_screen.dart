import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/top_rated_provider.dart';
import 'package:movie_app/screens/top_rated_list_screen.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/input_borders.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../services/top_rated_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final data = Provider.of<TopRatedProvider>(context, listen: false);
    getData = data.fetchTopRated();
    super.initState();
  }

  late Future getData;
  List<String> movieCategory = [
    "Now playing",
    "Upcoming",
    "Top rated",
    "Popular"
  ];
  @override
  Widget build(BuildContext context) {
    final topRatedMovies = Provider.of<TopRatedProvider>(context);

    return Scaffold(
      backgroundColor: appColors.backgorundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: FutureBuilder(
            future: getData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                if (topRatedMovies.topRatedModel!.results!.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "What do you want to watch?",
                        style: appFonts.titleFont,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.sp),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Empty Object" : null,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  getTopRated();
                                });
                              },
                              icon: const Icon(
                                Ionicons.search_outline,
                              ),
                            ),
                            filled: true,
                            fillColor: appColors.shadowColor,
                            enabledBorder: enableInputBorder,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: appColors.backgorundColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Top rated movies"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => TopRatedListScreen(
                                          models: topRatedMovies.topRatedModel,
                                        )),
                                  ),
                                );
                              },
                              child: const Text("View All"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.sp),
                        height: 25.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: ((context, index) {
                            final movie =
                                topRatedMovies.topRatedModel!.results![index];
                            return Container(
                              margin: EdgeInsets.only(right: 20.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(
                                      imageBaseUrl + movie.backdropPath!),
                                  height: 20.h,
                                  width: 20.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.sp),
                        height: 5.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = movieCategory[index];
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Text(category),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(5.sp),
                              child: Image(
                                image: AssetImage(
                                  appImages.movie,
                                ),
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Movies not found"),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
