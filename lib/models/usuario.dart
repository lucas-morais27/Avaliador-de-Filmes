import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/utils/movie_db_service.dart';
import 'package:und1_mobile/utils/shared_preferences.dart';

class Usuario {
  String email;
  String senha;

  static String? uid;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Usuario({required this.email, required this.senha});

  static signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();

    uid = null;
  }

  static deleteAccount() async {
    final db = FirebaseFirestore.instance;

    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser?.delete();
    }

    // await db.collection("users").doc(Usuario.uid).delete().then(
    //   (doc) => print("Document deleted"),
    // );
    uid = null;
  }

  Future<String> salvarUsuario() async {
    if (uid == null) {
      return await _cadastrarUsuario();
    } else {
      return 'Não foi possível atualizar o usuário';
    }
  }

  Future<String> _cadastrarUsuario() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((result) {
        uid = result.user?.uid;
        _db.collection('users').doc(uid).set({
          "email": email,
          "naoAvaliados": [],
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
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usuario,
      password: senha,
    );

    User? user = userCredential.user;

    if (user != null) {
      User firebaseUser = FirebaseAuth.instance.currentUser!;
      String userEmail = firebaseUser.email ?? '';
      String userId = firebaseUser.uid;

      Usuario usuario = Usuario(email: userEmail, senha: senha);
      Usuario.uid = userId;
      AppSettings.save(userId);
      return usuario;
    } else {
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

  static Future<bool> atualizarListas(Map<String, List<dynamic>> listas) async {
    if (uid != null) {
      var db = FirebaseFirestore.instance;
      final usuarioRef = db.collection('users').doc(uid);
      usuarioRef.update(
        {
          "naoAvaliados": listas['naoAvaliados']?.map((e) => e.id),
          "curtidos": listas['curtidos']?.map((e) => e.id),
          "naoCurtidos": listas['naoCurtidos']?.map((e) => e.id)
        },
      );

      return true;
    }
    return false;
  }

  static Future<Map<String, List<dynamic>>> carregarListas() async {
    var db = FirebaseFirestore.instance;

    if (uid != null) {
      final userData = db.collection("users").doc(Usuario.uid);
      Map<String, dynamic>? data;
      await userData.get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
        },
      );
      var producoesNaoAvaliadas = data?['naoAvaliados'];
      var producoesNaoCurtidas = data?['naoCurtidos'];
      var producoesCurtidas = data?['curtidos'];

      var naoAvaliadas = [];
      var naoCurtidas = [];
      var curtidos = [];

      producoesNaoAvaliadas.forEach((p) async {
        var prod = await MovieDBService.getProducao(p);
        if (prod != null) {
          naoAvaliadas.add(prod);
        }
      });

      producoesNaoCurtidas.forEach((p) async {
        var prod = await MovieDBService.getProducao(p);
        if (prod != null) {
          naoCurtidas.add(prod);
        }
      });

      producoesCurtidas.forEach((p) async {
        var prod = await MovieDBService.getProducao(p);
        if (prod != null) {
          curtidos.add(prod);
        }
      });

      return {
        'naoAvaliados': naoAvaliadas,
        'naoCurtidos': naoCurtidas,
        'curtidos': curtidos,
      };
    }
    return {
      'naoAvaliados': [],
      'naoCurtidos': [],
      'curtidas': [],
    };
  }

  static Future<String> emailDoUsuario(String id) async {
    var db = FirebaseFirestore.instance;
    Map<String, dynamic>? data;
    var userData = await db.collection('users').doc(id).get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
    );
    return data?['email'];
  }

  static Future<String> imagemDePerfilUsuario(String id) async {
    var db = FirebaseStorage.instance;
    String ref = "images/$id.jpg";
    try {
      var url = await db.ref(ref).getDownloadURL();
      return url;
    } catch (e) {
      return '';
    }
  }
}
