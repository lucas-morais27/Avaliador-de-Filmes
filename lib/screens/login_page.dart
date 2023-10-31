import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      // resizeToAvoidBottomInset: false,
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: cores.onSecondary),
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
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: cores.onSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  String email = _usuarioController.text;
                  String senha = _senhaController.text;

                  // Fazer lógica de Login
                  print('Usuário: $email');
                  print('Senha: $senha');
                },
                child: const Text(
                  'Entrar',
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
