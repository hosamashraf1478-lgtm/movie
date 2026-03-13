import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import '../screens/movie_details/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(movie.mediumCoverImage, fit: BoxFit.cover),
            ),
          ),
          Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
          Text(movie.year, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}