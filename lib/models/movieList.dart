import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  List? movieInfo;
  MovieList({Key? key, this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieInfo?.length,
      itemBuilder: (BuildContext context, int index) {
        final String? posterPath =
            "http://image.tmdb.org/t/p/w500" + movieInfo![index]["poster_path"];
        final String? movieTitle = movieInfo![index]["title"];
        return Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  width: 180,
                  // height: 100,
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    posterPath!,
                  ),
                ),
              ),
              Text(
                movieTitle!,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
