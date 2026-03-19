import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'see_more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;
  late Future<List<MovieModel>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: FutureBuilder<List<MovieModel>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) return const SizedBox();

          final movies = snapshot.data!;

          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey<String>(movies[_currentPage].poster),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movies[_currentPage].poster),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ),

              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/available_now.png',
                        width: 220,
                      ),

                      SizedBox(
                        height: 480,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double value = 1.0;
                                if (_pageController.position.haveDimensions) {
                                  value = _pageController.page! - index;
                                  value = (1 - (value.abs() * 0.25)).clamp(
                                    0.0,
                                    1.0,
                                  );
                                }
                                return Center(
                                  child: Transform.scale(
                                    scale: value,
                                    child: Opacity(
                                      opacity: value.clamp(0.6, 1.0),
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 15,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    movies[index].poster,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Image.asset('assets/images/watch_now.png', width: 280),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Action",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SeeMoreScreen(movies: movies),
                                ),
                              ),
                              child: const Text(
                                "See More >",
                                style: TextStyle(color: Color(0xFFFFBB3B)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SizedBox(
                                width: 130,
                                child: MovieCard(movie: movies[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
