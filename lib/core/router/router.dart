import 'package:cart_app/features/authentication/splash/splash_screen.dart';
import 'package:cart_app/features/cart/presentation/cart_screen.dart';
import 'package:cart_app/features/authentication/presentation/login_screen.dart';
import 'package:cart_app/features/authentication/presentation/signup_screen.dart';
import 'package:cart_app/features/cart/presentation/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => CartScreen(),
    ),
  ],
);
