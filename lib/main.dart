import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'package:my_app/providers/auth_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/providers/contact_provider.dart';

// Pages
import 'package:my_app/pages/sign_in_page.dart';
import 'package:my_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SignInPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
