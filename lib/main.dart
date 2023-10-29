import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:und1_mobile/screens/detalhes_filme.dart';
import 'package:und1_mobile/screens/detalhes_serie.dart';
import 'package:und1_mobile/screens/pagina_incial.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ).copyWith(
        colorScheme: lightColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME,
      routes: {
        AppRoutes.HOME: (context) => const PaginaInicial(),
        AppRoutes.DETALHES_FILME: (context) => const DetalhesFilme(),
        AppRoutes.DETALHES_SERIE: (context) => const DetalhesSerie()
      },
    );
  }
}
