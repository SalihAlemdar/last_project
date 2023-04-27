import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:last_project/components/my_button.dart';
import 'package:last_project/components/my_textfield.dart';
import 'package:last_project/components/square_title.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//Text editin controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

//sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try creating the user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        //show error message password don't match
        wrongConfirmPasswordMessage();
      }
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //Wrong Email
      if (e.code == 'user-not-found') {
        //show to error to user
        wrongEmailMessage();
      }

      //Wrong Password
      else if (e.code == 'wrong-password') {
        //show to error to user
        wrongPasswordMessage();
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Hatalı e-posta girişi !',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  //wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Hatalı şifre girişi !',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void wrongConfirmPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Şifreler eşleşmiyor!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Lottie
                Lottie.asset('assets/lock.json', height: 150),

                //hoşgeldin!
                const Text(
                  'Sizin için bir hesap oluşturalım!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Şifre',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                //Comfirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Şifreyi tekrar giriniz',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                //forgot password ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Şifreni mi unuttun ?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                //sign in button
                MyButton(
                  text: 'Kayıt Ol',
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 50,
                ),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 52.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          'Diğer Seçenekler',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                //google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //google button
                    SquareTitle(
                      imagePath: 'lib/images/google.png',
                    ),

                    SizedBox(width: 30),

                    //appele button
                    SquareTitle(
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Zaten hesabınız var mı ?',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
