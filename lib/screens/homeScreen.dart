// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/models/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:http/http.dart' as http;

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
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    loadMovies();
    loadQuran();
    super.initState();
  }

  Constants constants = Constants();
  List topRAtedList = [];
  List topPopularList = [];
  List trendingTVList = [];
  var url = Uri.parse("https://quotes15.p.rapidapi.com/quotes/random/");
  var header = {
    'X-RapidAPI-Host': 'quotes15.p.rapidapi.com',
    'X-RapidAPI-Key': 'a3d86894bfmshb860463a4f82e0dp1d9364jsn8602f40687af'
  };

  dynamic quote;
  dynamic originator;
  loadQuran() async {
    return await http
        .get(
      url,
      headers: header,
    )
        .then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        quote = jsonData["content"];
        originator = jsonData["content"]["originator"]["name"];
        print(quote);
      }
    });
    // print(response.body);
  }

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
    // log(topPopular.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          loadQuran();
        });
      }),
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
                    Text(quote), 
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
