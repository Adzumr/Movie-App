import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MovieListShimmerCard extends StatelessWidget {
  const MovieListShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: appColors.whiteColor,
      baseColor: appColors.grayColor.withOpacity(.1),
      direction: ShimmerDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              ShimmerWidget(
                height: 10.h,
                width: 10.h,
              ),
              SizedBox(width: 2.w),
              Column(
                children: [
                  ShimmerWidget(
                    height: 3.h,
                    width: 25.h,
                  ),
                  SizedBox(height: 2.h),
                  ShimmerWidget(
                    height: 1.h,
                    width: 25.h,
                  ),
                ],
              ),
              SizedBox(width: 2.w),
              ShimmerWidget(
                height: 5.h,
                width: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerWidget({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColors.grayColor.withOpacity(.3),
      ),
      height: height,
      width: width,
    );
  }
}
