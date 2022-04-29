// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../widgets/movieList.dart';
import '../widgets/skeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
    loadMovies();
    super.initState();
  }

  Constants constants = Constants();
  List topRAtedList = [];
  List topPopularList = [];
  List trendingTVList = [];

  loadMovies() async {
    TMDB tmdbWithLogs = TMDB(ApiKeys(constants.apiKey, constants.accessToken),
        defaultLanguage: "en-US",
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map topRated = await tmdbWithLogs.v3.movies.getTopRated();
    Map topPopular = await tmdbWithLogs.v3.movies.getPopular();
    Map trendingTVSeries = await tmdbWithLogs.v3.trending.getTrending();

    setState(() {
      topRAtedList = topRated["results"];
      topPopularList = topPopular["results"];
      trendingTVList = trendingTVSeries["results"];
    });
    log(topPopular.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.blueAccent,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) => const MovieListSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Top Rated Movies",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: MovieList(
                        movieInfo: topRAtedList,
                      ),
                    ),
                    const Text(
                      "Top Popular Movies",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: MovieList(
                        movieInfo: topPopularList,
                      ),
                    ),
                    // MovieList(
                    //   movieInfo: topPopularList,
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
