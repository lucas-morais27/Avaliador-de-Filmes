import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/models/producao_model.dart';

class Avaliacao {
  final String producaoid;
  final String userid;
  final String nota;
  final String? comentario;

  Avaliacao({
    required this.producaoid,
    required this.userid,
    required this.nota,
    required this.comentario,
  });

  static Avaliacao fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      producaoid: map['producaoid'],
      userid: map['userid'],
      nota: map['nota'],
      comentario: map['comentario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'producaoid': producaoid,
      'userid': userid,
      'nota': nota,
      'comentario': comentario,
    };
  }

  factory Avaliacao.fromFirestore(DocumentSnapshot doc) {
    return Avaliacao(
      producaoid: doc['producaoid'],
      userid: doc['userid'],
      nota: doc['nota'],
      comentario: doc['comentario'],
    );
  }

  void addAvaliacao(ProducaoModel model, String nota, String comentario,
      String userid, dynamic producao) async {
    final CollectionReference avaliacoes =
        FirebaseFirestore.instance.collection('reviews');

    final String producaoid = avaliacoes.doc().id;

    final Avaliacao avaliacao = Avaliacao(
      producaoid: producaoid,
      userid: userid,
      nota: nota,
      comentario: comentario,
    );

    await avaliacoes.doc(producaoid).set(avaliacao.toMap());

    model.avaliacoes.add(avaliacao);
    model.notifyListeners();
  }

  void atualizarAvaliacao(
      ProducaoModel model, int index, String nota, String comentario) async {
    final CollectionReference avaliacoes =
        FirebaseFirestore.instance.collection('reviews');

    final Avaliacao avaliacao = model.avaliacoes[index];

    await avaliacoes.doc(avaliacao.producaoid).update(avaliacao.toMap());

    model.avaliacoes[index] = avaliacao;
    model.notifyListeners();
  }

  void deletarAvaliacao(ProducaoModel model, int index) async {
    final CollectionReference avaliacoes =
        FirebaseFirestore.instance.collection('reviews');

    final Avaliacao avaliacao = model.avaliacoes[index];

    await avaliacoes.doc(avaliacao.producaoid).delete();

    model.avaliacoes.removeAt(index);
    model.notifyListeners();
  }

}
