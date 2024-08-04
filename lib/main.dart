import 'package:challenge_toon/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:challenge_toon/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.hammersmithOne(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            textBaseline: TextBaseline.ideographic,
          ),
          titleMedium: GoogleFonts.notoSans(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.notoSans(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
          displayLarge: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          displaySmall: const TextStyle(fontSize: 15, color: Colors.white60),
        ),
      ),
      home: const RegisterScreen() //const HomeScreen(),
    );
  }
}


/*
popular
 "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/5a4JdoFwll5DRtKMe7JLuGQ9yJm.jpg",
            "genre_ids": [
                18,
                878,
                28
            ],
            "id": 695721,
            "original_language": "en",
            "original_title": "The Hunger Games: The Ballad of Songbirds & Snakes",
            "overview": "64 years before he becomes the tyrannical president of Panem, Coriolanus Snow sees a chance for a change in fortunes when he mentors Lucy Gray Baird, the female tribute from District 12.",
            "popularity": 3233.513,
            "poster_path": "/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
            "release_date": "2023-11-15",
            "title": "The Hunger Games: The Ballad of Songbirds & Snakes",
            "video": false,
            "vote_average": 7.219,
            "vote_count": 1027
        },
// image

========================================
coming soon

{
    "dates": {
        "maximum": "2024-01-17",
        "minimum": "2023-12-27"
    },
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/bckxSN9ueOgm0gJpVJmPQrecWul.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 572802,
            "original_language": "en",
            "original_title": "Aquaman and the Lost Kingdom",
            "overview": "Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction.",
            "popularity": 1999.169,
            "poster_path": "/8xV47NDrjdZDpkVcCFqkdHa3T0C.jpg",
            "release_date": "2023-12-20",
            "title": "Aquaman and the Lost Kingdom",
            "video": false,
            "vote_average": 6.55,
            "vote_count": 179
        },

// title, image

===============================================
// Detail
 https://moviesapi.nomadcoders.workers.dev/movie?id=1


    "adult": false,
    "backdrop_path": "/bckxSN9ueOgm0gJpVJmPQrecWul.jpg",
    "belongs_to_collection": {
        "id": 573693,
        "name": "Aquaman Collection",
        "poster_path": "/rNQompSTfAG5O2iXSH8Phay4L45.jpg",
        "backdrop_path": "/5iidzov8DrsSyZdefeo7jBLDNUW.jpg"
    },
    "budget": 205000000,
    "genres": [
        {
            "id": 28,
            "name": "Action"
        },
        {
            "id": 12,
            "name": "Adventure"
        },
        {
            "id": 14,
            "name": "Fantasy"
        }
    ],
    "homepage": "http://www.aquamanmovie.com",
    "id": 572802,
    "imdb_id": "tt9663764",
    "original_language": "en",
    "original_title": "Aquaman and the Lost Kingdom",
    "overview": "Black Manta, still driven by the need to avenge his father's death and wielding the power of the mythic Black Trident, will stop at nothing to take Aquaman down once and for all. To defeat him, Aquaman must turn to his imprisoned brother Orm, the former King of Atlantis, to forge an unlikely alliance in order to save the world from irreversible destruction.",
    "popularity": 1999.169,
    "poster_path": "/8xV47NDrjdZDpkVcCFqkdHa3T0C.jpg",
    "production_companies": [

// 영화의 포스터.
영화의 제목.
영화의 등급.
영화의 개요.
영화의 장르.

 */
