import 'package:flutter/material.dart';
import '../../models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

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

                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: movie.genres
                        .map(
                          (genre) => Chip(
                            label: Text(
                              genre.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                          "https://www.youtube.com/watch?v=${movie.ytTrailerCode}",
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          debugPrint("Could not launch $url");
                        }
                      },
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Watch Trailer",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBB3B),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
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
