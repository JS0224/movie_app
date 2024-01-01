import 'package:challenge_toon/models/movie_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final MovieModel movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

// DetailScreenState
class _DetailScreenState extends State<DetailScreen> {
  final baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const DetailScreenAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            baseUrl + widget.movie.imageSrc,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.all(
              15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: buildRatingStars(widget.movie.rating),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.movie.genres.toString(),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text("  |  ",
                          style: Theme.of(context).textTheme.displaySmall),
                      widget.movie.isAdult
                          ? Text("Adults Only",
                              style: Theme.of(context).textTheme.displaySmall)
                          : Text("Kids",
                              style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                ),
                Text(
                  "Overview",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  widget.movie.overview,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ],
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
