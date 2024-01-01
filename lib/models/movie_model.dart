class MovieModel {
  final String title, imageSrc;
  final num id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        imageSrc = json['backdrop_path'];
}
