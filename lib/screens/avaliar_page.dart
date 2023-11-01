import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/components/botao_padrao.dart';
import 'package:und1_mobile/models/producao_model.dart';
import 'package:und1_mobile/models/avaliacao_model.dart';

class Avaliar extends StatefulWidget {
  const Avaliar({
    super.key,
  });

  @override
  State<Avaliar> createState() => _AvaliarState();
}

class _AvaliarState extends State<Avaliar> {
  int nota = 0;
  String comentario = "";
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var avaliacao = context.watch<Avaliacao>();
    var producoes = context.watch<ProducaoModel>();
    var producao = producoes.producaoAtual;
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar Produção'),
      ),
      body: Center(
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
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (ratingValue) {
                        setState(() {
                          nota = ratingValue.round();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Comentário',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      comentario = value;
                    });
                  },
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: SizedBox(
                  width: 200,
                  child: BotaoPadrao(
                    onPressed: () => avaliacao.addAvaliacao(
                      producao,
                      nota.toString(),
                      comentario,
                      user!.uid,
                      producao,
                    ),
                    texto: 'Avaliar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
