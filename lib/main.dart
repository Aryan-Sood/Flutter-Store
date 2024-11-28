import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/src/providers/ProductProvider.dart';
import 'package:store/src/views/Home.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ProductProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
