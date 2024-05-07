import 'package:flutter/material.dart';
import 'package:tugas3/categories_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 3 - 123210011',
      home: PageListCategories(),
    );
  }
}

