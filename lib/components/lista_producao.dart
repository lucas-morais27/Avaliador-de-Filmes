// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:und1_mobile/components/item_producao.dart';

class ListaProducao extends StatefulWidget {
  final Function(int) remover;
  List<dynamic> listaProducoes;

  ListaProducao(
    this.remover, {
    super.key,
    required this.listaProducoes,
  });

  @override
  State<ListaProducao> createState() => _ListaProducaoState();
}

class _ListaProducaoState extends State<ListaProducao> {
  _remover(int idx) {
    setState(() {
      widget.remover(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _listaDeProducoes(widget.listaProducoes),
    ));
  }

  List<Widget> _listaDeProducoes(List<dynamic> producoes) {
    List<Widget> lista = [];
    if (producoes.isEmpty) {
      lista.add(Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Image.asset(
              'assets/movie-symbol.png',
              height: 50,
            ),
            const Text("Nenhum produção cadastrada!")
          ],
        ),
      ));
    } else {
      for (int i = 0; i < producoes.length; i++) {
        lista.add(ItemProducao(_remover, producao: producoes[i], index: i));
      }
    }
    return lista;
  }
}
