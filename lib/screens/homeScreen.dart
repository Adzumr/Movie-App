// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/models/movieModel.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/skeleton.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
    loadMovies();
    super.initState();
  }

  Constants constants = Constants();
  List topRAtedList = [];
  List trendingTVList = [];

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
        child: _isLoading
            ? ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              )
            : Padding(
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

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
