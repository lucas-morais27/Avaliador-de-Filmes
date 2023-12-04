import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/botao_padrao.dart';
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

  var _estaEmespera = false;


  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    var producoes = context.watch<ProducaoModel>();

    if (producoes.naoAvaliados.isEmpty) {
      return Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(color: cores.secondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sua lista de filmes para avaliar está vazia!',
                style: estiloSubTitulo2.copyWith(color: cores.onSecondary),
                textAlign: TextAlign.center,
              ),
              if(!_estaEmespera)
                BotaoPadrao(
                    texto: 'Avaliar mais produções',
                    onPressed: () async {
                      setState(() {
                        _estaEmespera = true;
                      });
                      await producoes.adicionarMaisProducoes();
                      setState(() {
                        _estaEmespera = false;
                      });
                    }
                )
              else
                const CircularProgressIndicator()
            ],
          ));
    } else {
      return const CardProducao();
    }
  }
}
