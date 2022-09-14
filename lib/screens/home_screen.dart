import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/now_playing_provider.dart';
import 'package:movie_app/providers/popular_provider.dart';
import 'package:movie_app/providers/top_rated_provider.dart';
import 'package:movie_app/providers/upcoming_provider.dart';
import 'package:movie_app/screens/now_playing_list_screen.dart';
import 'package:movie_app/screens/popular_list_screen.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/screens/top_rated_list_screen.dart';
import 'package:movie_app/screens/up_coming_list_screen.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/input_borders.dart';
import 'detailed_screen.dart';

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
    final popularData = Provider.of<PopularProvider>(context, listen: false);
    getPopular = popularData.fetchPopular();
    final upComingdata = Provider.of<UpComingProvider>(context, listen: false);
    getUpcoming = upComingdata.fetchUpcoming();
    final nowPlaying = Provider.of<NowPlayProvider>(context, listen: false);
    getNowPlaying = nowPlaying.fetchNowPlaying();
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    );
  }

  late Future getData;
  late Future getPopular;
  late Future getUpcoming;
  late Future getNowPlaying;
  List<String> movieCategory = [
    "Now playing",
    "Upcoming",
    "Top rated",
    "Popular"
  ];
  @override
  Widget build(BuildContext context) {
    final topRatedMovies = Provider.of<TopRatedProvider>(context);
    final popularData = Provider.of<PopularProvider>(context);
    final upComingdata = Provider.of<UpComingProvider>(context);
    final nowPlayingdata = Provider.of<NowPlayProvider>(context);

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
                if (upComingdata.upComingModel != null ||
                    topRatedMovies.topRatedModel != null ||
                    popularData.popularModel != null) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchScreen(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.sp),
                            child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? "Empty Object" : null,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Ionicons.search_outline,
                                  ),
                                ),
                                filled: true,
                                enabled: false,
                                fillColor: appColors.shadowColor,
                                enabledBorder: enableInputBorder,
                                disabledBorder: enableInputBorder,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: appColors.backgorundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "What do you want to watch?",
                          style: appFonts.titleFont,
                        ),

                        // Now playing category
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Now Playing"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NowPlayingListScreen(
                                            models:
                                                nowPlayingdata.nowPlayingModel,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("View All"),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5.sp),
                              height: 23.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  final movie = nowPlayingdata
                                      .nowPlayingModel!.results![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedScreen(
                                            movieId: "${movie.id}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(imageBaseUrl +
                                              movie.backdropPath!),
                                          // height: 20.h,
                                          width: 25.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        // Popular category
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Popular movies"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PopularListScreen(
                                            models: popularData.popularModel,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("View All"),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5.sp),
                              height: 23.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  final movie =
                                      popularData.popularModel!.results![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedScreen(
                                            movieId: "${movie.id}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(imageBaseUrl +
                                              movie.backdropPath!),
                                          // height: 20.h,
                                          width: 25.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),

                        // Top rated category
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Top rated movies"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TopRatedListScreen(
                                            models:
                                                topRatedMovies.topRatedModel,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("View All"),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5.sp),
                              height: 23.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  final movie = topRatedMovies
                                      .topRatedModel!.results![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedScreen(
                                            movieId: "${movie.id}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(imageBaseUrl +
                                              movie.backdropPath!),
                                          // height: 20.h,
                                          width: 25.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),

                        // Upcoming category
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Upcoming movies"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpComingListScreen(
                                            models: upComingdata.upComingModel,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("View All"),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 5.sp),
                              height: 23.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  final movie = upComingdata
                                      .upComingModel!.results![index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedScreen(
                                            movieId: "${movie.id}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(imageBaseUrl +
                                              movie.backdropPath!),
                                          // height: 20.h,
                                          width: 25.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
