import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
    RegisterScreen({super.key});

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
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      showError("يرجى ملء جميع الحقول");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showError("كلمات المرور غير متطابقة");
      return;
    }

    if (passwordController.text.length < 8) {
      showError("كلمة المرور يجب أن تكون 8 أحرف على الأقل");
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message = "حدث خطأ ما";
      if (e.code == 'email-already-in-use') {
        message = "هذا البريد الإلكتروني مسجل بالفعل";
      } else if (e.code == 'invalid-email') {
        message = "صيغة البريد الإلكتروني غير صحيحة";
      } else if (e.code == 'weak-password') {
        message = "كلمة المرور ضعيفة جداً";
      }
      showError(message);
    } catch (e) {
      showError("تعذر الاتصال بالخادم");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Color(0xff121312),
      appBar: AppBar(
        backgroundColor:   Color(0xff121312),
        elevation: 0,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:   Text("Register", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
                SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/avatar1.png"),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/avatar2.png"),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/avatar3.png"),
                  ),
                ],
              ),
                SizedBox(height: 10),
                Text("Avatar", style: TextStyle(color: Colors.white)),
                SizedBox(height: 30),

              buildField(Icons.person, "Name", nameController),
                SizedBox(height: 15),
              buildField(
                Icons.email,
                "Email",
                emailController,
                type: TextInputType.emailAddress,
              ),
                SizedBox(height: 15),

              buildPasswordField("Password", passwordController, obscure1, () {
                setState(() => obscure1 = !obscure1);
              }),
                SizedBox(height: 15),

              buildPasswordField(
                "Confirm Password",
                confirmPasswordController,
                obscure2,
                () {
                  setState(() => obscure2 = !obscure2);
                },
              ),
                SizedBox(height: 15),

              buildField(
                Icons.phone,
                "Phone Number",
                phoneController,
                type: TextInputType.phone,
              ),
                SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:   Color(0xffFFB83B),
                    padding:   EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: isLoading ? null : register,
                  child: isLoading
                      ?   SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      :   Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

                SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                    "Already Have Account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child:   Text(
                      "Login",
                      style: TextStyle(color: Color(0xffFFB83B)),
                    ),
                  ),
                ],
              ),
                SizedBox(height: 20),

              Container(
                padding:   EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color:   Color(0xffFFB83B)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/EN.png",
                      height: 25,
                      errorBuilder: (c, e, s) =>
                            Icon(Icons.flag, color: Colors.white),
                    ),
                      SizedBox(width: 10),
                    Image.asset(
                      "assets/images/EG.png",
                      height: 25,
                      errorBuilder: (c, e, s) =>
                            Icon(Icons.flag, color: Colors.white),
                    ),
                  ],
                ),
              ),
                SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
    IconData icon,
    String text,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      style:   TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor:   Color(0xff282A28),
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: text,
        hintStyle:   TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildPasswordField(
    String text,
    TextEditingController controller,
    bool obscure,
    VoidCallback press,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style:   TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor:   Color(0xff282A28),
        prefixIcon:   Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: press,
        ),
        hintText: text,
        hintStyle:   TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
