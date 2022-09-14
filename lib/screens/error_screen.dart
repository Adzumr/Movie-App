import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgorundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Column(
                children: [
                  Image(
                    image: AssetImage(appImages.errorImage),
                    height: 25.h,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Something Went Wrong",
                    textAlign: TextAlign.center,
                    style: appFonts.titleFont,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "May be bigfoot has broken this page.\nCome back to the homepage",
                    textAlign: TextAlign.center,
                    style: appFonts.bodyFont.copyWith(
                      color: appColors.shadowColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFF54A353),
                    foregroundColor: appColors.whiteColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
