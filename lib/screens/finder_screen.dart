import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:movie_app/utils/scroll_top_with_controller.dart' as scroll_top;

import '../services/movie.dart';
import '../utils/constants.dart';
import '../widgets/custom_loading_spin_kit_ring.dart';
import '../widgets/custom_search_appbar_content.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_card_container.dart';
import '../widgets/shadowless_floating_button.dart';

class FinderScreen extends StatefulWidget {
  final Color themeColor;
  const FinderScreen({required this.themeColor});
  @override
  _FinderScreenState createState() => _FinderScreenState();
}

class _FinderScreenState extends State<FinderScreen> {
  String textFieldValue = "";
  //for scroll upping
  late ScrollController _scrollController;
  bool showBackToTopButton = false;
  List<MovieCard>? movieCards;
  bool showLoadingScreen = false;

  Future<void> loadData(String movieName) async {
    MovieModel movieModel = MovieModel();
    movieCards = await movieModel.searchMovies(
        movieName: movieName, themeColor: widget.themeColor) as List<MovieCard>;

    setState(() {
      scroll_top.scrollToTop(_scrollController);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          showBackToTopButton = (_scrollController.offset >= 200);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 18.h,
        title: Text(kFinderScreenTitleText, style: kSmallAppBarTitleTextStyle),
        backgroundColor: kSearchAppBarColor,
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
          child: CustomSearchAppbarContent(
              onChanged: (value) => textFieldValue = value,
              onEditingComplete: () {
                if (textFieldValue.isNotEmpty) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  showLoadingScreen = true;

                  setState(() {
                    movieCards = null;
                    loadData(textFieldValue);
                  });
                }
              }),
          preferredSize: Size.zero,
        ),
      ),
      body: (movieCards == null)
          ? ((showLoadingScreen)
              ? CustomLoadingSpinKitRing(loadingColor: widget.themeColor)
              : null)
          : (movieCards!.isEmpty)
              ? Center(
                  child: Text(
                  kNotFoundErrorText,
                  style: kSplashScreenTextStyle,
                ))
              : MovieCardContainer(
                  scrollController: _scrollController,
                  themeColor: widget.themeColor,
                  movieCards: movieCards!,
                ),
      floatingActionButton: showBackToTopButton
          ? ShadowlessFloatingButton(
              backgroundColor: widget.themeColor,
              iconData: Icons.keyboard_arrow_up_outlined,
              onPressed: () =>
                  setState(() => scroll_top.scrollToTop(_scrollController)),
            )
          : null,
    );
  }
}
