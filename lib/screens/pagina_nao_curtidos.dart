import 'package:flutter/widgets.dart';

import '../components/lista_producao.dart';

class PaginaNaoCurtidos extends StatefulWidget {
  Function(int) remover;
  List<dynamic> producoes;
  PaginaNaoCurtidos(this.remover, {super.key, required this.producoes});

  @override
  State<PaginaNaoCurtidos> createState() => _PaginaNaoCurtidosState();
}

class _PaginaNaoCurtidosState extends State<PaginaNaoCurtidos> {
  @override
  Widget build(BuildContext context) {
    return ListaProducao(widget.remover, listaProducoes: widget.producoes);
  }
}
