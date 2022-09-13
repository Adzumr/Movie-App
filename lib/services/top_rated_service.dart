import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/top_rated_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<TopRatedModel?> getTopRated() async {
  TopRatedModel? topRatedModel;
  final header = {
    "X-RapidAPI-Key": apiKey,
  };
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("popular"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      topRatedModel = TopRatedModel.fromJson(jsonDecode(response.body));
      log(response.body);
    } else {
      log(response.statusCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  return topRatedModel;
}
