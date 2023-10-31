import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/producao_model.dart';
import 'package:und1_mobile/screens/menu_navegacao_page.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProducaoModel(),
        )
      ],
      child: const MenuNavegacao(),
    );
  }
}
