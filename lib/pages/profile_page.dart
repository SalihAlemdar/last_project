import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:last_project/components/my_button.dart';
import 'package:last_project/pages/add_note_page.dart';
import 'package:last_project/pages/all_page.dart';
import 'package:last_project/pages/home_page.dart';

import '../components/app_colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

//sign User Out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 67, 59, 80),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 160,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text(
                "                   Merhaba                     " + user.email!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 67, 59, 80),
            ),
            child: InkWell(
              onTap: () {
                signUserOut();
              },
              child: const Center(
                child: Text(
                  'Çıkış Yap',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
