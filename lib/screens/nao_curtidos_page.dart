import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../components/lista_producao.dart';
import '../models/producao_model.dart';

class NaoCurtidosPage extends StatefulWidget {
  const NaoCurtidosPage({super.key});

  @override
  State<NaoCurtidosPage> createState() => _NaoCurtidosPageState();
}

class _NaoCurtidosPageState extends State<NaoCurtidosPage> {
  @override
  Widget build(BuildContext context) {
    var producoes = context.watch<ProducaoModel>();

    return ListaProducao(
      producoes.removerNaoCurtido,
      listaProducoes: producoes.naoCurtidos,
    );
  }
}
