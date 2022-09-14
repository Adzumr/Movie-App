import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/popular_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<PopularModel?> getPopular() async {
  PopularModel? popularModel;
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
      popularModel = PopularModel.fromJson(jsonDecode(response.body));
      log("popular: " + response.body);
    } else {
      log(response.statusCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  return popularModel;
}