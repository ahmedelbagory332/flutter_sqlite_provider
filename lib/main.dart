import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_provider/provider/my_provider.dart';
import 'package:sqlite_provider/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const Home(),
      ),
    );
  }
}

