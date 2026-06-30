import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final fullNameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  Future<void> register() async {

    String nama =
        fullNameController.text.trim();

    String email =
        emailController.text.trim();

    String password =
        passwordController.text.trim();

    if (nama.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Semua field harus diisi"),
        ),
      );
      return;
    }

    if (!email.contains("@")) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Format email tidak valid"),
        ),
      );
      return;
    }

    if (password.length < 6) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
              "Password minimal 6 karakter"),
        ),
      );
      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      String? error =
      await AuthService().register(
        nama: nama,
        email: email,
        password: password,
      );

      if(error != null){

        throw Exception(error);
      }

      if(!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Registrasi berhasil, silakan login",
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const LoginPage(),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(25),

          child: Column(

            children: [

              const SizedBox(height: 10),

              Align(
                alignment:
                Alignment.centerLeft,

                child: IconButton(

                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Lets Create your Account",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              TextField(

                controller:
                fullNameController,

                decoration: InputDecoration(

                  hintText:
                  "Full Name",

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                        8),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(

                controller:
                emailController,

                keyboardType:
                TextInputType.emailAddress,

                decoration: InputDecoration(

                  hintText:
                  "Email Address",

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                        8),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(

                controller:
                passwordController,

                obscureText:
                obscurePassword,

                decoration: InputDecoration(

                  hintText:
                  "Password",

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                        8),
                  ),

                  suffixIcon:
                  IconButton(

                    icon: Icon(

                      obscurePassword
                          ? Icons.visibility
                          : Icons
                          .visibility_off,
                    ),

                    onPressed: () {

                      setState(() {
                        obscurePassword =
                        !obscurePassword;
                      });

                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(

                width: double.infinity,
                height: 50,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    const Color(
                        0xff5EDAE5),

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          8),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : register,

                  child: isLoading

                      ? const SizedBox(

                    height: 25,
                    width: 25,

                    child:
                    CircularProgressIndicator(
                      color:
                      Colors.white,
                      strokeWidth:
                      3,
                    ),
                  )

                      : const Text(

                    "Sign Up",

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Recovery Password",
                ),
              ),

              const SizedBox(height: 15),

              OutlinedButton.icon(

                onPressed: () {},

                icon: const Icon(
                  Icons.apple,
                  color: Colors.black,
                ),

                label: const Text(
                  "Sign in with Apple",
                ),

                style:
                OutlinedButton.styleFrom(

                  minimumSize:
                  const Size(
                      double.infinity,
                      45),
                ),
              ),

              const SizedBox(height: 10),

              OutlinedButton.icon(

                onPressed: () {},

                icon: const Icon(
                  Icons.g_mobiledata,
                  size: 30,
                ),

                label: const Text(
                  "Sign in with Google",
                ),

                style:
                OutlinedButton.styleFrom(

                  minimumSize:
                  const Size(
                      double.infinity,
                      45),
                ),
              ),

              const SizedBox(height: 25),

              Row(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  const Text(
                    "Already have an account?",
                  ),

                  TextButton(

                    onPressed: () {

                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const LoginPage(),
                        ),
                      );
                    },

                    child: const Text(
                      "Login",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}