import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:challenge_toon/models/movie_model.dart';
import 'package:challenge_toon/services/api_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> cinemaMovies = ApiService.getCinemaMovies();
  final Future<List<MovieModel>> upcomingMovies =
      ApiService.getUpcomingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(text: 'Popular Movies'),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makePopularMovieList(snapshot.data!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const TitleText(text: 'Now in Cinemas'),
            SizedBox(
              height: 280,
              child: FutureBuilder(
                future: cinemaMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makeMovieWithTitleList(snapshot.data!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const TitleText(text: 'Coming soon'),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
      ),
      child: Text(
        text,
        style: GoogleFonts.hammersmithOne(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
          textBaseline: TextBaseline.ideographic,
          //height: 0.4,
        ),
      ),
    );
  }
}

ListView makePopularMovieList(List<MovieModel> movieModelData) {
  var baseUrl = "https://image.tmdb.org/t/p/w500";

  return ListView.separated(
    itemBuilder: (context, index) {
      var data = movieModelData[index];
      return Container(
        width: 310,
        height: 180,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(-5, 5),
              color: Colors.black
                  .withOpacity(0.3), // changes the position of the shadow
            ),
          ],
        ),
        child: Image.network(baseUrl + data.imageSrc,
            width: double
                .infinity, // Make sure the image takes the full width of the container
            height: double
                .infinity, // Make sure the image takes the full height of the container
            fit: BoxFit.cover),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 15,
    ),
    itemCount: movieModelData.length,
    scrollDirection: Axis.horizontal,
    // padding: EdgeInsets.,
  );
}

ListView makeMovieWithTitleList(List<MovieModel> movieModelData) {
  var baseUrl = "https://image.tmdb.org/t/p/w500";

  return ListView.separated(
    itemBuilder: (context, index) {
      var data = movieModelData[index];
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background
          Container(
            width: 150,
            height: 150, // Adjust height as needed
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: const Offset(-5, 5),
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: Image.network(
              baseUrl + data.imageSrc,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 155,
            child: SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Allows text to overflow its container
                  maxLines: 3,
                ),
              ),
            ),
          ),
        ],
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 15,
    ),
    itemCount: movieModelData.length,
    scrollDirection: Axis.horizontal,
  );
}
