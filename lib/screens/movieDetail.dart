import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  String? title;
  String? overview;
  String? poster;
  MovieDetail({Key? key, this.title, this.overview, this.poster})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Image(
            //   image: AssetImage(poster!),
            //   height: 300,
            //   fit: BoxFit.contain,
            // ),
            Text(title!),
            Text(overview!),
          ],
        ),
      ),
    );
  }
}
