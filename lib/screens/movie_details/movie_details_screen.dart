import 'package:flutter/material.dart';
import '../../models/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                movie.backgroundImage,
                fit: BoxFit.cover,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Color(0xff121312),
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: const Color(0xFFFFBB3B),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFBB3B)),
                      Text(
                        " ${movie.rating}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time, color: Colors.white),
                      Text(
                        " ${movie.runtime} min",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.summary,
                    style: const TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
