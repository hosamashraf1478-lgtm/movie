import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();

  Future resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailController.text,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Verify Email")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),

      appBar: AppBar(
        backgroundColor: const Color(0xff121312),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Forget Password"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(
          children: [
            const SizedBox(height: 20),

            Image.asset("assets/images/forgetpasswor.png", height: 220),

            const SizedBox(height: 40),

            TextField(
              controller: emailController,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff282A28),

                prefixIcon: const Icon(Icons.email, color: Colors.white),

                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.grey),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFB83B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                onPressed: resetPassword,

                child: const Text(
                  "Verify Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
