import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/search_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<SearchModel?> searchMovie({String? keyword}) async {
  SearchModel? searchModel;
  final header = {
    "X-RapidAPI-Key": apiKey,
  };
  try {
    final response = await http.get(
      Uri.parse(
        searchUrl("$keyword"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      searchModel = SearchModel.fromJson(jsonDecode(response.body));
      log("${response.statusCode}");
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return searchModel;
}
