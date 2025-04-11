import 'package:cart_app/features/authentication/splash/splash_screen.dart';
import 'package:cart_app/features/cart/presentation/cart_screen.dart';
import 'package:cart_app/features/authentication/presentation/login_screen.dart';
import 'package:cart_app/features/authentication/presentation/signup_screen.dart';
import 'package:cart_app/features/cart/presentation/home_screen.dart';
import 'package:cart_app/features/cart/presentation/product_detail.dart';
import 'package:flutter/material.dart';
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
    GoRoute(
      path: '/product-detail/:id',
      name: 'productDetail',
      builder: (context, state) {
        final productId = state.pathParameters['id'];

        if (productId == null) {
          return const Scaffold(
            body: Center(child: Text('Product ID not found in path')),
          );
        }

        return ProductDetailScreen(productId: productId);
      },
    ),
  ],
);
