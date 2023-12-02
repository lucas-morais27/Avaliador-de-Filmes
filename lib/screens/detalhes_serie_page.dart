import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/utils/app_routes.dart';
import '../models/serie.dart';

class DetalhesSerie extends StatelessWidget {
  const DetalhesSerie({super.key});

  Future<Map<String, String?>> carregarComentario(String id) async {
    Map<String, String?> data = {};
    data['avatar'] = await Usuario.imagemDePerfilUsuario(id);
    data['email'] = await Usuario.emailDoUsuario(id);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var serie = ModalRoute.of(context)?.settings.arguments as Serie;
    final ColorScheme cores = Theme.of(context).colorScheme;

    var lista = context.watch<ListaAvaliacoes>();
    serie.avaliacoes = lista.avaliacoesPorProducao(serie.id);

    return Scaffold(
      backgroundColor: const Color.fromARGB(52, 150, 9, 9),
      appBar: AppBar(
        title: const Text('Detalhes da Série'),
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
                    serie.titulo,
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
                          image: Image.network(serie.posterUrl).image,
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
                          serie.anoLancamento,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Lançamento ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          serie.criador,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Criador ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          serie.numeroTemporadas,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Temporadas ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          serie.numeroEpisodios,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Episódios ",
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
              serie.sinopse,
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
              'Avaliações dos usuários: ${serie.avaliacoes.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cores.onSecondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // ignore: unnecessary_null_comparison
            if (serie.avaliacoes != null)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serie.avaliacoes.length,
                itemBuilder: (context, index) {
                  final avaliacao = serie.avaliacoes[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (Usuario.uid == avaliacao.userid) {
                            Navigator.of(context).pushNamed(
                              AppRoutes.AVALIAR,
                              arguments: {
                                'producaoid': serie.id,
                                'avaliacao': avaliacao,
                              },
                            );
                          }
                        },
                        child: FutureBuilder(
                          future: carregarComentario(avaliacao.userid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  snapshot.data!['avatar'] != ''
                                      ? Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  snapshot.data!['avatar']!),
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          size: 32.0,
                                          color: Colors.white,
                                        ),
                                  const SizedBox(width: 8,),
                                  Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${snapshot.data!['email']}:',
                                          style: TextStyle(
                                            color: cores.onSecondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            5,
                                                (starIndex) => Icon(
                                              Icons.star,
                                              color: starIndex <
                                                  double.parse(avaliacao.nota)
                                                  ? Colors.orange
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      avaliacao.comentario ?? "",
                                      style: TextStyle(
                                        color: cores.onSecondary,
                                      ),
                                    ),
                                  ])),
                                ],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Espaçamento entre as avaliações
                    ],
                  );
                },
              ),
            if (!lista.jaAvaliou(serie.id, Usuario.uid!))
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.AVALIAR,
                      arguments: {'producaoid': serie.id});
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
