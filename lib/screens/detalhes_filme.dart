import 'package:flutter/material.dart';
import 'package:und1_mobile/mocks/mock_avaliacao.dart';
import 'package:und1_mobile/models/avaliacao.dart';

import '../models/filme.dart';

class DetalhesFilme extends StatelessWidget {
  const DetalhesFilme({super.key, required this.filme});

  final Filme filme;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;
    List<Avaliacao> listaAvaliacoes = [
      mockAvaliacao1,
      mockAvaliacao2,
    ];
    filme.avaliacoes = listaAvaliacoes;

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
                  color: cores.secondary,
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
                Container(
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
                      height: 270,
                      fit: BoxFit.cover,
                      // width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
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
                )
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
              'Avaliações dos usuários: ${listaAvaliacoes.length}',
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
                  final avaliacao = listaAvaliacoes[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${avaliacao.usuario}:',
                            style: TextStyle(
                              color: cores.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                              (starIndex) => Icon(
                                Icons.star,
                                color: starIndex < int.parse(avaliacao.nota)
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
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
          ],
        ),
      ),
    );
  }
}
