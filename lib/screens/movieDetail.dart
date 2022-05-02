import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  String? title;
  String? overview;
  String? poster;
  String? genres;
  MovieDetail({Key? key, this.title, this.overview, this.poster, this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image(
                  height: 300,
                  // width: double.infinity,
                  fit: BoxFit.fill,
                  image: NetworkImage(poster!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Text("$genres"),
                  Text(title!),
                  Text(overview!),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
