import 'package:flutter/material.dart';

class ModalConfirmacao extends StatelessWidget {
  final String title;
  final String content;
  final Function(bool) onConfirmed;

  const ModalConfirmacao({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme cores = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            onConfirmed(true); // Chama a função de confirmação com true
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(cores.onSecondary),
          ),
          onPressed: () {
            onConfirmed(false); // Chama a função de confirmação com false
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
