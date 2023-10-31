import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/mocks/mock_filme.dart';

import '../mocks/mock_serie.dart';

class Usuario {
  String email;
  String senha;

  String? uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Usuario({required this.email, required this.senha, this.uid});

  // String? get uid => _uid;
  // set uid(String? uid) => _uid = uid;

  Future<String> salvarUsuario() {
    if (uid == null) {
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
        uid = result.user?.uid;
        _db.collection('users').doc(uid).set({
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

  static Future<Usuario?> login(String usuario, String senha) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usuario,
        password: senha,
      );

      // Se o login for bem-sucedido, preencha um objeto Usuario com os dados obtidos
      User? user = userCredential.user;

      if (user != null) {
        // Recupere os detalhes do usuário do Firebase
        User firebaseUser = FirebaseAuth.instance.currentUser!;
        String userEmail = firebaseUser.email ?? '';
        String userId = firebaseUser.uid;

        // Preencha o objeto Usuario com os dados do Firebase
        Usuario usuario = Usuario(email: userEmail, senha: senha, uid: userId);
        return usuario;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Erro de login: $e");
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      debugPrint('Erro ao excluir o usuário: $e');
    }
  }

  Future<String> atualizarEmailESenha(
    String novoEmail,
    String novaSenha,
  ) async {
    User? user = FirebaseAuth.instance.currentUser!;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: senha,
      );

      user.reauthenticateWithCredential(credential).then(
        (value) async {
          await user.updateEmail(novoEmail);
          await user.updatePassword(novaSenha);
          email = novoEmail;
          senha = novaSenha;
        },
      );
      return "Email e senha atualizados com sucesso";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else {
        return 'Erro ao atualizar email/senha: ${e.message}';
      }
    } catch (e) {
      return 'Erro ao atualizar email/senha: $e';
    }
  }
}
