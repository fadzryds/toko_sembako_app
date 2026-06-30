import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState()
      => _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 15),
      () {
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Image.asset(
              "assets/logo.png",
              width: 150,
            ),

            const SizedBox(height: 20),

            const Text(
              "TOKO DURIAN88",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}