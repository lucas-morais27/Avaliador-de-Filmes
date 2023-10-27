import 'package:flutter/cupertino.dart';

import '../mocks/mock_filme.dart';
import '../mocks/mock_serie.dart';

class ProducaoModel extends ChangeNotifier {
  final List<dynamic> _naoAvaliados = [];
  final List<dynamic> _curtidos = [];
  final List<dynamic> _naoCurtidos = [];

  int _cardAtual = 0;

  ProducaoModel(){
    _naoAvaliados.addAll(FILMES);
    _naoAvaliados.addAll(SERIES);
    _naoAvaliados.shuffle();
  }

  List<dynamic> get curtidos => _curtidos;
  List<dynamic> get naoCurtidos => _naoCurtidos;
  List<dynamic> get naoAvaliados => _naoAvaliados;
  int get cardAtual => _cardAtual;
  dynamic get producaoAtual => naoAvaliados[cardAtual];

  proximoCard() {
    if(_cardAtual+1 == _naoAvaliados.length){
      _cardAtual = 0;
    } else {
      _cardAtual++;
    }
    notifyListeners();
  }

  naoGostei() {
      var index = _cardAtual;
      naoCurtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
      if(_cardAtual >= _naoAvaliados.length){
        _cardAtual = 0;
      }
      notifyListeners();
  }

  gostei() {
      var index = _cardAtual;
      curtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
      if(_cardAtual >= _naoAvaliados.length){
        _cardAtual = 0;
      }
      notifyListeners();
  }

  removerCurtido(int index) {
    naoAvaliados.add(curtidos[index]);
    curtidos.removeAt(index);
    notifyListeners();
  }

  removerNaoCurtido(int index) {
      naoAvaliados.add(naoCurtidos[index]);
      naoCurtidos.removeAt(index);
      notifyListeners();
  }
}