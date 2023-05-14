import 'dart:js';

import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/services/auth_service.dart';
import 'package:carona_solidaria/splash/splash_screen.dart';
import 'package:carona_solidaria/utils/connection_checker/connection_checker.dart';
import 'package:carona_solidaria/utils/no_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

void main() async {
  final hasConnection = await InternetConnectionChecker().hasConnection;
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AuthServices()),
        ),
        ChangeNotifierProvider(
          create: (context) => ValueNotifier(hasConnection),
        ),
      ],
      child: const MyApp(),
    ),
    // ConnectionNotifier(
    //   notifier: ValueNotifier(hasConnection),
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carona Solidária',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/noConnection': (context) => const NoConnection(),
      },
    );
  }
}
