import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        title: const Text("Movies", style: TextStyle(color: Color(0xFFFFBB3B))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<MovieModel>>(
        future: ApiService().fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          List blockedIds = [
            75037,
            75042,
            75041,
            75033,
            75043,
            75025,
            75035,
            75038,
            75029,
            75028,
          ];

          final movies = snapshot.data!
              .where((movie) => !blockedIds.contains(movie.id))
              .toList();
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) => MovieCard(movie: movies[index]),
          );
        },
      ),
    );
  }
}
