import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/utils/constants.dart';

Future<NowPlayingModel?> getNowPlaying() async {
  NowPlayingModel? nowPlayingModel;
  final header = {
    "X-RapidAPI-Key": apiKey,
  };
  try {
    final response = await http.get(
      Uri.parse(
        movieUrl("now_playing"),
      ),
      headers: header,
    );
    if (response.statusCode == 200) {
      nowPlayingModel = NowPlayingModel.fromJson(jsonDecode(response.body));
      log("now_playing: " + response.body);
    } else {
      log(response.statusCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
  return nowPlayingModel;
}
