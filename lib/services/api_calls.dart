import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

import '../models/now_playing_model.dart';
import '../models/popular_model.dart';
import '../models/search_model.dart';
import '../models/top_rated_model.dart';
import '../models/upcoming_model.dart';

Future<MovieModel?> getDetail({String? keyword}) async {
  MovieModel? movieModel;

  try {
    final response = await http.get(
      Uri.parse(
        getDetailUrl("$keyword"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      movieModel = MovieModel.fromJson(jsonDecode(response.body));
      log(response.body);
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return movieModel;
}

Future<NowPlayingModel?> getNowPlaying() async {
  NowPlayingModel? nowPlayingModel;
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("now_playing"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      nowPlayingModel = NowPlayingModel.fromJson(jsonDecode(response.body));
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return nowPlayingModel;
}

Future<SearchModel?> searchMovie({String? keyword}) async {
  SearchModel? searchModel;
  try {
    final response = await http.get(
      Uri.parse(
        searchUrl("$keyword"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      searchModel = SearchModel.fromJson(jsonDecode(response.body));
      log("Found ${searchModel.results!.length} Movie(s)");
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return searchModel;
}

Future<UpComingModel?> getUpcoming() async {
  UpComingModel? upComingModel;
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("upcoming"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      upComingModel = UpComingModel.fromJson(jsonDecode(response.body));
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return upComingModel;
}

Future<TopRatedModel?> getTopRated() async {
  TopRatedModel? topRatedModel;
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("top_rated"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      topRatedModel = TopRatedModel.fromJson(jsonDecode(response.body));
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return topRatedModel;
}

Future<PopularModel?> getPopular() async {
  PopularModel? popularModel;
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("popular"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      popularModel = PopularModel.fromJson(jsonDecode(response.body));
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return popularModel;
}
