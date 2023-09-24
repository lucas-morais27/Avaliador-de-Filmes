import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/swipe.dart';
import 'package:und1_mobile/components/botao_padrao.dart';
import 'package:und1_mobile/styles.dart';

import '../models/Producao.dart';
import '../models/filme.dart';
import '../models/serie.dart';
import '../utils/app_routes.dart';

class CardProducao extends StatelessWidget {
  final Function(int) gostei;
  final Function(int) naoGostei;
  final int index;
  Function() pular;
  dynamic producao;

  CardProducao(this.gostei, this.naoGostei, this.pular, {super.key, required this.producao, required this.index});

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    var textStyle = TextStyle(
      color: cores.onSecondary
    );

    return InkWell(
        onTap: (){
          if(producao is Filme){
            Navigator.of(context).pushNamed(
                AppRoutes.DETALHES_FILME
            );
          } else if(producao is Serie){
            Navigator.of(context).pushNamed(
                AppRoutes.DETALHES_SERIE
            );
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(producao.posterUrl).image,
              fit: BoxFit.fill
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: cores.primary.withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(producao.titulo, style: estiloSubTitulo4.copyWith(color: cores.onPrimary),),
                  Text(producao.anoLancamento, style: estiloCorpoTexto1.copyWith(color: cores.onPrimary),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BotaoPadrao.icone(
                        onPressed: (){
                          naoGostei(index);
                        },
                        icone: const Icon(Icons.thumb_down),
                      ),
                      const SizedBox(width: 32),
                      Expanded(child: BotaoPadrao(
                        onPressed: (){
                            pular();
                        },
                        texto: 'Pular',
                        //icone: const Icon(Icons.skip_next_rounded),
                      )),
                      const SizedBox(width: 32,),
                      BotaoPadrao.icone(
                        onPressed: (){
                          gostei(index);
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