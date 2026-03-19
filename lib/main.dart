import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/screens/profile/update_profile_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase loading error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121312),
        primaryColor: const Color(0xFFFFBB3B),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121312),
          elevation: 0,
          centerTitle: true,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF282A28),
          selectedItemColor: Color(0xFFFFBB3B),
          unselectedItemColor: Colors.white54,
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/update-profile': (context) => const UpdateProfileScreen(),
      },
    );
  }
}
