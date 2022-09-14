import 'package:flutter/material.dart';
import 'package:movie_app/models/now_playing_model.dart';
import 'package:movie_app/services/now_playing.dart';

class NowPlayProvider extends ChangeNotifier {
  NowPlayingModel? nowPlayingModel;
  Future<NowPlayingModel?> fetchNowPlaying() async {
    nowPlayingModel = (await getNowPlaying());
    notifyListeners();
    return null;
  }
}
