import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_calls.dart';

import '../models/now_playing_model.dart';
import '../models/popular_model.dart';
import '../models/search_model.dart';
import '../models/top_rated_model.dart';
import '../models/upcoming_model.dart';

class MovieProvider extends ChangeNotifier {
  TopRatedModel? topRatedModel;
  MovieModel? movieModel;
  NowPlayingModel? nowPlayingModel;
  PopularModel? popularModel;
  UpComingModel? upComingModel;
  SearchModel? seachModel;
  bool isSearching = false;
  Future<UpComingModel?> fetchResult({String? keyWord}) async {
    isSearching = true;
    seachModel = (await searchMovie(
      keyword: keyWord,
    ));
    isSearching = false;
    notifyListeners();
    return null;
  }

  Future<PopularModel?> fetchPopular() async {
    popularModel = (await getPopular());
    notifyListeners();
    return popularModel;
  }

  Future<UpComingModel?> fetchUpcoming() async {
    upComingModel = (await getUpcoming());
    notifyListeners();
    return null;
  }

  Future<NowPlayingModel?> fetchNowPlaying() async {
    nowPlayingModel = (await getNowPlaying());
    notifyListeners();
    return nowPlayingModel;
  }

  Future<TopRatedModel?> fetchTopRated() async {
    topRatedModel = (await getTopRated());
    notifyListeners();
    return topRatedModel!;
  }

  Future<MovieModel?> fetchDetail({String? keyWord}) async {
    movieModel = (await getDetail(
      keyword: keyWord,
    ));

    notifyListeners();
    return movieModel;
  }
}
