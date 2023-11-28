import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/botao_padrao.dart';
import 'package:und1_mobile/models/avaliacao_model.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/models/usuario.dart';

class Avaliar extends StatefulWidget {
  const Avaliar({
    super.key,
  });

  @override
  State<Avaliar> createState() => _AvaliarState();
}

class _AvaliarState extends State<Avaliar> {
  double? _rating;
  double _initialRating = 1.0;

  @override
  void initState() {
    super.initState();
    //_rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    var avaliacoes = context.watch<ListaAvaliacoes>();
    var argument =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final producaoid = argument['producaoid'];
    Avaliacao? avaliacao = argument['avaliacao'];
    TextEditingController comentarioController = TextEditingController();

    if (avaliacao != null) {
      comentarioController.text = avaliacao.comentario!;
      double? notaCarregada = double.tryParse(avaliacao.nota);
      if (notaCarregada != null) {
        _initialRating = notaCarregada;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliar Produção'),
        actions: [
          if (avaliacao != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => {
                avaliacoes.remover(avaliacao),
                Navigator.of(context).pop(),
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      RatingBar.builder(
                        maxRating: 5,
                        initialRating: _initialRating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 40.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (ratingValue) {
                          setState(() {
                            _rating = ratingValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: comentarioController,
                    decoration: const InputDecoration(
                      labelText: 'Comentário',
                    ),
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: 200,
                    child: BotaoPadrao(
                      onPressed: () {
                        if (_rating == null) {
                          double? notaCarregada =
                              double.tryParse(avaliacao!.nota);
                          if (notaCarregada != null) {
                            _rating = notaCarregada;
                          } else {
                            _rating = _initialRating;
                          }
                        }
                        if (avaliacao == null) {
                          avaliacoes.adicionar(Avaliacao(
                              producaoid: producaoid,
                              userid: Usuario.uid!,
                              nota: _rating.toString(),
                              comentario: comentarioController.text));
                        } else {
                          avaliacoes.editar(Avaliacao.id(
                              id: avaliacao.id,
                              producaoid: producaoid,
                              userid: Usuario.uid!,
                              nota: _rating.toString(),
                              comentario: comentarioController.text));
                        }
                        Navigator.of(context).pop();
                      },
                      texto: avaliacao == null ? 'Adicionar' : 'Editar',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
