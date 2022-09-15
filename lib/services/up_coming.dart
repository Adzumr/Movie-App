import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/upcoming_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<UpComingModel?> getUpcoming() async {
  UpComingModel? upComingModel;
  final header = {
    "X-RapidAPI-Key": apiKey,
  };
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("upcoming"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      upComingModel = UpComingModel.fromJson(jsonDecode(response.body));
      log("${response.statusCode}");
    } else {
      log("${response.statusCode}");
    }
  } catch (e) {
    log(e.toString());
  }
  return upComingModel;
}
