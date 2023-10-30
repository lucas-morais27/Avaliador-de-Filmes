import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

class PaginaLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaginaLoginState();

}

class _PaginaLoginState extends State<PaginaLogin> {


  @override
  Widget build(BuildContext context) {
    var cores = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.CADASTRO);
          },
          child: Text('Cadastre-se', style: estiloSubTitulo4.copyWith(color: cores.onPrimary),),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.HOME);
          },
          child: Text('Entrar',style: estiloSubTitulo4.copyWith(color: cores.onPrimary)),
        ),
    ]
    );
  }

}