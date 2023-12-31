import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:challenge_toon/models/movie_model.dart';
import 'package:challenge_toon/services/api_services.dart';
import 'package:challenge_toon/screens/detail_screen.dart';

// HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// HomeScreenState
class _HomeScreenState extends State<HomeScreen> {
  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> cinemaMovies = ApiService.getCinemaMovies();
  final Future<List<MovieModel>> upcomingMovies =
      ApiService.getUpcomingMovies();

  final ScrollController _scrollController = ScrollController();
  var isEndOfScroll = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      isEndOfScroll = true;
    } else {
      isEndOfScroll = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: 'Popular Movies'),
              MovieCard(
                200,
                popularMovies,
                makePopularMovieList,
              ),
              const TitleText(text: 'Now in Cinemas'),
              MovieCard(
                240,
                cinemaMovies,
                makeMovieWithTitleList,
              ),
              const TitleText(text: 'Coming soon'),
              MovieCard(
                240,
                upcomingMovies,
                makeMovieWithTitleList,
              ),
              isEndOfScroll
                  ? const Text("End of the content")
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
SizedBox MovieCard(
  double heightForBox,
  Future<List<MovieModel>> movieModelData,
  ListView Function(List<MovieModel> movieModelData) listBuilder,
) {
  return SizedBox(
    height: heightForBox,
    child: FutureBuilder(
      future: movieModelData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listBuilder(snapshot.data!);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );
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
      return GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(movie: data),
            ),
          ),
        },
        child: Container(
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
        ),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
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
