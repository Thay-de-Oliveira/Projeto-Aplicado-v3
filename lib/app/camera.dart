import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final TextEditingController _controller = TextEditingController();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    // Chamar a função para abrir a câmera automaticamente ao entrar na página
    _takePicture();
  }

  Future<void> _takePicture() async {
  // Abre a tela da câmera e aguarda a captura da imagem
  final XFile? picture = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CameraCamera(onFile: (File file) {}),
    ),
  );

  // Verifica se uma imagem foi capturada
  if (picture != null) {
    // Atualiza o estado com a imagem capturada
    setState(() {
      _imageFile = picture;
    });

    // Faça qualquer processamento adicional necessário com a imagem capturada aqui
    // Por exemplo, você pode enviar a imagem para um servidor, salvá-la no dispositivo, etc.
  }
}

  /*Future<void> _uploadImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Widget'),
        ),
        body: Center(
          //Camera abre automaticamente
        ),
      ),
    );
  }
}
