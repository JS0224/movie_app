class MovieModel {
  final String title, overview, imageSrc;
  final num rating, id;
  final List<dynamic> genres;
  final bool isAdult;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        rating = json['vote_average'],
        id = json['id'],
        imageSrc = json['backdrop_path'],
        genres = json['genre_ids'],
        isAdult = json['adult'];
}
