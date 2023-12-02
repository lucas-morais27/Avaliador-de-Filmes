import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService extends ChangeNotifier {
  final LocalAuthentication auth;

  LocalAuthService({required this.auth});

  Future<bool> biometriaEstaDisponivel() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics && await auth.isDeviceSupported();
  }

  Future<bool> autenticar() async {
    return await auth.authenticate(
      localizedReason: 'Por favor, autentique-se para continuar para o aplicativo.',
    );
  }
}