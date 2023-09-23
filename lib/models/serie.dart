import 'avaliacao.dart';

class Serie {
  final String id;
  final String titulo;
  final String sinopse;
  final String diretor;
  final String posterUrl;
  final String anoLancamento;
  final String numeroEpisodios;
  final String numeroTemporadas;
  // final int numeroGostei;
  // final int numeroNaoGostei;
  List<Avaliacao>? avaliacoes;

  Serie({
    required this.id,
    required this.titulo,
    required this.sinopse,
    required this.diretor,
    required this.posterUrl,
    required this.anoLancamento,
    required this.numeroEpisodios,
    required this.numeroTemporadas,
    required this.avaliacoes,
  });
}
