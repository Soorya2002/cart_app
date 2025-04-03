import 'package:cart_app/core/utils/storage_services.dart';
import 'package:cart_app/features/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  Future<void> _startSplashScreen() async {
    // Minimum duration for splash screen display
    await Future.delayed(const Duration(seconds: 3));

    // Check user authentication state
    UserModel? user = await StorageServices().getUserData();

    if (mounted) {
      if (user != null && user.token != null) {
        context.goNamed('home');
      } else {
        context.goNamed('login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          width: 200, // Adjust size
          height: 200, // Adjust size
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
