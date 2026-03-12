import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  Future register() async {

    if (passwordController.text != confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords not match")),
      );

      return;
    }

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff121312),

      appBar: AppBar(
        backgroundColor: const Color(0xff121312),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Register"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(

            children: [

              const SizedBox(height: 20),

              /// avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                    AssetImage("assets/images/avatar1.png"),
                  ),

                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 45,
                    backgroundImage:
                    AssetImage("assets/images/avatar2.png"),
                  ),

                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                    AssetImage("assets/images/avatar3.png"),
                  ),

                ],
              ),

              const SizedBox(height: 10),

              const Text(
                "Avatar",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 30),

              buildField(Icons.person,"Name",nameController),

              const SizedBox(height: 15),

              buildField(Icons.email,"Email",emailController),

              const SizedBox(height: 15),

              buildPasswordField(
                  "Password",passwordController,obscure1,(){
                setState(() {
                  obscure1 = !obscure1;
                });
              }),

              const SizedBox(height: 15),

              buildPasswordField(
                  "Confirm Password",
                  confirmPasswordController,
                  obscure2,(){
                setState(() {
                  obscure2 = !obscure2;
                });
              }),

              const SizedBox(height: 15),

              buildField(Icons.phone,"Phone Number",phoneController),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFB83B),
                    padding:
                    const EdgeInsets.symmetric(vertical: 15),
                  ),

                  onPressed: register,

                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(
                    "Already Have Account ?",
                    style: TextStyle(color: Colors.white),
                  ),

                  TextButton(

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Color(0xffFFB83B)),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),

                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xffFFB83B)),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Image.asset(
                      "assets/images/EN.png",
                      height: 25,
                    ),

                    const SizedBox(width: 10),

                    Image.asset(
                      "assets/images/EG.png",
                      height: 25,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(icon,text,controller){

    return TextField(
      controller: controller,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(

        filled: true,
        fillColor: const Color(0xff282A28),

        prefixIcon: Icon(icon,color: Colors.white),

        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildPasswordField(
      text,controller,obscure,void Function()? press){

    return TextField(
      controller: controller,
      obscureText: obscure,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(

        filled: true,
        fillColor: const Color(0xff282A28),

        prefixIcon: const Icon(Icons.lock,color: Colors.white),

        suffixIcon: IconButton(
          icon: const Icon(Icons.visibility_off,
              color: Colors.white),
          onPressed: press,
        ),

        hintText: text,
        hintStyle: const TextStyle(color: Colors.grey),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}