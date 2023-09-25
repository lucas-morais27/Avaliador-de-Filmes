import 'package:flutter/material.dart';
import 'package:und1_mobile/styles.dart';

class BotaoPadrao extends StatelessWidget {
  final Function() onPressed;
  final String? texto;
  final Icon? icone;

  const BotaoPadrao({super.key, required this.texto, this.icone, required this.onPressed});
  const BotaoPadrao.icone({super.key, this.texto, required this.icone, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    var cores = Theme.of(context).colorScheme;
    return ElevatedButton(
        onPressed: (){
          onPressed();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(cores.primaryContainer),
          iconColor: MaterialStatePropertyAll<Color>(cores.onPrimaryContainer),
          iconSize: const MaterialStatePropertyAll<double>(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icone != null)
              icone!,
            if(texto != null)
              Text(texto!, style: estiloSubTitulo3.copyWith(color: cores.onPrimaryContainer),)
          ],
        )
    );
  }

}