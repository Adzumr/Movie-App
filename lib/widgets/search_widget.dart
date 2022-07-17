import 'dart:developer';

import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/input_borders.dart';

class SearchWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  const SearchWidget({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        log(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: appColors.grayColor,
        prefixIcon: Icon(
          Icons.slow_motion_video_outlined,
          color: appColors.blackColor,
        ),
        labelText: "Search Movie",
        border: enableInputBorder,
        enabledBorder: enableInputBorder,
      ),
    );
  }
}
