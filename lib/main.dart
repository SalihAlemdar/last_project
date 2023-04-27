import 'package:flutter/material.dart';
import 'package:last_project/pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:last_project/pages/auth_page.dart';
import 'components/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: AppColors.lightTextColor),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.buttonColor),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: AppColors.lightTextColor)),
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: AppColors.orange)),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColors.orange),
          backgroundColor: AppColors.containerBackground,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  primary: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))))),
    );
  }
}
