class MovieModel {
  final int? page;
  final List<Results>? results;
  final int? totalPages;
  final int? totalResults;

  MovieModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MovieModel.fromJson(Map<String, dynamic> json)
    : page = json['page'] as int?,
      results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList(),
      totalPages = json['total_pages'] as int?,
      totalResults = json['total_results'] as int?;

  Map<String, dynamic> toJson() => {
    'page' : page,
    'results' : results?.map((e) => e.toJson()).toList(),
    'total_pages' : totalPages,
    'total_results' : totalResults
  };
}

class Results {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json)
    : adult = json['adult'] as bool?,
      backdropPath = json['backdrop_path'] as String?,
      genreIds = (json['genre_ids'] as List?)?.map((dynamic e) => e as int).toList(),
      id = json['id'] as int?,
      originalLanguage = json['original_language'] as String?,
      originalTitle = json['original_title'] as String?,
      overview = json['overview'] as String?,
      popularity = json['popularity'] as double?,
      posterPath = json['poster_path'] as String?,
      releaseDate = json['release_date'] as String?,
      title = json['title'] as String?,
      video = json['video'] as bool?,
      voteAverage = json['vote_average'] as double?,
      voteCount = json['vote_count'] as int?;

  Map<String, dynamic> toJson() => {
    'adult' : adult,
    'backdrop_path' : backdropPath,
    'genre_ids' : genreIds,
    'id' : id,
    'original_language' : originalLanguage,
    'original_title' : originalTitle,
    'overview' : overview,
    'popularity' : popularity,
    'poster_path' : posterPath,
    'release_date' : releaseDate,
    'title' : title,
    'video' : video,
    'vote_average' : voteAverage,
    'vote_count' : voteCount
  };
}