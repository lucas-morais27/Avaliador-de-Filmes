import 'package:flutter/material.dart';
import '../models/serie.dart'; // Importe o modelo Serie

class DetalhesSerie extends StatelessWidget {
  final Serie serie;

  const DetalhesSerie({super.key, required this.serie});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Série'),
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
                  serie.titulo,
                  style: TextStyle(
                    color: cores.onSecondary,
                    fontSize: 28,
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
                image: AssetImage(
                  serie.posterUrl,
                ),
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
                  serie.diretor, // Atualize para serie.diretor
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
                  serie.anoLancamento,
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
                  "Número de Temporadas: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  serie.numeroTemporadas,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Número de Episódios: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  serie.numeroEpisodios,
                  style: const TextStyle(fontSize: 18),
                )
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
              serie.sinopse,
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

            // if (serie.avaliacoes != null)
            //   ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: serie.avaliacoes!.length,
            //     itemBuilder: (context, index) {
            //       final avaliacao = serie.avaliacoes![index];
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
