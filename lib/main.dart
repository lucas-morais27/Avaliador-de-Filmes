import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:und1_mobile/screens/detalhes_filme.dart';
import 'package:und1_mobile/screens/detalhes_serie.dart';
import 'package:und1_mobile/screens/pagina_inicial.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import 'mocks/mock_filme.dart';
import 'mocks/mock_serie.dart';
import 'models/Producao.dart';


void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

}

class _MainAppState extends State<MainApp> {
  final List<dynamic> naoAvaliados = [];
  final List<dynamic> curtidos = [];
  final List<dynamic> naoCurtidos = [];

  _naoGostei(int index){
    setState(() {
      debugPrint(naoAvaliados[index].titulo);
      naoCurtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
    });
  }

  _gostei(int index){
    setState(() {
      debugPrint(naoAvaliados[index].titulo);
      curtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
    });
  }

  @override
  void initState() {
    naoAvaliados.addAll(FILMES);
    naoAvaliados.addAll(SERIES);
    naoAvaliados.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ).copyWith(
        colorScheme: lightColorScheme,
      ),
      initialRoute: AppRoutes.HOME,
      routes: {
        AppRoutes.HOME: (context) => PaginaInicial(_gostei, _naoGostei, producoes: naoAvaliados,),
        AppRoutes.DETALHES_FILME: (context) => DetalhesFilme(filme: FILMES[0]),
        AppRoutes.DETALHES_SERIE: (context) => DetalhesSerie(serie: SERIES[0])
      },
    );
  }
}
