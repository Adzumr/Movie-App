import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/get_movie_service.dart';

class MovieProvider extends ChangeNotifier {
  MovieModel? movieModel;
  getMoviePost({
    String? page,
  }) async {
    movieModel = (await getMovie(
      page: page,
    ));
  }
}
