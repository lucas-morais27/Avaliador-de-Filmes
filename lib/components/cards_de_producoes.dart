import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:und1_mobile/components/card_producao.dart';
import 'package:und1_mobile/styles.dart';

import '../mocks/mock_filme.dart';

class CardsDeProducoes extends StatefulWidget {
  final Function(int) gostei;
  final Function(int) naoGostei;
  final List<dynamic> producoes;

  const CardsDeProducoes(this.gostei, this.naoGostei, {super.key, required this.producoes});

  @override
  State<StatefulWidget> createState() => _CardsDeProducoesState();
}

class _CardsDeProducoesState extends State<CardsDeProducoes> {

  late List<Widget> _cards;
  int _cardAtual = 0;
  final SwipeableCardSectionController _cardController = SwipeableCardSectionController();

  _naoGostei(int idx){
    setState(() {
      widget.naoGostei(idx);
      //_cardAtual++;
    });
  }

  _gostei(int idx){
    setState(() {
      widget.gostei(idx);
      //_cardAtual++;
    });
  }

  _pular(){
    setState(() {
      if(_cardAtual+1 == widget.producoes.length){
        _cardAtual = 0;
      } else {
        _cardAtual++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    if(widget.producoes.isEmpty){
      return Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: cores.secondary
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Todos os filmes/séries foram avaliados',
                style: estiloSubTitulo2.copyWith(color: cores.onSecondary),
                textAlign: TextAlign.center,
              )
            ],
          )
      );
    } else {
      return CardProducao(_gostei, _naoGostei, _pular, producao: widget.producoes[_cardAtual], index: _cardAtual,);
    }
  }

}
