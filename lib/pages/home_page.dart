import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_project/pages/all_view.dart';

import '../components/app_colors.dart';
import 'folder_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

//sign User Out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Hoşgeldin " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              actions: [
                TextButton(
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.lightTextColor, fontSize: 18),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.search,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.ellipsis_circle,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: signUserOut,
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ),
              ],
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              title: const Text(
                'Notes',
                style: TextStyle(fontSize: 20),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Folder',
                  ),
                ],
              )),
          body: const TabBarView(
            children: [AllView(), FolderView()],
          ),
        ));
  }
}
