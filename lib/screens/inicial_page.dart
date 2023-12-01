import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/producao_model.dart';
import 'package:und1_mobile/screens/menu_navegacao_page.dart';

import '../models/avaliacao_model.dart';
import '../models/foto_provider.dart';
import '../models/lista_avaliacoes.dart';
import '../models/usuario.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  carregarDados(BuildContext context) async {
    await Provider.of<ProducaoModel>(context, listen: false).carregarListas();
    List<Avaliacao> avaliacoes = await Avaliacao.carregarAvaliacoes();
    if(context.mounted) Provider.of<ListaAvaliacoes>(context, listen: false).avaliacoes = avaliacoes;
    try {
      final storage = FirebaseStorage.instance;
      await storage
          .ref('images/${Usuario.uid!}.jpg')
          .getDownloadURL()
          .then((value) {
        Provider.of<FotoProvider>(
          context,
          listen: false,
        ).fotoUrl = value;
      });
    } catch (error) {
      if (error is FirebaseException &&
          error.code == 'object-not-found') {
        debugPrint('Foto não encontrada');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: carregarDados(context),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          :  const MenuNavegacao(),
    );
  }
}
