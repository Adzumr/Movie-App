const apiKey = "fd19e5028622149c74b00a1f5265ad9d";
const imageBaseUrl = "https://image.tmdb.org/t/p/original";
String movieUrl(String? page) {
  return "https://api.themoviedb.org/3/movie/$page?api_key=$apiKey&language=en-US";
}

String searchUrl(String? movieName) {
  return "https://api.themoviedb.org/3/search/company?api_key=$apiKey&query=$movieName&page=1";
}
