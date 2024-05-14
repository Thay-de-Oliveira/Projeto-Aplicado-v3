import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
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
      body: Column(
        children: [
          BarraSuperior(context),
          Expanded(
            child: Column(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: _uploadImage,
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
                      return ListTile(
                        leading: Image.file(File(_imageFiles[index].path)),
                        title: Text('Imagem ${index + 1}'),
                      );
                    },
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
