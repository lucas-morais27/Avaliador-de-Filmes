import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/screens/avaliar_page.dart';
import 'package:und1_mobile/screens/detalhes_filme_page.dart';
import 'package:und1_mobile/screens/detalhes_serie_page.dart';
import 'package:und1_mobile/screens/inicial_page.dart';
import 'package:und1_mobile/screens/login_page.dart';
import 'package:und1_mobile/screens/perfil_page.dart';
import 'package:und1_mobile/screens/splash_page.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';
import 'package:und1_mobile/utils/local_auth_service.dart';
import 'package:und1_mobile/utils/notification_service.dart';

import 'models/foto_provider.dart';
import 'models/producao_model.dart';
import 'screens/cadastro_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCMKnYQV4lh0LL6v4HWUsA3kgTWsod_zic",
      appId: "1:154519222523:android:3a02843425fe4444b9185e",
      messagingSenderId: "154519222523",
      projectId: "proj-mobile-filmes",
      storageBucket: "gs://proj-mobile-filmes.appspot.com",
    ),
  );
  await NotificationService().initNotifications();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    super.initState();
  }

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
        ChangeNotifierProvider(
          create: (context) => ProducaoModel(),
        ),
        ChangeNotifierProvider(create: (context) => LocalAuthService(auth: LocalAuthentication()))
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ).copyWith(
          colorScheme: lightColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.LOGIN,
        navigatorKey: navigatorKey,
        routes: {
          AppRoutes.SPLASH: (context) => const SplashScreen(),
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
