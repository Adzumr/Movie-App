const apiKey = "fd19e5028622149c74b00a1f5265ad9d";
const imageBaseUrl = "https://image.tmdb.org/t/p/original";
final header = {
  "X-RapidAPI-Key": apiKey,
};
String movieUrl(String? page) {
  return "https://api.themoviedb.org/3/movie/$page?api_key=$apiKey&language=en-US";
}

String searchUrl(String? movieName) {
  return "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$movieName&page=1&include_adult=false";
}

String getDetailUrl(String? movieId) {
  return "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=en-US";
}
