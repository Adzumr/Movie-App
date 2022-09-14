import 'package:flutter/material.dart';
import 'package:movie_app/models/popular_model.dart';
import 'package:movie_app/models/top_rated_model.dart';

import '../services/popular.dart';

class PopularProvider extends ChangeNotifier {
  PopularModel? popularModel;
  Future<TopRatedModel?> fetchPopular() async {
    popularModel = (await getPopular());
    notifyListeners();
    return null;
  }
}
