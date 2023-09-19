import 'package:flutter/material.dart';
import 'package:und1_mobile/styles.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filme"),
      ),
      body: Text(
        "Hello World! /n Whereas disregard and contempt for human rights have resulted",
        style: estiloTitulo2.copyWith(
          color: cores.onPrimary,
        ),
      ),
    );
  }
}
