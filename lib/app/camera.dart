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

  Future<void> _uploadImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Widget'),
        ),
        body: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Registro da vistoria',
            labelStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _takePicture,
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: _uploadImage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
