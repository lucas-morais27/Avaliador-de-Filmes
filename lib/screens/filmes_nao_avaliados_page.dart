import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/card_producao.dart';
import 'package:und1_mobile/styles.dart';

import '../models/producao_model.dart';

class PaginaFilmesNaoAvaliadosPage extends StatefulWidget {
  const PaginaFilmesNaoAvaliadosPage({super.key});

  @override
  State<StatefulWidget> createState() => _PaginaFilmesNaoAvaliadosPageState();
}

class _PaginaFilmesNaoAvaliadosPageState
    extends State<PaginaFilmesNaoAvaliadosPage> {
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
      return const CardProducao();
    }
  }
}
