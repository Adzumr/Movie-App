import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/get_detail_provider.dart';

class DetailedScreen extends StatefulWidget {
  final String? movieId;
  const DetailedScreen({this.movieId, Key? key}) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  void initState() {
    final data = Provider.of<GetDetailProvider>(context, listen: false);
    getData = data.fetchDetail(keyWord: "${widget.movieId}");
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    );
  }

  late Future getData;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GetDetailProvider>(context);

    return Scaffold(
      backgroundColor: appColors.backgorundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appColors.backgorundColor,
        title: const Text("Detail"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final movie = data.movieModel;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(15.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.sp),
                        height: 35.h,
                        width: 60.w,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: CachedNetworkImage(
                                imageUrl:
                                    imageBaseUrl + "${movie!.backdropPath}",
                                height: 25.h,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => const Center(
                                  child: Text(
                                    "Loading...",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Text(
                                    "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 20.sp,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          imageBaseUrl + "${movie.posterPath}",
                                      height: 20.h,
                                      width: 15.h,
                                      placeholder: (context, url) =>
                                          const SizedBox.shrink(),
                                      errorWidget: (context, url, error) =>
                                          const SizedBox.shrink(),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 45.w,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.sp),
                                      child: Text(
                                        "${movie.title}",
                                        style: appFonts.titleFont,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Ionicons.calendar_number,
                                color: appColors.whiteColor,
                                size: 10.sp,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                "${movie.releaseDate}",
                                style: appFonts.smallBodyFont,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Ionicons.time_outline,
                                color: appColors.whiteColor,
                                size: 10.sp,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                "${movie.runtime} Minutes",
                                style: appFonts.smallBodyFont,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Ionicons.person,
                                color: appColors.whiteColor,
                                size: 10.sp,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                movie.spokenLanguages!.first.englishName!,
                                style: appFonts.smallBodyFont,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "About Movie",
                        style: appFonts.titleFont,
                      ),
                      SizedBox(height: 0.5.h),
                      movie.overview!.isEmpty
                          ? Text(
                              "Not Available",
                              style: appFonts.bodyFont,
                            )
                          : Text(
                              "${movie.overview}",
                              style: appFonts.bodyFont,
                            )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
