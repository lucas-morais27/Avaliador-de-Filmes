import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../components/lista_producao.dart';
import '../models/producao_model.dart';

class PaginaCurtidos extends StatefulWidget {

  @override
  State<PaginaCurtidos> createState() => _PaginaCurtidosState();
}

class _PaginaCurtidosState extends State<PaginaCurtidos> {
  @override
  Widget build(BuildContext context) {
    var producoes = context.watch<ProducaoModel>();
    return ListaProducao(producoes.removerCurtido, listaProducoes: producoes.curtidos);
  }
}
