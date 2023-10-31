// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:und1_mobile/components/item_producao.dart';
import 'package:und1_mobile/styles.dart';

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
    widget.remover(idx);
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _listaDeProducoes(widget.listaProducoes, cores),
      ),
    );
  }

  List<Widget> _listaDeProducoes(List<dynamic> producoes, ColorScheme cores) {
    List<Widget> lista = [];
    if (producoes.isEmpty) {
      lista.add(
        Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/movie-symbol.png',
                height: 50,
                color: cores.onSecondary,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Nenhuma produção cadastrada!",
                style: estiloCorpoTexto1.copyWith(color: cores.onSecondary),
              )
            ],
          ),
        ),
      );
    } else {
      for (int i = 0; i < producoes.length; i++) {
        lista.add(ItemProducao(_remover, producao: producoes[i], index: i));
      }
    }
    return lista;
  }
}
