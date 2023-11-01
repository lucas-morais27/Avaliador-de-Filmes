import 'package:flutter/material.dart';
import 'package:und1_mobile/screens/filmes_nao_avaliados_page.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import 'curtidos_page.dart';
import 'nao_curtidos_page.dart';

class MenuNavegacao extends StatefulWidget {
  const MenuNavegacao({super.key});

  @override
  State<MenuNavegacao> createState() => _MenuNavegacaoState();
}

class _MenuNavegacaoState extends State<MenuNavegacao> {
  int _selectedIndex = 1;

  // static const TextStyle optionStyle = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );

  late List<Widget> _screens;
  final List<String> _titulosDaPagina = [
    'Não Curtidos',
    'Não Avaliados',
    'Curtidos'
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      const NaoCurtidosPage(),
      const PaginaFilmesNaoAvaliadosPage(),
      const CurtidosPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.secondary,
      appBar: AppBar(
        title: Center(
            child: Text(
          _titulosDaPagina[_selectedIndex],
          style: estiloTitulo3,
        )),
        actions: 
          <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.CONFIGURACOES);
                },
                child: const Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              ),
            ),
          ],
      ),

      body: Container(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_down),
            label: 'Não gostei',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Não avaliados',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Gostei',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: cores.onPrimary,
        unselectedItemColor: cores.onSecondaryContainer,
        onTap: _onItemTapped,
        backgroundColor: cores.onBackground,
      ),
    );
  }
}
