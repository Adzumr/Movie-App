import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<MovieModel?> getDetail({String? keyword}) async {
  MovieModel? movieModel;
  final header = {
    "X-RapidAPI-Key": apiKey,
  };
  try {
    final response = await http.get(
      Uri.parse(
        getDetailUrl("$keyword"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      movieModel = MovieModel.fromJson(jsonDecode(response.body));
      log("Movie: " + response.body);
    } else {
      log(response.statusCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  return movieModel;
}