import 'package:flutter/material.dart';
import 'package:movie_app/models/upcoming_model.dart';
import 'package:movie_app/services/search_service.dart';

import '../models/search_model.dart';

class SearchProvider extends ChangeNotifier {
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
}
