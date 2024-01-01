import 'package:challenge_toon/models/movie_detail_model.dart';
import 'package:challenge_toon/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final num id;
  final String imageSrc;

  const DetailScreen({
    super.key,
    required this.id,
    required this.imageSrc,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// DetailScreenState
class _DetailScreenState extends State<DetailScreen> {
  final String baseUrl = 'https://image.tmdb.org/t/p/w500/';
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();

    movie = ApiService.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const DetailScreenAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              baseUrl + widget.imageSrc,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width * 0.6,
            ),
            FutureBuilder(
              future: movie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: buildRatingStars(snapshot.data!.rating),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: buildMinorInfo(snapshot.data),
                        ),
                        Text(
                          "Overview",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          snapshot.data!.overview,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        YellowButton(url: snapshot.data!.homepage),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRatingStars(num rating) {
    final double changedRating = rating.toInt() / 2;
    final int numberOfFullStars = changedRating.toInt();
    final bool hasHalfStar = (changedRating - numberOfFullStars) == 0.5;

    return Row(
      children: List.generate(
        5,
        (index) {
          if (index < numberOfFullStars) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          } else if (index == numberOfFullStars && hasHalfStar) {
            return const Icon(
              Icons.star_half,
              color: Colors.amber,
            );
          } else {
            return const Icon(
              Icons.star_border,
              color: Colors.amber,
            );
          }
        },
      ),
    );
  }

  Widget buildMinorInfo(MovieDetailModel? data) {
    return Row(
      children: [
        DisplaySmallText(data!.genres.join(", ")),
        const Text("  |  "),
        DisplaySmallText(data.lan),
        const Text("  |  "),
        data.isAdult
            ? DisplaySmallText("Adults Only")
            : DisplaySmallText("Kids"),
      ],
    );
  }

  Widget DisplaySmallText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class DetailScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailScreenAppBar({
    super.key,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      title: const Align(
        alignment: Alignment.centerLeft, // Align the title to the left
        child: Text(
          'Back To List',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Transform.scale(
          scale: 0.8,
          child: const Icon(Icons.arrow_back_ios),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class YellowButton extends StatelessWidget {
  final String url;
  const YellowButton({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            launchUrl(Uri.parse(url));
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 234, 221, 162),
            backgroundColor: Colors.pink,
            minimumSize: const Size(200, 70),
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ), // Darker color for focused effect
          ),
          child: const Text(
            'Go to Homepage',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
