import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/models/usuario.dart';

class ProducaoModel extends ChangeNotifier {
  List<dynamic> _naoAvaliados = [];
  List<dynamic> _curtidos = [];
  List<dynamic> _naoCurtidos = [];

  static final _db = FirebaseFirestore.instance;

  int _cardAtual = 0;

  List<dynamic> get curtidos => _curtidos;
  List<dynamic> get naoCurtidos => _naoCurtidos;
  List<dynamic> get naoAvaliados => _naoAvaliados;
  int get cardAtual => _cardAtual;
  dynamic get producaoAtual => naoAvaliados[cardAtual];

  set naoAvaliados(List<dynamic> naoAvaliados) => _naoAvaliados = naoAvaliados;
  set curtidos(List<dynamic> curtidos) => _curtidos = curtidos;
  set naoCurtidos(List<dynamic> naoCurtidos) => _naoCurtidos = naoCurtidos;

  carregarListas() async {
    Map<String, List<dynamic>> listas =
    await Usuario.carregarListas();

    listas['naoAvaliados'] != null
        ? _naoAvaliados = listas['naoAvaliados']!
        : _naoAvaliados = [];

    listas['naoCurtidos'] != null
        ? _naoCurtidos = listas['naoCurtidos']!
        : _naoCurtidos = [];

    listas['curtidos'] != null
        ? _curtidos = listas['curtidos']!
        : _curtidos = [];
  }

  proximoCard() {
    if (_cardAtual + 1 == _naoAvaliados.length) {
      _cardAtual = 0;
    } else {
      _cardAtual++;
    }
    notifyListeners();
  }

  naoGostei() async {
    var index = _cardAtual;
    final userData = await _db.collection("users").doc(Usuario.uid);

    naoCurtidos.add(naoAvaliados[index]);
    naoAvaliados.removeAt(index);
    if (_cardAtual >= _naoAvaliados.length) {
      _cardAtual = 0;
    }
    _atualizarListas();
    notifyListeners();
  }

  gostei() {
    var index = _cardAtual;
    curtidos.add(naoAvaliados[index]);
    naoAvaliados.removeAt(index);
    if (_cardAtual >= _naoAvaliados.length) {
      _cardAtual = 0;
    }
    _atualizarListas();
    notifyListeners();
  }

  removerCurtido(int index) {
    naoAvaliados.add(curtidos[index]);
    curtidos.removeAt(index);
    _atualizarListas();
    notifyListeners();
  }

  removerNaoCurtido(int index) {
    naoAvaliados.add(naoCurtidos[index]);
    naoCurtidos.removeAt(index);
    _atualizarListas();
    notifyListeners();
  }

  _atualizarListas() {
    Usuario.atualizarListas(
      {
        'naoAvaliados': _naoAvaliados,
        'naoCurtidos': _naoCurtidos,
        'curtidos': _curtidos
      },
    );
  }
}
