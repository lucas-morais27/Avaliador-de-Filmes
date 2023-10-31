import 'package:flutter/material.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/utils/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.onSecondaryContainer,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 16),
              Image.asset(
                "assets/clapper.png",
                height: 290,
              ),
              const SizedBox(height: 32),
              TextFormField(
                style: TextStyle(color: cores.onSecondary, fontSize: 18),
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(color: cores.onSecondary),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cores.primary,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cores.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: cores.onSecondary, fontSize: 18),
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: cores.onSecondary),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cores.primary,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cores.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  String email = _usuarioController.text;
                  String senha = _senhaController.text;

                  if (await Usuario.login(email, senha)) {
                    if (!context.mounted) {
                      return;
                    }

                    Navigator.of(context).pushNamed(AppRoutes.HOME);
                  }
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CADASTRO);
                },
                child: const Text(
                  'Cadastre-se',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
