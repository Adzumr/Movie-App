import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    Key? key,
    required this.movie,
    required this.imagePath,
    required this.rating,
    required this.releaseData,
  }) : super(key: key);

  final String movie;
  final String rating;
  final String releaseData;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.sp,
        horizontal: 15.sp,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(10.sp),
        style: ListTileStyle.drawer,
        tileColor: appColors.blackColor,
        leading:
            // Icon(
            //   Icons.slow_motion_video_sharp,
            //   size: 35.sp,
            //   color: appColors.whiteColor,
            // ),
            ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageBaseUrl + imagePath,
            height: 8.h,
            width: 20.w,
            fit: BoxFit.fill,
            placeholder: (context, url) => Icon(
              Icons.slow_motion_video_sharp,
              size: 35.sp,
              color: appColors.whiteColor,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        title: Text(
          movie,
          style: appFonts.bodyFont.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          releaseData,
          style: appFonts.smallBodyFont.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          "⭐  " + rating,
          style: appFonts.smallBodyFont.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
