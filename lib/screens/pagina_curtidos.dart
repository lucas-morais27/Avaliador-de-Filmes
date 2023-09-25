import 'package:flutter/widgets.dart';

import '../components/lista_producao.dart';

class PaginaCurtidos extends StatefulWidget {
  Function(int) remover;
  List<dynamic> producoes;
  PaginaCurtidos(this.remover, {required this.producoes});

  @override
  State<PaginaCurtidos> createState() => _PaginaCurtidosState();
}

class _PaginaCurtidosState extends State<PaginaCurtidos> {
  @override
  Widget build(BuildContext context) {
    return ListaProducao(widget.remover, listaProducoes: widget.producoes);
  }
}
