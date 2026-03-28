import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/screens/movie_details/movie_details_screen.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final String emptyStateImagePath = "assets/images/search.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                String name = user?.displayName ?? 'User Name';
                String avatar =
                    user?.photoURL ?? 'https://i.ibb.co/L8N7p7v/avatar-1.png';

                if (snapshot.hasData && snapshot.data!.exists) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  name = data['name'] ?? name;
                  avatar = data['avatar'] ?? avatar;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF282A28),
                        backgroundImage: NetworkImage(avatar),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildLiveStat(
                                  user?.uid,
                                  "watchlist",
                                  "Watch List",
                                ),
                                const SizedBox(width: 30),
                                _buildLiveStat(user?.uid, "history", "History"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen(),
                          ),
                        );
                        if (result == true) setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBB3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    child: const Icon(Icons.exit_to_app, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: Color(0xFFFFBB3B),
                      labelColor: Color(0xFFFFBB3B),
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.list), text: "Watch List"),
                        Tab(icon: Icon(Icons.history), text: "History"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildFirebaseGrid('watchlist'),
                          _buildFirebaseGrid('history'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveStat(String? uid, String collection, String label) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection(collection)
          .snapshots(),
      builder: (context, snapshot) {
        String count = snapshot.hasData
            ? snapshot.data!.docs.length.toString()
            : "0";
        return Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFirebaseGrid(String collectionName) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection(collectionName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  emptyStateImagePath,
                  width: 140,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.movie_creation_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "No Movies Found",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        final moviesDocs = snapshot.data!.docs;
        return GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: moviesDocs.length,
          itemBuilder: (context, index) {
            final data = moviesDocs[index].data() as Map<String, dynamic>;
            final movie = MovieModel.fromJson(data);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(movie: movie),
                  ),
                );
              },
              child: MovieCard(movie: movie),
            );
          },
        );
      },
    );
  }
}
