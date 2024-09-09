import 'package:flutter/material.dart';
import 'package:todo_app/feautres/home/presentation/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: HomeView(),
    debugShowCheckedModeBanner: false,
    );
  }
}

