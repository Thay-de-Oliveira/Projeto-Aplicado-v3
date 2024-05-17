import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'components/barra-superior.dart';
import 'tela-atendimento-forms.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<XFile> _imageFiles = [];
  List<String> _uploadedUrls = [];

  Future<void> _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFiles.add(image);
      });
    }
  }

  Future<void> _uploadFiles() async {
    for (var image in _imageFiles) {
      try {
        String fileExtension = image.path.split('.').last; // Pegando a extensão do arquivo
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExtension'; // Adicionando a extensão ao nome do arquivo
        Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask;

        if (kIsWeb) {
          uploadTask = ref.putData(await image.readAsBytes());
        } else {
          File file = File(image.path);
          uploadTask = ref.putFile(file);
        }

        await uploadTask.whenComplete(() async {
          String downloadURL = await ref.getDownloadURL();
          _uploadedUrls.add(downloadURL);
          print('File uploaded: $downloadURL');
        });
      } catch (e) {
        print('Error uploading file: $e');
      }
    }

    // Exibir uma mensagem de sucesso e limpar a lista de arquivos
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Imagens salvas com sucesso!')));
    setState(() {
      _imageFiles.clear();
    });
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  void _cancelUpload() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AtendimentoForms()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BarraSuperior(context),
          Expanded(
            child: Column(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: _pickImage,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [6, 3],
                    color: Color(0xFF696161),
                    strokeWidth: 2,
                    child: Container(
                      width: 295,
                      height: 206,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            size: 40,
                            color: Color(0xFF696262),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Adicionar arquivos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '(PNG, JPEG e MP4)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF696262),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _imageFiles.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ListTile(
                            leading: kIsWeb
                                ? Image.network(_imageFiles[index].path)
                                : Image.file(File(_imageFiles[index].path)),
                            title: Text('Imagem ${index + 1}'),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              icon: Icon(Icons.cancel, size: 20, color: Colors.red),
                              onPressed: () => _removeImage(index),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _cancelUpload,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: _uploadFiles,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1B7CB3),
                        ),
                        child: Text('Salvar', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
