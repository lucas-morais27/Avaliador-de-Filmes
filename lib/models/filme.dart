import 'avaliacao.dart';

class Filme {
  final String id;
  final String titulo;
  final String sinopse;
  final String diretor;
  final String posterUrl;
  final String anoLancamento;
  final List<Avaliacao>? avaliacoes;

  Filme({
    required this.id,
    required this.titulo,
    required this.sinopse,
    required this.diretor,
    required this.posterUrl,
    required this.anoLancamento,
    required this.avaliacoes,
  });
}
