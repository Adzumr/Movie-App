import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/widgets/movie_list_tile.dart';
import 'package:movie_app/widgets/shimmer_card.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/my_app_bar.dart';

class TopRatedMoviesScreen extends StatefulWidget {
  const TopRatedMoviesScreen({Key? key}) : super(key: key);

  @override
  State<TopRatedMoviesScreen> createState() => _TopRatedMoviesScreenState();
}

class _TopRatedMoviesScreenState extends State<TopRatedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MovieProvider>(context);
    return Scaffold(
      backgroundColor: appColors.blackColor.withOpacity(.9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MyAppBar(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Movies",
                    style: appFonts.titleFont.copyWith(
                      color: appColors.whiteColor.withOpacity(.7),
                    ),
                  ),
                  Text(
                    formatDate(DateTime.now(), [DD, " - ", d, ", ", MM]),
                    style: appFonts.bodyFont.copyWith(
                      color: appColors.whiteColor.withOpacity(.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: FutureBuilder(
                future: movieData.getMoviePost(page: "top_rated"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const MovieListShimmerCard();
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: movieData.movieModel!.results!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final movie = movieData.movieModel!.results![index];
                        return MovieListTile(
                          imagePath: movie.backdropPath!,
                          movie: movie.title!,
                          releaseData: movie.releaseDate!,
                          rating: "${movie.voteAverage}",
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
