import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/card_producao.dart';
import 'package:und1_mobile/styles.dart';

import '../models/producao_model.dart';

class PaginaFilmesNaoAvaliados extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _PaginaFilmesNaoAvaliadosState();
}

class _PaginaFilmesNaoAvaliadosState extends State<PaginaFilmesNaoAvaliados> {

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    var producoes = context.watch<ProducaoModel>();

    if (producoes.naoAvaliados.isEmpty) {
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
      return CardProducao();
    }
  }
}
