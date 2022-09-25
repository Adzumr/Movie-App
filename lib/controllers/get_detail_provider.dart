import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/movie_detail_service.dart';

class GetDetailProvider extends ChangeNotifier {
  MovieModel? movieModel;
  bool isSearching = false;
  Future<MovieModel?> fetchDetail({String? keyWord}) async {
    isSearching = true;
    movieModel = (await getDetail(
      keyword: keyWord,
    ));
    isSearching = false;
    notifyListeners();
    return null;
  }
}
