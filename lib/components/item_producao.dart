import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/filme.dart';
import '../models/serie.dart';
import '../styles.dart';
import '../utils/app_routes.dart';
import 'modal_confirmacao.dart';

class ItemProducao extends StatefulWidget {
  Function(int) remover;
  dynamic producao;
  int index;

  ItemProducao(
    this.remover, {
    super.key,
    required this.producao,
    required this.index,
  });

  @override
  State<ItemProducao> createState() => _ItemProducaoState();
}

class _ItemProducaoState extends State<ItemProducao> {
  void _deletarProducao() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ModalConfirmacao(
            title: "Remover ${widget.producao.titulo}",
            content:
                "Você realmente deseja remover ${widget.producao.titulo} da lista?",
            onConfirmed: (resposta) {
              if (resposta) {
                widget.remover(widget.index);
              }
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    return Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Deletar',
              onPressed: (context) => {_deletarProducao()},
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            if (widget.producao is Filme) {
              Navigator.of(context).pushNamed(
                AppRoutes.DETALHES_FILME,
                arguments: widget.producao,
              );
            } else if (widget.producao is Serie) {
              Navigator.of(context).pushNamed(
                AppRoutes.DETALHES_SERIE,
                arguments: widget.producao,
              );
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: cores.secondary, width: 0.75))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Image.network(
                        widget.producao.posterUrl,
                        fit: BoxFit.fill,
                      )),
                  const Expanded(child: SizedBox()),
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.producao.titulo, style: estiloSubTitulo3),
                        Text(
                            "Ano de lançamento: ${widget.producao.anoLancamento}",
                            style: estiloCorpoTexto3),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
