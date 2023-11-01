import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/lista_avaliacoes.dart';
import 'package:und1_mobile/models/producao_model.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import '../models/avaliacao_model.dart';
import '../styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  var _senhaVisivel = false;

  Future<void> _showLoginErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro no login'),
          content: const Text(
            'Ocorreu um problema durante o login. Verifique suas credenciais e tente novamente.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    var listaAvaliacoes = context.watch<ListaAvaliacoes>();
    //var producoes = Provider.of(context).watch<ProducaoModel>();
    ButtonStyle _buttonStyle = ButtonStyle(
      padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.all(12)),
      shape: MaterialStatePropertyAll<
          RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(32))),
      backgroundColor:
      MaterialStatePropertyAll<Color>(
          cores.primaryContainer),
      foregroundColor:
      MaterialStatePropertyAll<Color>(
          cores.onPrimaryContainer),
      textStyle:
      const MaterialStatePropertyAll<TextStyle>(
          estiloSubTitulo3),
    );

    return Scaffold(
      backgroundColor: cores.onPrimaryContainer,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: estiloTitulo3,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 16),
                  Image.asset(
                    "assets/clapper.png",
                    height: 150,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usuarioController,
                    style: TextStyle(color: cores.onSecondaryContainer),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: !_senhaVisivel,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma senha.';
                      } else if (value.length < 8) {
                        return 'A senha deve ter pelo menos 8 caracteres.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Pelo menos 8 caracteres',
                        hintStyle: estiloCorpoTexto3,
                        icon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _senhaVisivel = !_senhaVisivel;
                            });
                          },
                          icon: _senhaVisivel
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        )),
                  ),
                  const Expanded(child: SizedBox(height: 16,)),
                  ElevatedButton(
                      onPressed: () async {
                        String email = _usuarioController.text;
                        String senha = _senhaController.text;

                        try {
                          Usuario? usuarioLogado = await Usuario.login(email, senha);
                          if (usuarioLogado != null) {
                            if (!context.mounted) {
                              return;
                            }

                            // Passei o usuário pra frente, vai que precisa em outro lugar
                            Map<String, List<dynamic>> listas = await Usuario.carregarListas();
                            List<Avaliacao> avaliacoes = await Avaliacao.carregarAvaliacoes();
                            listaAvaliacoes.avaliacoes = avaliacoes;
                            Map<String, dynamic> argument = {
                              'listas': listas
                            };
                            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME, arguments: argument);
                          }
                        } catch (e) {
                          _showLoginErrorDialog(context);
                        }
                      },
                      child: const Text(
                        'Entrar',
                      ),
                      style: _buttonStyle
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.CADASTRO);
                    },
                    style: _buttonStyle,
                    child: const Text(
                      'Cadastre-se',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
