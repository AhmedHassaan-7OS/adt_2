import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adt2/tools/textformfield.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';

class Signup extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Verification Email Sent'),
                  content: Text('Please check your email to verify your account.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
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
                            'Images/Ellipse 37.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(height: 20),
                      Text('Signup', style: TextStyle(fontSize: 35)),
                      Container(height: 20),
                      Text('Username', style: TextStyle(fontSize: 25)),
                      Container(height: 10),
                      CustomTextForm(hinttext: "Enter Your Username", mycontroller: username),
                      Container(height: 10),
                      Text('Email', style: TextStyle(fontSize: 25)),
                      Container(height: 10),
                      CustomTextForm1(hinttext: "Enter Your Email", mycontroller: email),
                      Container(height: 10),
                      Text('Password', style: TextStyle(fontSize: 25)),
                      Container(height: 10),
                      CustomTextForm2(hinttext: "Enter Password", mycontroller: password),
                      Container(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if (email.text.isEmpty || password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email and password must not be empty.')),
                            );
                            return;
                          }
                          context.read<AuthCubit>().signUpWithEmailAndPassword(email.text, password.text);
                        },
                        color: Colors.blueGrey,
                        minWidth: 500,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        child: Text('Signup', style: TextStyle(color: Colors.white)),
                      ),
                      Container(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("login");
                        },
                        child: const Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Have An Account? "),
                            TextSpan(
                              text: "Login",
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