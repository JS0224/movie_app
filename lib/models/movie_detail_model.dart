class MovieDetailModel {
  final String title, lan, homepage, overview;
  final num id, rating;
  final List<dynamic> genres;
  final bool isAdult;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['original_title'],
        lan = json['original_language'],
        homepage = json['homepage'],
        overview = json['overview'],
        id = json['id'],
        rating = json['vote_average'],
        isAdult = json['adult'],
        genres = (json['genres'] as List<dynamic>)
            .map((genre) => genre['name'].toString())
            .toList();
}
