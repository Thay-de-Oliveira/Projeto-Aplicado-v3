import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ftpconnect/ftpconnect.dart';



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

    // Envia a imagem para o servidor FTP
    /*final ftp = FTPConnect('hostname', user: 'username', pass: 'password');
    try {
      await ftp.connect();
      await ftp.changeDirectory('directory_on_server');
      await ftp.uploadFile(File(picture.path), 'remote_filename.jpg');
      print('Imagem enviada com sucesso para o servidor FTP');
    } catch (e) {
      print('Erro ao enviar imagem para o servidor FTP: $e');
    } finally {
      ftp.disconnect();
    }*/
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
          title: Text('Camera'),
        ),
        body: Center(
          //Camera abre automaticamente
        ),
      ),
    );
  }
}

