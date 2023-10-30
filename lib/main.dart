import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:und1_mobile/models/producao.dart';
import 'package:und1_mobile/screens/detalhes_filme.dart';
import 'package:und1_mobile/screens/detalhes_serie.dart';
import 'package:und1_mobile/screens/menu_navegacao.dart';
import 'package:und1_mobile/screens/pagina_cadastro.dart';
import 'package:und1_mobile/screens/pagina_incial.dart';
import 'package:und1_mobile/screens/pagina_login.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mocks/mock_filme.dart';
import 'mocks/mock_serie.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyCMKnYQV4lh0LL6v4HWUsA3kgTWsod_zic",
      appId: "1:154519222523:android:3a02843425fe4444b9185e",
      messagingSenderId: "154519222523",
      projectId: "proj-mobile-filmes",
    ),
  );
  
  runApp(MainApp());
}

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
      initialRoute: AppRoutes.LOGIN,
      routes: {
        AppRoutes.HOME: (context) => PaginaInicial(),
        AppRoutes.DETALHES_FILME: (context) => DetalhesFilme(),
        AppRoutes.DETALHES_SERIE: (context) => DetalhesSerie(),
        AppRoutes.LOGIN: (context) => PaginaLogin(),
        AppRoutes.CADASTRO: (context) => PaginaCadastro()
      },
    );
  }
}
