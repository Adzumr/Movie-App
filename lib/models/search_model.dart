class SearchModel {
  final int? page;
  final List<Results>? results;
  final int? totalPages;
  final int? totalResults;

  SearchModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  SearchModel.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        results = (json['results'] as List?)
            ?.map((dynamic e) => Results.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPages = json['total_pages'] as int?,
        totalResults = json['total_results'] as int?;

  Map<String, dynamic> toJson() => {
        'page': page,
        'results': results?.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults
      };
}

class Results {
  final int? id;
  final dynamic logoPath;
  final String? name;
  final String? originCountry;

  Results({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  Results.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        logoPath = json['logo_path'],
        name = json['name'] as String?,
        originCountry = json['origin_country'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logoPath,
        'name': name,
        'origin_country': originCountry
      };
}
