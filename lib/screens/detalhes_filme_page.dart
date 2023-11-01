import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/avaliacao_model.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/screens/avaliar_page.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import '../models/filme.dart';

class DetalhesFilmePage extends StatelessWidget {
  const DetalhesFilmePage({super.key});

  @override
  Widget build(BuildContext context) {
    var filme = ModalRoute.of(context)?.settings.arguments as Filme;
    final ColorScheme cores = Theme.of(context).colorScheme;

    var lista = context.watch<ListaAvaliacoes>();
    filme.avaliacoes = lista.avaliacoesPorProducao(filme.id);

    return Scaffold(
      backgroundColor: const Color.fromARGB(52, 150, 9, 9),
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    filme.titulo,
                    style: TextStyle(
                      color: cores.onSecondary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white30, // Cor da borda
                          width: 2.0, // Largura da borda
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: Image.network(filme.posterUrl).image,
                          //height: 270,
                          fit: BoxFit.fill,
                          // width: double.infinity,
                        ),
                      ),
                    )),
                const Expanded(child: SizedBox()),
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filme.diretor,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Diretor ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          filme.anoLancamento,
                          style: TextStyle(
                            fontSize: 18,
                            color: cores.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Lançamento ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Sinopse:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cores.onSecondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              filme.sinopse,
              style: TextStyle(
                fontSize: 16,
                color: cores.onSecondary,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Avaliações dos usuários: ${filme.avaliacoes.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cores.onSecondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (filme.avaliacoes != null)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filme.avaliacoes!.length,
                itemBuilder: (context, index) {
                  final avaliacao = filme.avaliacoes[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (Usuario.uid == avaliacao.userid) {
                            Navigator.of(context).pushNamed(
                              AppRoutes.AVALIAR,
                              arguments: {
                                'producaoid': filme.id,
                                'avaliacao': avaliacao,
                              },
                            );
                          }
                        },
                        child: Row(
                          children: [
                            FutureBuilder(
                              future: Usuario.emailDoUsuario(avaliacao.userid),
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data}:',
                                    style: TextStyle(
                                      color: cores.onSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: List.generate(
                                5,
                                (starIndex) => Icon(
                                  Icons.star,
                                  color:
                                      starIndex < double.parse(avaliacao.nota)
                                          ? Colors.orange
                                          : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        avaliacao.comentario ?? "",
                        style: TextStyle(
                          color: cores.onSecondary,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Espaçamento entre as avaliações
                    ],
                  );
                },
              ),
            if(!lista.jaAvaliou(filme.id, Usuario.uid!))
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.AVALIAR,
                      arguments: {'producaoid': filme.id});
                },
                child: const Center(
                  child: Text('Adicionar avaliação'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
