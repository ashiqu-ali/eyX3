import 'package:eyx3/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

main() async{
  await Hive.initFlutter();
  await Hive.openBox('reward');
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
