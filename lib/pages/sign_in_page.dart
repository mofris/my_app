import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/models/user_models.dart';
import 'package:my_app/providers/auth_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[500],
          content: Text(message),
        ),
      );
    }

    Widget illustration() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: Center(
          child: Image.asset(
            'assets/logo/logo.png',
            width: 280,
          ),
        ),
      );
    }

    Widget inputUsername() {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                color: Colors.orange[300],
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
                color: Colors.orange[300],
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TextButton(
                onPressed: () async {
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showError('Semua field harus diisi!');
                  } else {
                    setState(() {
                      isLoading = true;
                    });

                    UserModel? user = await authProvider.login(
                      usernameController.text,
                      passwordController.text,
                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (user == null) {
                      showError('Username atau password salah!');
                    } else {
                      userProvider.user = user;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrange[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              illustration(),
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
