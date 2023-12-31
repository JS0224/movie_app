import 'package:challenge_toon/models/movie_model.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
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
      ),
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
              10,
            ),
            child: Column(
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'roboto',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
