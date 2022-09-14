import 'package:flutter/material.dart';
import 'package:movie_app/models/top_rated_model.dart';
import 'package:movie_app/services/top_rated.dart';

class TopRatedProvider extends ChangeNotifier {
  TopRatedModel? topRatedModel;
  Future<TopRatedModel?> fetchTopRated() async {
    topRatedModel = (await getTopRated());
    notifyListeners();
    return null;
  }
}
