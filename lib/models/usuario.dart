import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/mocks/mock_filme.dart';

import '../mocks/mock_serie.dart';

class Usuario {
  final String email;
  final String senha;

  String? _uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Usuario({
    required this.email,
    required this.senha,
  });

  String? get uid => _uid;
  set uid(String? uid) => _uid = uid;

  Future<String> salvarUsuario() {
    if (_uid == null) {
      return _cadastrarUsuario();
    } else {
      //TODO _atualizarUsuario();
      return 'Não foi possível atualizar o usuário' as Future<String>;
    }
  }

  Future<String> _cadastrarUsuario() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((result) {
        List<dynamic> producoesIniciais = [];
        producoesIniciais.addAll(FILMES);
        producoesIniciais.addAll(SERIES);
        producoesIniciais.shuffle();
        _uid = result.user?.uid;
        _db.collection('users').doc(_uid).set({
          "email": email,
          "naoAvaliados": producoesIniciais.map((p) => p.id),
          "naoCurtidos": [],
          "curtidos": []
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        return 'Esse email já foi cadastrado.';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Não foi possível cadastrar usuário.';
    }

    return '';
  }

  static Future<bool> login(String usuario, String senha) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usuario,
      password: senha,
    );

    // Se o login for bem-sucedido, o usuário é retornado
    User? user = userCredential.user;

    if (user != null) {
      // Login com sucesso
      return true;
    } else {
      // Falha no login
      return false;
    }
  }
}
