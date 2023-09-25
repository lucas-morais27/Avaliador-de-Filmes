import 'package:flutter/material.dart';
import 'package:und1_mobile/components/card_producao.dart';
import 'package:und1_mobile/components/cards_de_producoes.dart';
import 'package:und1_mobile/mocks/mock_filme.dart';
import 'package:und1_mobile/models/Producao.dart';
import 'package:und1_mobile/styles.dart';

import '../mocks/mock_serie.dart';
import 'detalhes_filme.dart';

class PaginaInicial extends StatefulWidget {
  final List<dynamic> producoes;
  final Function(int) gostei;
  final Function(int) naoGostei;
  const PaginaInicial(this.gostei, this.naoGostei, {super.key, required this.producoes});

  @override
  State<PaginaInicial> createState() =>
      _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  late List<Widget> _screens;
  final List<String> _titulosDaPagina = [
    'Filmes Não Curtidos',
    'Não Avaliados',
    'Filmes Curtidos'
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      const Text(
        'Index 0: Não Gostei',
        style: optionStyle,
      ),
      /*const Text(
        'Index 1: Não avaliados',
        style: optionStyle,
      ),*/
      CardsDeProducoes(widget.gostei, widget.naoGostei, producoes: widget.producoes),
      //CardsDeProducoes(widget.gostei, widget.naoGostei, widget.pular, producoes: widget.producoes),
      const Text('Index 2: Gostei', style: optionStyle,)
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
      appBar: AppBar(
        title: Center(child: Text(_titulosDaPagina[_selectedIndex], style: estiloSubTitulo1,)),
      ),
      body: Center(
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
