import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/MoviesPosters.png",
      "title": "Find Your Next Favorite Movie Here",
      "subtitle":
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": "assets/images/Discover.jpg",
      "title": "Discover Movies",
      "subtitle":
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    },
    {
      "image": "assets/images/Explorer.jpg",
      "title": "Explore All Genres",
      "subtitle":
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": "assets/images/Creat.jpg",
      "title": "Create Watchlists",
      "subtitle":
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    },
    {
      "image": "assets/images/Rate.jpg",
      "title": "Rate, Review, and Learn",
      "subtitle":
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": "assets/images/Start.jpg",
      "title": "Start Watching Now",
      "subtitle": "",
    },
  ];

  void nextPage() {
    if (_pageController.page!.toInt() < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void previousPage() {
    if (_pageController.page!.toInt() > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final data = onboardingData[index];
          return Stack(
            children: [
              GestureDetector(
                onTap: nextPage,
                child: Image.asset(
                  data["image"]!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data["title"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      if (data["subtitle"] != "")
                        Text(
                          data["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          if (index > 0)
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFFFB83B),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: previousPage,
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                          if (index > 0) const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFB83B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: nextPage,
                              child: Text(
                                index < onboardingData.length - 1
                                    ? "Next"
                                    : "Finish",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
