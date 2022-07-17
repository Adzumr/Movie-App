import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    final getPopular = Provider.of<MovieProvider>(context, listen: false);
    getMovie = getPopular.getMoviePost(page: "popular");
    super.initState();
  }

  late Future getMovie;
  @override
  Widget build(BuildContext context) {
    final getPopular = Provider.of<MovieProvider>(context);
    return Scaffold(
      backgroundColor: appColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: FutureBuilder(
            future: getMovie,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final movie = getPopular.movieModel!.results![0];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    backgroundColor: appColors.whiteColor.withOpacity(.4),
                    child: CloseButton(
                      color: appColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + movie.posterPath!,
                      height: 20.h,
                      width: 100.w,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Icon(
                        Icons.slow_motion_video_sharp,
                        size: 35.sp,
                        color: appColors.whiteColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    movie.title!,
                    textAlign: TextAlign.center,
                    style: appFonts.headingFont,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Release on: ${movie.releaseDate}",
                        textAlign: TextAlign.center,
                        style: appFonts.smallBodyFont,
                      ),
                      Text(
                        "⭐  ${movie.voteAverage}",
                        textAlign: TextAlign.center,
                        style: appFonts.smallBodyFont.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text("Plot cast:", style: appFonts.titleFont),
                  SizedBox(height: 3.h),
                  Text("${movie.overview}", style: appFonts.bodyFont),
                  SizedBox(height: 8.h),
                  Text("Poster:", style: appFonts.titleFont),
                  SizedBox(height: 1.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageBaseUrl + movie.backdropPath!,
                      height: 15.h,
                      width: 100.w,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Icon(
                        Icons.slow_motion_video_sharp,
                        size: 35.sp,
                        color: appColors.whiteColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
