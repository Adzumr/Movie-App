import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/popular_model.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

import 'detailed_screen.dart';

class PopularListScreen extends StatefulWidget {
  final PopularModel? models;
  const PopularListScreen({this.models, Key? key}) : super(key: key);

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  @override
  Widget build(BuildContext context) {
    final model = widget.models;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appColors.backgorundColor,
        title: const Text(
          "Popular Movies",
        ),
      ),
      backgroundColor: appColors.backgorundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: ListView.builder(
            itemCount: model!.results!.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = model.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        movieId: "${movie.id}",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: imageBaseUrl + "${movie.posterPath}",
                          height: 18.h,
                          width: 18.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Text(
                              "No\nImage",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        width: 35.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.results![index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: appFonts.bodyFont.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Ionicons.star,
                                  color: Colors.yellow,
                                  size: 15.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  model.results![index].voteAverage!.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: appFonts.smallBodyFont,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Ionicons.calendar_outline,
                                  color: appColors.whiteColor,
                                  size: 15.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  model.results![index].releaseDate!,
                                  overflow: TextOverflow.ellipsis,
                                  style: appFonts.smallBodyFont,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
