import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  List? movieInfo;
  MovieDetail({Key? key, this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: movieInfo?.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    // height: 200,
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      "http://image.tmdb.org/t/p/w500" +
                          movieInfo![index]["poster_path"],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movieInfo![index]["title"]),
                    Text(movieInfo![index]["release_date"]),
                    Text(movieInfo![index]["overview"]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
