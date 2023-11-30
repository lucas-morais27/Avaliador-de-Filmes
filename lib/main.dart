import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/screens/avaliar_page.dart';
import 'package:und1_mobile/screens/detalhes_filme_page.dart';
import 'package:und1_mobile/screens/detalhes_serie_page.dart';
import 'package:und1_mobile/screens/inicial_page.dart';
import 'package:und1_mobile/screens/login_page.dart';
import 'package:und1_mobile/screens/perfil_page.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import 'models/foto_provider.dart';
import 'screens/cadastro_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCMKnYQV4lh0LL6v4HWUsA3kgTWsod_zic",
      appId: "1:154519222523:android:3a02843425fe4444b9185e",
      messagingSenderId: "154519222523",
      projectId: "proj-mobile-filmes",
      storageBucket: "gs://proj-mobile-filmes.appspot.com",
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListaAvaliacoes(),
        ),
        ChangeNotifierProvider<FotoProvider>(
          create: (context) => FotoProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ).copyWith(
          colorScheme: lightColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.LOGIN,
        routes: {
          AppRoutes.HOME: (context) => const PaginaInicial(),
          AppRoutes.DETALHES_FILME: (context) => const DetalhesFilmePage(),
          AppRoutes.DETALHES_SERIE: (context) => const DetalhesSerie(),
          AppRoutes.LOGIN: (context) => const LoginPage(),
          AppRoutes.CADASTRO: (context) => const CadastroPage(),
          AppRoutes.AVALIAR: (context) => const Avaliar(),
          AppRoutes.PERFIL: (context) => const PerfilPage(),
        },
      ),
    );
  }
}
