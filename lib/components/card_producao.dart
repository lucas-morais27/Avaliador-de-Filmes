import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/botao_padrao.dart';
import 'package:und1_mobile/styles.dart';

import '../models/filme.dart';
import '../models/producao_model.dart';
import '../models/serie.dart';
import '../utils/app_routes.dart';

class CardProducao extends StatelessWidget {
  const CardProducao({super.key});

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    var producoes = context.watch<ProducaoModel>();
    var producao = producoes.producaoAtual;

    return InkWell(
        onTap: () {
          if (producao is Filme) {
            Navigator.of(context)
                .pushNamed(AppRoutes.DETALHES_FILME, arguments: producao);
          } else if (producao is Serie) {
            Navigator.of(context)
                .pushNamed(AppRoutes.DETALHES_SERIE, arguments: producao);
          }
        },
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.network(producao.posterUrl).image,
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: cores.primary.withOpacity(0.9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        producao.titulo,
                        style:
                            estiloSubTitulo4.copyWith(color: cores.onPrimary),
                      ),
                      Text(
                        producao.anoLancamento,
                        style: estiloCorpoTexto1.copyWith(
                            color: cores.onPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BotaoPadrao.icone(
                            onPressed: () {
                              producoes.naoGostei();
                            },
                            icone: const Icon(Icons.thumb_down),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                              child: BotaoPadrao(
                            onPressed: () {
                              producoes.proximoCard();
                              producao = producoes.producaoAtual;
                            },
                            texto: 'Pular',
                            //icone: const Icon(Icons.skip_next_rounded),
                          )),
                          const SizedBox(
                            width: 32,
                          ),
                          BotaoPadrao.icone(
                            onPressed: () {
                              producoes.gostei();
                            },
                            icone: const Icon(Icons.thumb_up),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
