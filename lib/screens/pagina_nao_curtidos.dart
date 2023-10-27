import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/producao.dart';

import '../components/lista_producao.dart';
import '../models/producao_model.dart';

class PaginaNaoCurtidos extends StatefulWidget {
  PaginaNaoCurtidos();

  @override
  State<PaginaNaoCurtidos> createState() => _PaginaNaoCurtidosState();
}

class _PaginaNaoCurtidosState extends State<PaginaNaoCurtidos> {
  @override
  Widget build(BuildContext context) {
    var producoes = context.watch<ProducaoModel>();

    return ListaProducao(producoes.removerNaoCurtido, listaProducoes: producoes.naoCurtidos);
  }
}
