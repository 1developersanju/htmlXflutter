import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planetoid_app/Screens/authScreen/auth_screen.dart';
import 'package:planetoid_app/Screens/default_pages/splash_screen.dart';
import 'package:planetoid_app/Screens/home/home_screen.dart';

const String splashScreen = 'splashScreen';
const String homeScreen = 'homeScreen';
const String authScreen = 'authScreen';

String currentRoute = splashScreen;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "";

    switch (settings.name) {
      case splashScreen:
        return CupertinoPageRoute(
          builder: (_) => SplashScreen(),
        );

      case homeScreen:
        return CupertinoPageRoute(
          builder: (_) =>  HomeScreen(),
        );

      case authScreen:
        return CupertinoPageRoute(
          builder: (_) => AuthScreen(),
        );

      

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class ScreenArguments {
  final String title;
  final List services;

  ScreenArguments(this.title, this.services);
}
