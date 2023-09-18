import 'package:flutter/material.dart';

import 'screens/teste.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Da pra usar o colorScheme tbm (talvez seja até melhor), mas nunca mexi
        // Como Jean usou:
        // theme: ThemeData().copyWith(
        // colorScheme: ThemeData().colorScheme.copyWith(
        //       primary: Colors.purple,
        //       secondary: Colors.amber,
        //     ),
        // ),

        // Acho q é bom definir essas coisas em outro arquivo tbm
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: const TextTheme(),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(),
        ),
      ),
      home: const Teste(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: Teste(),
  //       ),
  //     ),
  //   );
  // }
}
