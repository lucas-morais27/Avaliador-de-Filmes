import 'avaliacao_model.dart';

class Producao {
  final String id;
  final String titulo;
  final String sinopse;
  final String posterUrl;
  final String anoLancamento;
  List<Avaliacao> avaliacoes = [];

  Producao(
    this.id,
    this.titulo,
    this.sinopse,
    this.posterUrl,
    this.anoLancamento,
    this.avaliacoes,
  );
}
