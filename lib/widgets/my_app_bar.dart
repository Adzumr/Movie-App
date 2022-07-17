import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget {
  final String? pageTitle;
  const MyAppBar({
    this.pageTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Text(
          pageTitle ?? "Movies",
          style: appFonts.titleFont.copyWith(color: appColors.blackColor),
        ),
      ),
    );
  }
}
