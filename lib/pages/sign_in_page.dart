import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Widget inputUsername() {
    return Container(
      margin: const EdgeInsets.only(top: 80, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Username'),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
            ),
            child: Center(
              child: TextFormField(
                controller: usernameController,
                cursorColor: Colors.black,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter your Username',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password'),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
            ),
            child: Center(
              child: TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                obscureText: true,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter your Password',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInButton() {
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 25, right: 10, left: 10),
      child: TextButton(
        onPressed: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Sign In',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              inputUsername(),
              inputPassword(),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
