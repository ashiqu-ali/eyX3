import 'package:eyx3/pages/home_page.dart';
import 'package:flutter/material.dart';

main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eyX3',
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true
      ),
    );
  }
}
