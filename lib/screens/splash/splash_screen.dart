import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushNamed(context, '/'));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Image(
              image: AssetImage('assets/images/contoso-comm.png'),
              width: 300,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
