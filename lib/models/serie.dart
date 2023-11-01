import 'producao.dart';
import 'avaliacao_model.dart';

class Serie extends Producao {
  final String criador;
  final String numeroEpisodios;
  final String numeroTemporadas;
  // final int numeroGostei;
  // final int numeroNaoGostei;

  Serie(
      {required String id,
      required String titulo,
      required String sinopse,
      required String posterUrl,
      required String anoLancamento,
      required List<Avaliacao> avaliacoes,
      required this.numeroEpisodios,
      required this.numeroTemporadas,
      required this.criador})
      : super(
          id,
          titulo,
          sinopse,
          posterUrl,
          anoLancamento,
          avaliacoes,
        );
}
