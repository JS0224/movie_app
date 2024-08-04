import 'dart:convert';

import 'package:challenge_toon/models/movie_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:challenge_toon/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String cinema = "now-playing";
  static const String upcoming = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    return common(popular);
  }

  static Future<List<MovieModel>> getCinemaMovies() async {
    return common(cinema);
  }

  static Future<List<MovieModel>> getUpcomingMovies() async {
    return common(upcoming);
  }

  static Future<MovieDetailModel> getMovieDetail(num movieId) async {
    final movieIdUrl = "movie?id=$movieId";
    final url = Uri.parse('$baseUrl/$movieIdUrl');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return MovieDetailModel.fromJson(result);
    }

    throw Error();
  }

  static Future<List<MovieModel>> common(String keyword) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final movies = result['results'];
      for (var movie in movies) {
        final movieInstance = MovieModel.fromJson(movie);
        movieInstances.add(movieInstance);
      }
      return movieInstances;
    }

    throw Error();
  }
}
