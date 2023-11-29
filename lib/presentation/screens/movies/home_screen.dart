import 'package:flutter/material.dart';
import 'package:moviepedia_app/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moviepedia'),
      ),
      body: Center(
        child: Text(Environment.dbkey),
      ),
    );
  }
}
