import 'avaliacao.dart';

class Usuario {
  final String id;
  final String nome;
  final String email;
  // final String avatarUrl;
  // Acho que senha fica pra lidar em outras unidades e n acho q deva ficar no cliente tbm
  final List<Avaliacao>
      avaliacoes; // Ou criar um objeto listaAvaliacoes para manipular melhor isso?

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    // required this.avatarUrl,
    required this.avaliacoes,
  });
}
