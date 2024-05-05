import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'components/barra-superior.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<XFile> _imageFiles = [];

  Future<void> _uploadImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFiles.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: BarraSuperior(context),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Adicionar Imagem'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _imageFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.file(File(_imageFiles[index].path)),
                      title: Text('Imagem ${index + 1}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
