// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();  // Sign out from Google as well
  }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
bool Showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
        await signOut();
        Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Showspinner == true ? const Center(child: CircularProgressIndicator(),) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         Center(
          child: MaterialButton(onPressed: (){
            Navigator.of(context).pushNamed('profilescreen');
          },
          child:const Text('profile page',style: TextStyle(color: Colors.black),) ,
          ),
        ),
          ]
        ),
      ),
    );
  }
}
