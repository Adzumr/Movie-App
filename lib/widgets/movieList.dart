import 'package:flutter/material.dart';
import 'package:movie_app/screens/movieDetail.dart';

class MovieList extends StatelessWidget {
  List? movieInfo;
  MovieList({Key? key, this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movieInfo?.length,
      itemBuilder: (BuildContext context, int index) {
        final String? posterPath =
            "http://image.tmdb.org/t/p/w500" + movieInfo![index]["poster_path"];
        final String? movieTitle = movieInfo![index]["title"];
        final String? movieOverview = movieInfo![index]["overview"];
        final String? movieGenre = movieInfo![index]["homepage"];

        //  production_companies[5].name

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MovieDetail(
                          overview: movieOverview,
                          poster: posterPath,
                          title: movieTitle,
                          genres: movieGenre,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    width: 180,
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      posterPath!,
                    ),
                  ),
                ),
                Text(
                  movieTitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
