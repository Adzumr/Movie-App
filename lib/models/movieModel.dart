import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  List? movieInfo;
  MovieDetail({Key? key, this.movieInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieInfo?.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    "http://image.tmdb.org/t/p/w500" +
                        movieInfo![index]["poster_path"],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        movieInfo![index]["title"],
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Rating: ${movieInfo![index]["vote_average"]}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    movieInfo![index]["overview"],
                    // maxLines: 8,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
