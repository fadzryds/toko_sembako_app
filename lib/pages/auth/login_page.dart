import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'register_page.dart';
import '../customer/home_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  Future<void> login() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Email dan Password wajib diisi"),
        ),
      );
      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      await AuthService().signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const HomeNavigation(),
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

          padding: const EdgeInsets.all(25),

          child: Column(

            children: [

              const SizedBox(height: 20),

              const Text(
                "Hello Again!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Welcome Back You've Been Missed!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              TextField(

                controller: emailController,

                keyboardType:
                TextInputType.emailAddress,

                decoration: InputDecoration(

                  hintText: "Email Address",

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(

                controller: passwordController,

                obscureText: obscurePassword,

                decoration: InputDecoration(

                  hintText: "Password",

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8),
                  ),

                  suffixIcon: IconButton(

                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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

              const SizedBox(height: 10),

              Align(

                alignment: Alignment.centerRight,

                child: TextButton(

                  onPressed: () {},

                  child: const Text(
                    "Recovery Password",
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(

                width: double.infinity,
                height: 50,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    const Color(0xff5EDAE5),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : login,

                  child: isLoading

                      ? const SizedBox(

                    width: 25,
                    height: 25,

                    child:
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )

                      : const Text(

                    "Sign In",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Or Continue With",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              Row(

                children: [

                  Expanded(

                    child:
                    OutlinedButton.icon(

                      onPressed: () {},

                      icon: const Icon(
                        Icons.apple,
                        color: Colors.black,
                      ),

                      label: const Text(
                        "Apple",
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(

                    child:
                    OutlinedButton.icon(

                      onPressed: () {},

                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 30,
                      ),

                      label: const Text(
                        "Google",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  const Text(
                    "Not a Member?",
                  ),

                  TextButton(

                    onPressed: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const RegisterPage(),
                        ),
                      );

                    },

                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
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