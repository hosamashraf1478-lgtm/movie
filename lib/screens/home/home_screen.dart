import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Movies"),
      ),

      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}