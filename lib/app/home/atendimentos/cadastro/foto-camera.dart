import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'tela-atendimento-forms.dart'; // Certifique-se de importar a tela AtendimentoForms

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final TextEditingController _controller = TextEditingController();
  XFile? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // Chamar a função para abrir a câmera automaticamente ao entrar na página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _takePicture();
    });
  }

  Future<void> _takePicture() async {
    // Abre a tela da câmera e aguarda a captura da imagem
    final XFile? picture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraCamera(
          onFile: (File file) {
            Navigator.pop(context, XFile(file.path));
          },
        ),
      ),
    );

    // Verifica se uma imagem foi capturada
    if (picture != null) {
      // Atualiza o estado com a imagem capturada
      setState(() {
        _imageFile = picture;
      });

      // Converte a imagem para PNG e faz o upload para o Firebase Storage
      await _uploadFileToFirebase(picture);
    }
  }

  Future<void> _uploadFileToFirebase(XFile image) async {
    try {
      // Converte a imagem para PNG
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final String contentType = 'image/png';
      final Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      final SettableMetadata metadata = SettableMetadata(contentType: contentType);

      UploadTask uploadTask;

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        uploadTask = ref.putData(bytes, metadata);
      } else {
        final File file = File(image.path);
        uploadTask = ref.putFile(file, metadata);
      }

      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        setState(() {
          _imageUrl = downloadURL;
        });
        print('File uploaded: $downloadURL');
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AtendimentoForms()),
              );
            },
          ),
        ),
        body: Center(
          child: _imageFile == null
              ? Text('Capturando imagem...')
              : (kIsWeb
                  ? (_imageUrl != null
                      ? Image.network(_imageUrl!)
                      : CircularProgressIndicator())
                  : Image.file(File(_imageFile!.path))),
        ),
      ),
    );
  }
}
