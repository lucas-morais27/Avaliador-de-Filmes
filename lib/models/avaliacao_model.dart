import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/models/producao_model.dart';

class Avaliacao {
  String? id;
  final String producaoid;
  final String userid;
  final String nota;
  final String? comentario;

  final _db = FirebaseFirestore.instance;
  static final _baseCollection = 'reviews';

  Avaliacao({
    required this.producaoid,
    required this.userid,
    required this.nota,
    required this.comentario,
  });

  Avaliacao.id(
  {
    required this.id,
    required this.producaoid,
    required this.userid,
    required this.nota,
    required this.comentario,
  }
  );

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


  Future<bool> adicionar() async {
    if(id != null){
      try {
      await _db.collection(_baseCollection).doc(id).set({
        'id': this.id,
        'producaoid': this.producaoid,
        'userid': this.userid,
        'nota': this.nota,
        'comentario': this.comentario
      });
      return true;
    } catch (e) {
      return false;
    }
    }
    return false;
  }

  Future<bool> atualizar() async {
    if(id!=null){
      try {
      await _db.collection(_baseCollection).doc(id).update({
        'id': this.id,
        'producaoid': this.producaoid,
        'userid': this.userid,
        'nota': this.nota,
        'comentario': this.comentario
      });
      return true;
    } catch (e) {
      return false;
    }
    }
    return false;
  }

  static Future<bool> remover(String id) async {
    final db = FirebaseFirestore.instance;
    try {
      await db.collection(_baseCollection).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
  

  static Future<List<Avaliacao>> carregarAvaliacoes() async {
    final db = FirebaseFirestore.instance;
    var avaliacoesData = await db.collection(Avaliacao._baseCollection).get();
    var avaliacoes = avaliacoesData.docs.map((doc) =>  doc.data()).toList();
    return avaliacoes.map((e) => Avaliacao.id(
      id: e['id'],
      producaoid: e['producaoid'], 
      userid: e['userid'], 
      nota: e['nota'], 
      comentario: e['comentario'])).toList();
  }
}
