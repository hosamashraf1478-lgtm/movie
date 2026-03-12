import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn, GoogleSignInAccount;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/screens/auth/forgot_password.dart';

import 'register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  final auth = FirebaseAuth.instance;

  Future login() async {

    await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  Future signInWithGoogle() async {

    // final GoogleSignIn googleSignIn = GoogleSignIn();
    //
    // final GoogleSignInAccount? googleUser =
    // await googleSignIn.signIn();
    //
    // if (googleUser == null) return;
    //
    // await googleUser.authentication;
    //
    // final credential = GoogleAuthProvider.credential(
    // );
    //
    // await auth.signInWithCredential(credential);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  String currentLang = "EN";

  void changeLanguage() {
    setState(() {
      currentLang = currentLang == "EN" ? "AR" : "EN";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff121312),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(

            children: [

              const SizedBox(height: 90),

              Image.asset(
                "assets/images/login.png",
                height: 90,
              ),

              const SizedBox(height: 50),

              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff282A28),

                  prefixIcon:
                  const Icon(Icons.email, color: Colors.white),

                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: obscure,
                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff282A28),

                  prefixIcon:
                  const Icon(Icons.lock, color: Colors.white),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),

                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// Forget password button
              Align(
                alignment: Alignment.centerRight,

                child: TextButton(

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const ForgetPasswordScreen(),
                      ),
                    );

                  },

                  child: const Text(
                    "Forget Password ?",
                    style: TextStyle(color: Color(0xffFFB83B)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFB83B),
                    padding:
                    const EdgeInsets.symmetric(vertical: 15),
                  ),

                  onPressed: login,

                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFB83B),
                    padding:
                    const EdgeInsets.symmetric(vertical: 15),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const RegisterScreen(),
                      ),
                    );

                  },

                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// OR
              Row(
                children: const [

                  Expanded(
                      child: Divider(
                        color: Color(0xffFFB83B),
                        thickness: 1,
                      )),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "OR",
                      style: TextStyle(
                          color: Color(0xffFFB83B)),
                    ),
                  ),

                  Expanded(
                      child: Divider(
                        color: Color(0xffFFB83B),
                        thickness: 1,
                      )),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFB83B),
                    padding:
                    const EdgeInsets.symmetric(vertical: 15),
                  ),

                  onPressed: signInWithGoogle,

                  icon: Image.asset(
                    "assets/images/Google.png",
                    height: 25,
                  ),

                  label: const Text(
                    "Login With Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: changeLanguage,

                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),

                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xffFFB83B)),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Image.asset(
                        currentLang == "EN"
                            ? "assets/images/EN.png"
                            : "assets/images/EG.png",
                        height: 25,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        currentLang,
                        style: const TextStyle(
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}