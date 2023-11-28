import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../components/lista_producao.dart';
import '../models/producao_model.dart';

class CurtidosPage extends StatefulWidget {
  const CurtidosPage({super.key});

  @override
  State<CurtidosPage> createState() => _CurtidosPageState();
}

class _CurtidosPageState extends State<CurtidosPage> {
  @override
  Widget build(BuildContext context) {
    var producoes = context.watch<ProducaoModel>();
    return ListaProducao(
      producoes.removerCurtido,
      listaProducoes: producoes.curtidos,
    );
  }
}
