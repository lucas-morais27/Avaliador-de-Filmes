import 'producao.dart';
import 'avaliacao_model.dart';

class Filme extends Producao {
  final String diretor;

  Filme({
    required String id,
    required String titulo,
    required String sinopse,
    required String posterUrl,
    required String anoLancamento,
    required List<Avaliacao>? avaliacoes,
    required this.diretor,
  }) : super(
          id,
          titulo,
          sinopse,
          posterUrl,
          anoLancamento,
          avaliacoes,
        );
}
