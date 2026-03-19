import 'package:flutter/material.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: FutureBuilder<List<MovieModel>>(
        future: ApiService().fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final movies = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieCard(movie: movies[index]),
            );
          }

          return const Center(
            child: Text(
              "No movies found - Check Internet or API URL",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
