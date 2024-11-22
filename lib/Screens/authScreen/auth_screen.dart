import 'package:flutter/material.dart';
import 'package:planetoid_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign-In with Firebase'),
      ),
      body: Center(
        child: authProvider.user == null
            ? ElevatedButton(
                onPressed: () async {
                  await authProvider.signInWithGoogle();
                },
                child: Text('Sign in with Google'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Signed in as ${authProvider.user!.displayName}'),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await authProvider.signOut();
                    },
                    child: Text('Sign out'),
                  ),
                ],
              ),
      ),
    );
  }
}
