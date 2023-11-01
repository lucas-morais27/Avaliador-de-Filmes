import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:und1_mobile/models/avaliacao_model.dart';

class ListaAvaliacoes extends ChangeNotifier {
  List<Avaliacao> avaliacoes = [];

  ListaAvaliacoes() {
    FirebaseFirestore.instance.collection('reviews').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        avaliacoes.add(Avaliacao.fromFirestore(doc));
      }
      notifyListeners();
    });
  }
}
