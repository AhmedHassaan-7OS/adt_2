import 'package:adt2/auth/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adt2/tools/textformfield.dart';

import 'cubit/auth_state.dart';

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 1, 15, 56),
                    Colors.blueAccent,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 50),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: Image.asset(
                            'Images/Untitled.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(height: 20),
                      Text('Login', style: TextStyle(fontSize: 35)),
                      Container(height: 20),
                      Text('Email', style: TextStyle(fontSize: 25)),
                      Container(height: 10),
                      CustomTextForm1(hinttext: "Enter Your Email", mycontroller: email),
                      Container(height: 20),
                      Text('Password', style: TextStyle(fontSize: 25)),
                      Container(height: 10),
                      CustomTextForm2(hinttext: "Enter Password", mycontroller: password),
                      Container(height: 7.5),
                      Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () async {
                            if (email.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('You must enter an email')),
                              );
                              return;
                            }
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password reset email has been sent')),
                            );
                          },
                          child: Text('Forget Password?', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if (email.text.isEmpty || password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email and password must not be empty.')),
                            );
                            return;
                          }
                          context.read<AuthCubit>().loginWithEmailAndPassword(email.text, password.text);
                        },
                        color: Colors.blueGrey,
                        minWidth: 500,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Text('Login', style: TextStyle(color: Colors.white)),
                      ),
                      Container(height: 7.5),
                      Container(
                        alignment: Alignment.center,
                        child: Text('Or Login With', style: TextStyle(fontSize: 17, color: Colors.white)),
                      ),
                      Container(height: 15),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(width: 0),
                            MaterialButton(
                              onPressed: () {
                                context.read<AuthCubit>().signInWithGoogle();
                              },
                              child: Image.asset('Images/Google.png'),
                            ),
                            Container(width: 25),
                          ],
                        ),
                      ),
                      Container(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                        child: const Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don't Have An Account? "),
                            TextSpan(
                              text: "Register",
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                          ])),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}