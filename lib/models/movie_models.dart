class MovieSummary {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MovieSummary({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    return MovieSummary(
      title: json['Title'] as String,
      year: json['Year'] as String,
      imdbID: json['imdbID'] as String,
      type: json['Type'] as String,
      poster: json['Poster'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Year': year,
      'imdbID': imdbID,
      'Type': type,
      'Poster': poster,
    };
  }
}

class MovieSearchResponse {
  final List<MovieSummary> search;
  final String totalResults;
  final String response;

  MovieSearchResponse({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) {
    final searchList = (json['Search'] as List)
        .map((item) => MovieSummary.fromJson(item))
        .toList();

    return MovieSearchResponse(
      search: searchList,
      totalResults: json['totalResults'] as String,
      response: json['Response'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Search': search.map((m) => m.toJson()).toList(),
      'totalResults': totalResults,
      'Response': response,
    };
  }
}
