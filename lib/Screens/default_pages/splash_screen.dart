import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planetoid_app/Screens/authScreen/auth_screen.dart';
import 'package:planetoid_app/Screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
    

  }

  Future<void> _loadData() async {
    // Fetch user data in the background


    // Check if user data exists in Firestore

    // Navigate to the appropriate screen after a short delay
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  FirebaseAuth.instance.currentUser != null
              ? HomeScreen() // Navigate to main app screen if user exists
              : HomeScreen(),    // Navigate to login screen if user does not exist
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      
      logo: Image.network('https://img.freepik.com/free-psd/moon-phases-isolated_23-2151604128.jpg?size=626&ext=jpg&uid=R130153938&ga=GA1.2.1171535645.1719421773&semt=ais_user'),

      title: const Text(
        "planetoid_app",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      showLoader: false,
      durationInSeconds: 5,
    );
  }
}
