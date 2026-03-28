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
  bool isLoading = false;

  String currentLang = "EN";

  final Map<String, Map<String, String>> translation = {
    "EN": {
      "title": "Register",
      "avatar": "Avatar",
      "name": "Name",
      "email": "Email",
      "password": "Password",
      "confirm": "Confirm Password",
      "phone": "Phone Number",
      "create": "Create Account",
      "have_account": "Already Have Account ?",
      "login": "Login",
      "error_fields": "Please fill all fields",
      "error_match": "Passwords do not match",
      "error_short": "Password must be at least 8 characters",
    },
    "AR": {
      "title": "إنشاء حساب",
      "avatar": "الصورة الشخصية",
      "name": "الاسم",
      "email": "البريد الإلكتروني",
      "password": "كلمة المرور",
      "confirm": "تأكيد كلمة المرور",
      "phone": "رقم الهاتف",
      "create": "إنشاء حساب",
      "have_account": "لديك حساب بالفعل؟",
      "login": "تسجيل الدخول",
      "error_fields": "يرجى ملء جميع الحقول",
      "error_match": "كلمات المرور غير متطابقة",
      "error_short": "كلمة المرور يجب أن تكون 8 أحرف على الأقل",
    }
  };

  void changeLanguage(String lang) {
    setState(() {
      currentLang = lang;
    });
  }

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
    var words = translation[currentLang]!;

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      showError(words["error_fields"]!);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showError(words["error_match"]!);
      return;
    }

    if (passwordController.text.length < 8) {
      showError(words["error_short"]!);
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
      String message = currentLang == "EN" ? "An error occurred" : "حدث خطأ ما";
      if (e.code == 'email-already-in-use') {
        message = currentLang == "EN" ? "Email already in use" : "هذا البريد الإلكتروني مسجل بالفعل";
      } else if (e.code == 'invalid-email') {
        message = currentLang == "EN" ? "Invalid email format" : "صيغة البريد الإلكتروني غير صحيحة";
      } else if (e.code == 'weak-password') {
        message = currentLang == "EN" ? "Password is too weak" : "كلمة المرور ضعيفة جداً";
      }
      showError(message);
    } catch (e) {
      showError(currentLang == "EN" ? "Connection error" : "تعذر الاتصال بالخادم");
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
    var words = translation[currentLang]!;

    return Scaffold(
      backgroundColor: const Color(0xff121312),
      appBar: AppBar(
        backgroundColor: const Color(0xff121312),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(words["title"]!, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
              const SizedBox(height: 10),
              Text(words["avatar"]!, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 30),

              buildField(Icons.person, words["name"]!, nameController),
              const SizedBox(height: 15),
              buildField(
                Icons.email,
                words["email"]!,
                emailController,
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              buildPasswordField(words["password"]!, passwordController, obscure1, () {
                setState(() => obscure1 = !obscure1);
              }),
              const SizedBox(height: 15),

              buildPasswordField(
                words["confirm"]!,
                confirmPasswordController,
                obscure2,
                    () {
                  setState(() => obscure2 = !obscure2);
                },
              ),
              const SizedBox(height: 15),

              buildField(
                Icons.phone,
                words["phone"]!,
                phoneController,
                type: TextInputType.phone,
              ),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFFB83B),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: isLoading ? null : register,
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    words["create"]!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    words["have_account"]!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      words["login"]!,
                      style: const TextStyle(color: Color(0xffFFB83B)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => changeLanguage("EN"),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentLang == "EN" ? const Color(0xffFFB83B) : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/EN.png", height: 30),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => changeLanguage("AR"),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentLang == "AR" ? const Color(0xffFFB83B) : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/EG.png", height: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
      textAlign: currentLang == "AR" ? TextAlign.right : TextAlign.left,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff282A28),
        prefixIcon: Icon(icon, color: Colors.white),
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
      String text,
      TextEditingController controller,
      bool obscure,
      VoidCallback press,
      ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      textAlign: currentLang == "AR" ? TextAlign.right : TextAlign.left,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff282A28),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
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