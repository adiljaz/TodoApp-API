import 'package:flutter/material.dart';
import 'package:todoapp/screens/home.dart';

void main(){
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo-App',
      theme: ThemeData.dark(),
      home: const Home() ,
    );
  }
}
