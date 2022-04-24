// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/models/movieModel.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  Constants constants = Constants();
  List topRAtedList = [];
  List trendingTVList = [];
  // TmdbModel tmdbModel = TmdbModel.fromJson();

  loadMovies() async {
    TMDB tmdbWithLogs = TMDB(ApiKeys(constants.apiKey, constants.accessToken),
        defaultLanguage: "en-US",
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ));
    Map topRated = await tmdbWithLogs.v3.movies.getTopRated();
    Map trendingTVSeries = await tmdbWithLogs.v3.trending.getTrending();

    setState(() {
      topRAtedList = topRated["results"];
      trendingTVList = trendingTVSeries["results"];
    });
    log(topRAtedList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Trending Movies"),
              Expanded(
                child: MovieDetail(
                  movieInfo: topRAtedList,
                ),
              ),
              Expanded(
                child: MovieDetail(
                  movieInfo: trendingTVList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
