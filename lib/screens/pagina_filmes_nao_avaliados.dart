import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:und1_mobile/components/card_producao.dart';
import 'package:und1_mobile/styles.dart';

class PaginaFilmesNaoAvaliados extends StatefulWidget {
  final Function(int) gostei;
  final Function(int) naoGostei;
  final List<dynamic> producoes;

  const PaginaFilmesNaoAvaliados(this.gostei, this.naoGostei,
      {super.key, required this.producoes});

  @override
  State<StatefulWidget> createState() => _PaginaFilmesNaoAvaliadosState();
}

class _PaginaFilmesNaoAvaliadosState extends State<PaginaFilmesNaoAvaliados> {
  int _cardAtual = 0;

  _naoGostei(int idx) {
    setState(() {
      widget.naoGostei(idx);
      if (idx >= widget.producoes.length) {
        _cardAtual = 0;
      }
    });
  }

  _gostei(int idx) {
    setState(() {
      widget.gostei(idx);
      if (idx >= widget.producoes.length) {
        _cardAtual = 0;
      }
    });
  }

  _pular() {
    setState(() {
      if (_cardAtual + 1 == widget.producoes.length) {
        _cardAtual = 0;
      } else {
        _cardAtual++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    if (widget.producoes.isEmpty) {
      return Container(
          height: double.infinity,
          decoration: BoxDecoration(color: cores.secondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Todos os filmes/séries foram avaliados',
                style: estiloSubTitulo2.copyWith(color: cores.onSecondary),
                textAlign: TextAlign.center,
              )
            ],
          ));
    } else {
      return CardProducao(
        _gostei,
        _naoGostei,
        _pular,
        producao: widget.producoes[_cardAtual],
        index: _cardAtual,
      );
    }
  }
}
