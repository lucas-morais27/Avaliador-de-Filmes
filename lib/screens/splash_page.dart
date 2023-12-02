import 'package:flutter/material.dart';
import 'package:und1_mobile/utils/app_routes.dart';
import 'package:und1_mobile/utils/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2));
    Future.wait([
      AppSettings.isAuth(),
    ]).then((value) => value[0]
        ? Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)
        : Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN));
  }

  @override
  Widget build(BuildContext context) {
    // Pode mostrar uma tela de carregamento aqui se necessário
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}