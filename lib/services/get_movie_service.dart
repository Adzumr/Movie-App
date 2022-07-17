import 'dart:convert';
import 'dart:developer';

import 'package:movie_app/utils/constants.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

Future<MovieModel?> getMovie({String? page}) async {
  MovieModel? movieModel;
  String pageUrl = url("$page");
  try {
    final response = await http.get(Uri.parse(pageUrl));
    if (response.statusCode == 200) {
      log(response.body);
      movieModel = MovieModel.fromJson(jsonDecode(response.body));
    } else {
      log(response.statusCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  return movieModel;
}
