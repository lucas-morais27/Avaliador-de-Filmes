import 'package:flutter/material.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<StatefulWidget> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  var _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: cores.secondaryContainer,
        appBar: AppBar(
          title: const Text(
            'Novo usuário',
            style: estiloTitulo3,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _loginController,
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
                          Expanded(
                              child: SizedBox(
                            width: 0,
                          )),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Usuario novoUsuario = Usuario(
                                      email: _loginController.text,
                                      senha: _senhaController.text);
                                  var result =
                                      await novoUsuario.salvarUsuario();
                                  var corSnackBar = result.isEmpty
                                      ? Colors.green
                                      : Colors.red;
                                  if (result.isEmpty) {
                                    result = 'Usuário cadastrado com sucesso.';
                                    Navigator.of(context).pop();
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        result,
                                        style: estiloSubTitulo3,
                                      ),
                                    ),
                                    backgroundColor: corSnackBar,
                                  ));
                                }
                              },
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll<EdgeInsets>(
                                    EdgeInsets.all(16)),
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
                              ),
                              child: Text("Cadastrar-se"))
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
