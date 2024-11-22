// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planetoid_app/providers/auth_provider.dart';
import 'package:planetoid_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late WebViewController _controller;
  final ImagePicker _picker = ImagePicker();
  File? image;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) {
      print("Firebase Messaging Token: $token");
      // Save the token to your server or use it as needed
    });

    // Set up message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
      // Handle the message
    });
  
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            print("Page started loading: $url");
          },
          onPageFinished: (String url) {
            print("Page finished loading: $url");
          },
          onHttpError: (HttpResponseError error) {
            print("HTTP error: ${error} ${error.response}");
          },
          onWebResourceError: (WebResourceError error) {
            print("Web resource error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.nodeact.tech/test')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (message) async {
          if (message.message == 'request/googleAuthLogin') {
            print(message.message);
            try {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);

              final userCredential = await authProvider.signInWithGoogle();
              final user = userCredential.user;
              if (user != null) {
                final userInfo = jsonEncode({
                  'name': user.displayName,
                  'email': user.email,
                  'photoUrl': user.photoURL,
                });
                await _controller.runJavaScript('displayUserInfo(${jsonEncode(userInfo)})');
              }
            } catch (e) {
              print('Failed $e');
            }
          } else if (message.message == 'request/googleAuthLogout') {
            print(message.message);
            try {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);

              await authProvider.signOut();

              final logoutStatus = jsonEncode({
                "Status": "Logged Out",
              });
              await _controller.runJavaScript('displayUserInfo(${jsonEncode(logoutStatus)})');
            } catch (e) {
              print('Failed $e');
            }
          } else {
            // Handle other messages from JavaScript
          }
        },
      );

    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    final String filePath = 'assets/index.html'; // Ensure this path is correct
    final String fileContent = await rootBundle.loadString(filePath);
    _controller.loadRequest(Uri.dataFromString(
      fileContent,
      mimeType: 'text/html',
    ));
  }

  Future<bool> _onWillPop() async {
    final result = await _controller.runJavaScriptReturningResult('showExitConfirmation()');
    return result == 'true'; // If the user confirms exit, return true to allow back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        
        bottom: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(backgroundColor: ColorsRes.canvasColor,),
          backgroundColor: ColorsRes.blue,
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
