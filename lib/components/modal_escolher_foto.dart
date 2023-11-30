// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:und1_mobile/models/foto_provider.dart';

import '../models/usuario.dart';
import 'botao_padrao.dart';

class ModalEscolherFoto extends StatelessWidget {
  const ModalEscolherFoto({
    super.key,
  });

  Future _pickImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    return image;
  }

  Future _pickImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

  Future pickAndUploadImageFromCamera(BuildContext context) async {
    XFile? file = await _pickImageFromCamera();
    if (file != null) {
      await upload(file.path, context);
    }
  }

  Future pickAndUploadImageFromGallery(BuildContext context) async {
    XFile? file = await _pickImageFromGallery();
    if (file != null) {
      await upload(file.path, context);
    }
  }

  Future upload(String path, BuildContext context) async {
    File file = File(path);
    try {
      String ref = "images/${Usuario.uid}.jpg";
      final storage = FirebaseStorage.instance;
      storage.ref(ref).putFile(file);

      String newPath = await storage.ref(ref).getDownloadURL();
      Provider.of<FotoProvider>(context, listen: false).fotoUrl = newPath;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Escolha como quer adicionar sua foto",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        BotaoPadrao(
          onPressed: () async {
            await pickAndUploadImageFromCamera(context);
            Navigator.of(context).pop();
          },
          texto: 'Tirar foto',
        ),
        BotaoPadrao(
          onPressed: () async {
            await pickAndUploadImageFromGallery(context);
            Navigator.of(context).pop();
          },
          texto: 'Escolher na galeria',
        ),
      ],
    );
  }
}
