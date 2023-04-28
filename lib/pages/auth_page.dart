import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:last_project/pages/login_page.dart';
import 'package:last_project/providers/note_provider.dart';
import 'package:last_project/services/services.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            User? user = snapshot.data;
            ApiConfig.userId = user!.uid;
            context.read<NoteProvider>().getList();
            return HomePage();
          }
          //user is not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
