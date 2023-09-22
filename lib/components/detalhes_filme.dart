import 'package:flutter/material.dart';

import '../models/filme.dart';

class DetalhesFilme extends StatelessWidget {
  const DetalhesFilme({super.key, required this.filme});

  final Filme filme;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
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
            const SizedBox(
              height: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: AssetImage(filme.posterUrl),
                // fit: BoxFit.cover,
                // width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Diretor: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filme.diretor,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Ano de Lançamento: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filme.anoLancamento,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Sinopse:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              filme.sinopse,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Avaliações:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // if (filme.avaliacoes != null)
            //   ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: filme.avaliacoes!.length,
            //     itemBuilder: (context, index) {
            //       final avaliacao = filme.avaliacoes![index];
            //       return ListTile(
            //         title: Text('Avaliação ${index + 1}'),
            //         // subtitle: Text(avaliacao.comentario),
            //         // Outros detalhes da avaliação, como pontuação, podem ser adicionados aqui.
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}
