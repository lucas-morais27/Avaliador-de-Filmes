import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:und1_mobile/models/serie.dart';

import '../models/filme.dart';

class MovieDBService {
  static const _key =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYjQ2N2RkMjk5NDM0NWJmNjI1ZDQ1MGFlZTdiZGMwYiIsInN1YiI6IjYyZGFlOWZlMWM2YWE3MDViN2ZiMjJjNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.naqXrVmfFUVuAYXp-_lCYc5yfloL6Vle4FtTyZCBQYs";
  static const _host = "api.themoviedb.org";
  static const _idioma = 'pt-BR';
  static const _posterHost =
      "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";

  static Future<dynamic> getProducao(String id) async {
    if (id[0] == 's') {
      return await _getSerie(id.substring(1));
    } else {
      return await _getFilme(id.substring(1));
    }
  }

  static Future<Serie?> _getSerie(String id) async {
    var url = Uri.https(_host, "/3/tv/$id", {'language': _idioma});
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_key'
    });

    if (response.statusCode == 200) {
      Map serie = jsonDecode(response.body);
      return Serie(
          id: 's$id',
          titulo: serie['name'] ?? '',
          sinopse: serie['overview'] ?? '',
          posterUrl: "$_posterHost${serie['poster_path'] ?? ''}",
          anoLancamento: serie['first_air_date'] is String &&
                  serie['first_air_date'].isNotEmpty
              ? serie['first_air_date'].substring(0, 4)
              : '',
          avaliacoes: [],
          numeroEpisodios: serie['number_of_episodes'].toString(),
          numeroTemporadas: serie['number_of_seasons'].toString(),
          criador: serie['created_by'].length > 0
              ? serie['created_by'][0]['name']
              : '');
    }

    return null;
  }

  static Future<Filme?> _getFilme(String id) async {
    var url = Uri.https(_host, "/3/movie/$id",
        {'language': _idioma, 'append_to_response': 'credits'});
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_key'
    });

    if (response.statusCode == 200) {
      Map filme = jsonDecode(response.body);
      return Filme(
          id: 'f$id',
          titulo: filme['title'] ?? '',
          sinopse: filme['overview'] ?? '',
          posterUrl: "$_posterHost${filme['poster_path'] ?? ''}",
          anoLancamento: filme['release_date'] is String &&
                  filme['release_date'].isNotEmpty
              ? filme['release_date'].substring(0, 4)
              : '',
          avaliacoes: [],
          diretor: filme['credits']['crew']
              .where((e) => e['job'] == 'Director')
              .toList()[0]['name']);
    }

    return null;
  }

  static Future<List<String>?> adicionarMaisProducoes(int pagina) async {
    var url = Uri.https(_host, "/3/trending/all/week",
        {'language': _idioma, 'page': '$pagina'});
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_key'
      },
    );

    if (response.statusCode == 200) {
      List<String> lista = List.empty(growable: true);
      Map producoes = jsonDecode(response.body);
      producoes['results'].forEach(
        (value) {
          if (value['media_type'] == 'movie') {
            lista.add("f${value['id']}");
          } else if (value['media_type'] == 'tv') {
            lista.add("s${value['id']}");
          }
        },
      );
      return lista;
    }

    return null;
  }
}
