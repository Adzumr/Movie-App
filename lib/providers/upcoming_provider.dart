import 'package:flutter/material.dart';
import 'package:movie_app/models/upcoming_model.dart';
import 'package:movie_app/services/up_coming.dart';

class UpComingProvider extends ChangeNotifier {
  UpComingModel? upComingModel;
  Future<UpComingModel?> fetchUpcoming() async {
    upComingModel = (await getUpcoming());
    notifyListeners();
    return null;
  }
}
