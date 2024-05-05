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
    final XFile? picture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraCamera(onFile: (File file) {}),
      ),
    );
    setState(() {
      _imageFile = picture;
    });
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
          // Aqui você pode adicionar qualquer UI adicional, se necessário
          // Como a tela da câmera já será aberta automaticamente,
          // Não é necessário ter um campo de texto
        ),
      ),
    );
  }
}
