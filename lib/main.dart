import 'package:flutter/material.dart';
import 'views/splash_screen.dart';

void main(){

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {

  const NewsApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueAccent),
      ),
      home: const Splash(),
    );
  }
}

