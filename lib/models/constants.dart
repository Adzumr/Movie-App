import 'package:tmdb_api/tmdb_api.dart';

class Constants {
  final String apiKey = "fd19e5028622149c74b00a1f5265ad9d";
  final String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDE5ZTUwMjg2MjIxNDljNzRiMDBhMWY1MjY1YWQ5ZCIsInN1YiI6IjYyNjI5MmI1M2Y0ODMzMTI4MGE5ODkwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zH7RzJqiF5qjkCghUbofZLLRltDLJSxNkcteUx_8usE";
}

get loadMovies async {
  TMDB tmdbWithLogs = TMDB(ApiKeys(Constants().apiKey, Constants().accessToken),
      defaultLanguage: "en-US",
      logConfig: const ConfigLogger(
        showErrorLogs: true,
        showLogs: true,
      ));
  Map topRated = await tmdbWithLogs.v3.movies.getTopRated();
  Map topPopular = await tmdbWithLogs.v3.movies.getPopular();
  Map trendingTVSeries = await tmdbWithLogs.v3.trending.getTrending();
}
